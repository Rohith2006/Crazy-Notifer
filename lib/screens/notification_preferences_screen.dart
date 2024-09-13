import 'package:flutter/material.dart';
import 'package:app/services/notification_service.dart';
import 'package:app/widgets/fancy_button.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  @override
  _NotificationPreferencesScreenState createState() => _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState extends State<NotificationPreferencesScreen> {
  bool newsNotifications = true;
  bool eventNotifications = true;
  String frequency = '1 min';

  @override
  void initState() {
    super.initState();
    // Initialize preferences from NotificationService or storage
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    // Assume you have a method to get preferences, for demonstration use default values
    setState(() {
      // You might want to fetch these values from your service or storage
      newsNotifications = true;
      eventNotifications = true;
      frequency = '1 min';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Preferences')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notification Types', style: Theme.of(context).textTheme.titleLarge),
            SwitchListTile(
              title: Text('News Notifications'),
              value: newsNotifications,
              onChanged: (value) => setState(() => newsNotifications = value),
            ),
            SwitchListTile(
              title: Text('Event Notifications'),
              value: eventNotifications,
              onChanged: (value) => setState(() => eventNotifications = value),
            ),
            SizedBox(height: 20),
            Text('Notification Frequency', style: Theme.of(context).textTheme.titleLarge),
            DropdownButton<String>(
              value: frequency,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => frequency = newValue);
                }
              },
              items: <String>['10 sec', '1 min', '5 min', '1 hr']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            Center(
              child: FancyButton(
                onPressed: _savePreferences,
                child: Text('Save Preferences'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _savePreferences() async {
    // Update the NotificationService with current preferences
    NotificationService.updatePreferences(
      newsNotifications: newsNotifications,
      eventNotifications: eventNotifications,
      frequency: frequency,
    );

    // Provide feedback to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Preferences saved!')),
    );
  }
}
