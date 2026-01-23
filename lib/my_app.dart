
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rafeek_eldarb/view/layout/layout_screen.dart';


import 'package:rafeek_eldarb/view_model/cubit/audio_cubit/audio_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/azkar_cubit/azkar_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/prayer_cubit/prayer_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/settings_cubit/settings_cubit.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920), //Size(1080, 1920) , 2340
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => QuranCubit()..quranInitialization(),),
            BlocProvider(create: (context) => AudioCubit(),),
            BlocProvider(create: (context) => PrayerCubit(),),
            BlocProvider(create: (context) => AzkarCubit(),),
            BlocProvider(create: (context) => SettingsCubit()),
            BlocProvider(create: (context) => ChallengeCubit(),)
          ],
          child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'رفيق الدرب',
            // theme: ThemeData(
            //   textTheme: GoogleFonts.amiriTextTheme(),
            // ),
            home: child
          ),
        );
      },
      child: const LayoutScreen(),
    );
  }
}
