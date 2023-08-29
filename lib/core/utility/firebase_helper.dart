import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/core/utility/injection.dart';
import 'package:pas_mobile/firebase_options.dart';

import 'notification_helper.dart';

class FirebaseHelper {
  static late FirebaseMessaging messaging;
  static NotificationHelper notificationHelper = NotificationHelper();

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    messaging = FirebaseMessaging.instance;
    await permissionHandler().then((authorized) async {
      if (authorized) {
        await setupMessaging();
      }
    });
  }

  Future<String?> getToken() async {
    return await messaging.getToken();
  }

  static Future<void> subscribeToTopic() async {
    await messaging.subscribeToTopic('activity.notification');
    logMe('--- Subscribe topic succedd');
  }

  static Future<void> unsubscribeFromTopic() async {
    await messaging.unsubscribeFromTopic('activity.notification');
    logMe('--- Unsubscribe topic succedd');
  }

  static Future<void> setupMessaging() async {
    await messaging.getToken().then((token) {
      logMe("firebase-token: $token");
    });
    await incomingNotificationHandling();
    await messaging.getInitialMessage().then((message) {});
  }

  static Future<void> incomingNotificationHandling() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationHelper.showNotifications(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  static Future<bool> permissionHandler() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    logMe('User granted permission: ${settings.authorizationStatus}');
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}
