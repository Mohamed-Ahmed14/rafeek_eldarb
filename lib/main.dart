


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rafeek_eldarb/my_app.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_keys.dart';
import 'package:rafeek_eldarb/view_model/data/network/dio_helper.dart';
import 'package:rafeek_eldarb/view_model/utils/defaults.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedHelper.init();
  DioHelper.init();
  await Defaults.appDefaultInitialization();

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