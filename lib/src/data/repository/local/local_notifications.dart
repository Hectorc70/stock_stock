import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotifications {
  static Future initializeApp() async {
    AwesomeNotifications().initialize('resource://drawable/icon', [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: 'Notification channel for basic tests')
    ]);
  }

  int createUniqueId() {
    //return Random().nextInt(2147483647);

    return DateTime.now().millisecond;
  }

  Future<void> createNotificationBasic(title, textBody) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: createUniqueId(),
            channelKey: 'basic_channel',
            icon: 'resource://drawable/icon.png',
            hideLargeIconOnExpand: true,
            title: title,
            body: textBody,
            notificationLayout: NotificationLayout.BigText));
  }

  Future<void> notificationSnack(title, textBody) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: createUniqueId(),
            channelKey: 'basic_channel',
            icon: 'resource://drawable/icon',
            hideLargeIconOnExpand: true,
            title: title,
            body: textBody,
            autoDismissible: true,
            notificationLayout: NotificationLayout.Inbox));
  }
}
