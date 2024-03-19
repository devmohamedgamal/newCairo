import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("Title : ${message.notification?.title}");
  log("Body : ${message.notification?.body}");
  log("payload : ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestAndGetToken() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.instance.subscribeToTopic('all');
  }

  Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log("Handling a background message: ${message.messageId}");
  }
}
