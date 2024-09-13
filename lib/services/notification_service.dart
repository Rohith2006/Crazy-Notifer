import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/services/auth_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Timer? _notificationTimer;
  bool _newsNotifications = true;
  bool _eventNotifications = true;
  Duration _notificationFrequency = Duration(minutes: 1);
  int _notificationIdCounter = 0; // Counter to generate unique notification IDs

  Future<void> init(AuthService authService) async {

    await _firebaseMessaging.requestPermission();
    await _initLocalNotifications();

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _handleMessage(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      _showLocalNotification(notification.title ?? 'No Title', notification.body ?? 'No Body');
      _saveNotificationToHistory(notification.title ?? 'No Title', notification.body ?? 'No Body');
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    print('Notification tapped!');
    // Handle navigation or actions based on notification payload
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  String getUserName() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? 'User'; // Return email if available, else 'User'
  }

  void sendTestNotification() {
    final username = getUserName();
    _showLocalNotification('Test Notification for $username', 'This is a test notification!');
    _saveNotificationToHistory('Test Notification for $username', 'This is a test notification!');
  }

  void _showLocalNotification(String title, String body) {
    _notificationIdCounter++; // Increment the counter to ensure unique IDs
    _flutterLocalNotificationsPlugin.show(
      _notificationIdCounter,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> _saveNotificationToHistory(String title, String body) async {
    await _firestore.collection('notifications').add({
      'title': title,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getNotificationHistory() async {
    final querySnapshot = await _firestore
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .limit(50)  // Limit to the last 50 notifications
        .get();

    return querySnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'title': doc['title'],
        'body': doc['body'],
        'timestamp': doc['timestamp'],
      };
    }).toList();
  }

  static void updatePreferences({required bool newsNotifications, required bool eventNotifications, required String frequency}) {
    _instance._newsNotifications = newsNotifications;
    _instance._eventNotifications = eventNotifications;
    _instance._setNotificationFrequency(frequency);
    _instance._schedulePeriodicNotifications();
  }

  void _setNotificationFrequency(String frequency) {
    switch (frequency) {
      case '10 sec':
        _notificationFrequency = Duration(seconds: 10);
        break;
      case '1 min':
        _notificationFrequency = Duration(minutes: 1);
        break;
      case '5 min':
        _notificationFrequency = Duration(minutes: 5);
        break;
      case '1 hr':
        _notificationFrequency = Duration(hours: 1);
        break;
      default:
        _notificationFrequency = Duration(minutes: 1);
    }
  }

  void _schedulePeriodicNotifications() {
    _notificationTimer?.cancel();
    _notificationTimer = Timer.periodic(_notificationFrequency, (timer) async {
      final userName = getUserName();

      if (_newsNotifications) {
        _showLocalNotification(
          'News Update',
          'Hello $userName, check out the latest news!',
        );
        _saveNotificationToHistory(
          'News Update',
          'Hello $userName, check out the latest news!',
        );
      }

      if (_eventNotifications) {
        _showLocalNotification(
          'Event Reminder',
          'Hi $userName, you have an upcoming event!',
        );
        _saveNotificationToHistory(
          'Event Reminder',
          'Hi $userName, you have an upcoming event!',
        );
      }
    });
  }

  Future<void> clearNotificationHistory() async {
    final batch = _firestore.batch();
    final snapshots = await _firestore.collection('notifications').get();
    for (final doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
