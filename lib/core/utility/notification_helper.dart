import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pas_mobile/core/utility/helper.dart';

class NotificationHelper {
  //singleton pattern
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('iconapp');
    final initializationSettingsIos = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestAlertPermission: false,
      requestBadgePermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIos);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    logMe("On Tapped Successs");
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {}

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    'PAS Mobile',
    'notification',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  final DarwinNotificationDetails _iosNotificationDetails =
      const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  Future<void> showPlainNotifications(
      {String title = '', String body = ''}) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: _androidNotificationDetails,
        iOS: _iosNotificationDetails,
      ),
    );
  }

  Future<void> showNotifications(RemoteMessage message) async {
    if (message.notification != null) {
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: _androidNotificationDetails,
          iOS: _iosNotificationDetails,
        ),
        payload: jsonEncode(message.data),
      );
    } else {
      await flutterLocalNotificationsPlugin.show(
        0,
        message.data['action'],
        '',
        NotificationDetails(
          android: _androidNotificationDetails,
          iOS: _iosNotificationDetails,
        ),
        payload: jsonEncode(message.data),
      );
    }
  }
}
