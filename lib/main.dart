
import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:rafeek_eldarb/my_app.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';

import 'package:rafeek_eldarb/view_model/data/network/dio_helper.dart';
import 'package:rafeek_eldarb/view_model/utils/audio_handler.dart';
import 'package:rafeek_eldarb/view_model/utils/defaults.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

  AudioHandler? audioHandler;

Future<void> main() async{

  //To prevent red screen error from appear
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Center(
      child: Text(
        'حدث خطأ ما برجاء المحاولة مرة اخري',
        style: TextStyle(color: Colors.red),
      ),
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedHelper.init();
  DioHelper.init();
  await Defaults.appDefaultInitialization();
  //comment that line when debug with emulator
 // await initAudioHandler();

  //Test
 // SharedHelper.remove(key: 'uid');


  /// to generate keys for localization
  /// flutter pub run easy_localization:generate -S assets/translations -O lib/view_model/utils -o local_keys.g.dart -f keys
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      startLocale: Locale('ar'),
      saveLocale: false,
      //startLocale: Locale('ar'),
      child: MyApp()));
}

Future<void> initAudioHandler()async{
  if(audioHandler != null){
    audioHandler = null;
  }
    audioHandler  = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
        androidNotificationChannelName: 'Audio Playback',
         androidNotificationIcon: 'mipmap/icon_transparent', // Request focus
        androidNotificationOngoing: true,
      ),
    );
}