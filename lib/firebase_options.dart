// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBEDkvqx8WRDSZp27jL5EYDKPaslH4sqdQ',
    appId: '1:660648791304:web:586d7eff1c864e4ee670bd',
    messagingSenderId: '660648791304',
    projectId: 'flutter-app-77a7b',
    authDomain: 'flutter-app-77a7b.firebaseapp.com',
    storageBucket: 'flutter-app-77a7b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAW2NpKesv0FEripwKvTTYjJLWztmC20jQ',
    appId: '1:660648791304:android:4ab28f935e309d17e670bd',
    messagingSenderId: '660648791304',
    projectId: 'flutter-app-77a7b',
    storageBucket: 'flutter-app-77a7b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDH-oIJN-smsC1Q46XetSLpJ00UhWFXmc4',
    appId: '1:660648791304:ios:420b8c46fa954b24e670bd',
    messagingSenderId: '660648791304',
    projectId: 'flutter-app-77a7b',
    storageBucket: 'flutter-app-77a7b.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDH-oIJN-smsC1Q46XetSLpJ00UhWFXmc4',
    appId: '1:660648791304:ios:420b8c46fa954b24e670bd',
    messagingSenderId: '660648791304',
    projectId: 'flutter-app-77a7b',
    storageBucket: 'flutter-app-77a7b.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBEDkvqx8WRDSZp27jL5EYDKPaslH4sqdQ',
    appId: '1:660648791304:web:b12f8f60a9d1612fe670bd',
    messagingSenderId: '660648791304',
    projectId: 'flutter-app-77a7b',
    authDomain: 'flutter-app-77a7b.firebaseapp.com',
    storageBucket: 'flutter-app-77a7b.appspot.com',
  );
}