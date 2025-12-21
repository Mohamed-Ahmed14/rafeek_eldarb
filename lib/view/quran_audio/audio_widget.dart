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
        padding: EdgeInsetsDirectional.all(10.sp),
        decoration: BoxDecoration(
          color: Colors.brown[600],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Icon(Icons.multitrack_audio_outlined,color: Colors.white,),
            Image.asset('assets/images/headphone.png',width: 100.w,height: 100.w,fit: BoxFit.cover,),
            Text('سورة ${surahModel["surahNameArabic"]}',style: TextStyle(color: Colors.white,
            fontSize: 50.sp,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
