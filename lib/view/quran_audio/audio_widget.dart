import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';

import '../../view_model/cubit/audio_cubit/audio_cubit.dart';
import '../../view_model/utils/app_colors.dart';
import 'audio_surah_screen.dart';

class AudioWidget extends StatelessWidget {
  final Map surahModel;
  const AudioWidget({required this.surahModel,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AudioSurahScreen(surahModel: surahModel,),));
      },
      child: Container(
        padding: EdgeInsetsDirectional.all(20.sp),
        decoration: BoxDecoration(
          color: Colors.teal[900],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(surahModel["surahNameArabic"],style: TextStyle(color: Colors.white,
                fontSize: 50.sp,fontWeight: FontWeight.bold),),
                Icon(Icons.headphones_rounded,color: Colors.white,),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
