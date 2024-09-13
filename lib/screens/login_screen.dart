import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/widgets/animated_background.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(), // Keep the animated background
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2), // Space from top
                    Text(
                      'Crazy Notifier',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 10.0, color: Colors.purpleAccent)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    if (authService.user == null) ...[
                      _buildAuthButtons(authService),
                      SizedBox(height: 20),
                      _buildEmailPasswordForm(),
                    ] else ...[
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                        ),
                        child: Text('Go to Home', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButtons(AuthService authService) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _handleGoogleSignIn(context),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.login),
              SizedBox(width: 10),
              Text('Sign in with Google', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEmailPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+").hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _handleEmailSignIn(context),
            child: Text('Sign in with Email', style: TextStyle(fontSize: 18)),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _handleEmailSignUp(context),
            child: Text('Sign Up with Email', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  void _handleGoogleSignIn(BuildContext context) async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.signInWithGoogle();
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (error) {
      print('Error during Google Sign-In: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Google')),
      );
    }
  }

  void _handleEmailSignIn(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return; // Form is not valid, exit the function
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (error) {
      print('Error during Email Sign-In: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with email')),
      );
    }
  }

  void _handleEmailSignUp(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return; // Form is not valid, exit the function
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.createUserWithEmailAndPassword(email, password);
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (error) {
      print('Error during Email Sign-Up: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up with email')),
      );
    }
  }
}
