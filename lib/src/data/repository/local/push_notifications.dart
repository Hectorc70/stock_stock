import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stock_stock/src/data/repository/local/local_notifications.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static StreamController<Map<String, dynamic>> _messageStream =
      new StreamController.broadcast();

  static Stream<Map<String, dynamic>> get messageStream =>
      _messageStream.stream;

  //Segundo Plano
  static Future _backgroundHandler(RemoteMessage message) async {
    //print('_backgroundHandler ${message.messageId}');
    /* _messageStream.add(message.data); */
    LocalNotifications().notificationSnack(
        message.notification!.title ?? '', message.notification!.body);
  }

  //app en primer plano
  static Future _onMessageHandler(RemoteMessage message) async {
    //print('_onMessageHandler ${message.messageId}');
    /* _messageStream.add(message.data); */
    LocalNotifications().notificationSnack(
        message.notification!.title ?? '', message.notification!.body);
  }

  //app Cerrada
  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('_onMessageOpenApp ${message.messageId}');
    //_messageStream.add(message.data);
    LocalNotifications().notificationSnack(
        message.notification!.title ?? '', message.notification!.body);
    //prefs.dataNotification = [message.data['type'], message.data['idService']];
  }

  static Future initializeApp() async {
    //push Notifications
    await Firebase.initializeApp();
    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
