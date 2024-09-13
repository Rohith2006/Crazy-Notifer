import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app/models/user_model.dart' as UserModel;

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserModel.User? _user;
  UserModel.User? get user => _user;

  Future<UserModel.User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _signInWithCredential(credential);
    } catch (error) {
      if (kDebugMode) {
        print('Error during Google Sign-In: $error');
      }
      rethrow;
    }
  }

  Future<UserModel.User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _updateUserModel(userCredential.user);
    } catch (error) {
      if (kDebugMode) {
        print('Error during Email/Password Sign-In: $error');
      }
      rethrow;
    }
  }

  Future<UserModel.User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _updateUserModel(userCredential.user);
    } catch (error) {
      if (kDebugMode) {
        print('Error during Email/Password Sign-Up: $error');
      }
      rethrow;
    }
  }

  Future<UserModel.User?> _signInWithCredential(AuthCredential credential) async {
    try {
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return _updateUserModel(userCredential.user);
    } catch (error) {
      if (kDebugMode) {
        print('Error during credential sign-in: $error');
      }
      rethrow;
    }
  }

  UserModel.User? _updateUserModel(User? firebaseUser) {
    if (firebaseUser != null) {
      _user = UserModel.User(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? '',
        email: firebaseUser.email ?? '',
        photoUrl: firebaseUser.photoURL ?? '',
      );
      notifyListeners();
      return _user;
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      if (kDebugMode) {
        print('Error sending password reset email: $error');
      }
      rethrow;
    }
  }

  Future<UserModel.User?> getCurrentUser() async {
    final User? firebaseUser = _auth.currentUser;
    return _updateUserModel(firebaseUser);
  }
}
