import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/services/notification_service.dart';
import 'package:app/screens/notification_history_screen.dart';
import 'package:app/screens/notification_preferences_screen.dart';
import 'package:app/widgets/fancy_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;
    final notificationService = Provider.of<NotificationService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _handleSignOut(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user?.photoUrl ?? ''),
            ),
            SizedBox(height: 20),
            Text(
              'Hello, ${user?.name ?? 'User'}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 40),
            FancyButton(
              onPressed: () => _navigateToNotificationPreferences(context),
              child: Text('Notification Preferences'),
            ),
            SizedBox(height: 20),
            FancyButton(
              onPressed: () => notificationService.sendTestNotification(),
              child: Text('Send Test Notification'),
            ),
            SizedBox(height: 20),
            FancyButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationHistoryScreen()),
              ),
              child: Text('View Notification History'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignOut(BuildContext context) async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign out: ${error.toString()}')),
      );
    }
  }

  void _navigateToNotificationPreferences(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => NotificationPreferencesScreen()),
    );
  }
}
