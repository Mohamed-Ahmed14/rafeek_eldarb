


import 'package:firebase_messaging/firebase_messaging.dart';

import '../data/local/shared_helper.dart';
import '../data/local/shared_keys.dart';

Future<void> initFCM() async{

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false, //If user phone is mute
    provisional: false,  //For one time
    sound: true,
  );

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //  // print('User granted permission');
  // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   //print('User granted provisional permission');
  // } else {
  //   //print('User declined or has not accepted permission');
  // }
}

void checkNotificationStatus() async{
  bool? isEnabled = await SharedHelper.get(key: SharedKeys.notificationEnabled);
  if(isEnabled == null){
    await SharedHelper.set(key: SharedKeys.notificationEnabled, value: true);
    FirebaseMessaging.instance.subscribeToTopic("All");
    return;
  }
  if(isEnabled == true){
    FirebaseMessaging.instance.subscribeToTopic("All");
  }else{
    FirebaseMessaging.instance.unsubscribeFromTopic("All");
  }

}

// Future<void> initForegroundFCM() async{
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('Got a message whilst in the foreground!');
//     print('Message data: ${message.data}');
//
//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//     }
//   });
//
// }