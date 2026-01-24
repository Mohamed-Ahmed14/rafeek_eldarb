import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_state.dart';

import '../../view_model/cubit/audio_cubit/audio_cubit.dart';

class LayoutScreen extends StatefulWidget {

  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //comment that line when debug with emulator
    QuranCubit.get(context).checkForUpdate();
    //Init Audio Handler in main screen to avoid init it in main
    Future.microtask(() async {

        if(mounted){
          if(AudioCubit.get(context).audioHandler == null){
            await AudioCubit.get(context).initAudioHandler();
          }

        }

    });


  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit,QuranState>(
      builder: (context, state) {
        var cubit = QuranCubit.get(context);
        return Scaffold(
        body: cubit.screens[cubit.screenIndex],
          bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(icon: Image.asset('assets/images/dua.png'),title: ' بروفايل '),
                TabItem(icon: Image.asset('assets/images/arabic.png'),title: ' الأذكار ',),
                TabItem(icon: Image.asset('assets/images/holy-quran.png'),title: ' الرئيسية '),
                TabItem(icon: Image.asset('assets/images/audio5.png'),title: ' إستماع ',),
                TabItem(icon: Image.asset('assets/images/calendar.png'),title: ' الصلاة ',),
              ],
            initialActiveIndex: cubit.screenIndex,
            backgroundColor: Colors.brown[100],
            activeColor:Colors.teal[900],
            color: Colors.black,
            style: TabStyle.react,
            height: 140.h,
            curveSize: 80,
            onTap: (index) {
              cubit.updateScreenIndex(index);
            },
          ),
        );
      },

    );
  }
}
