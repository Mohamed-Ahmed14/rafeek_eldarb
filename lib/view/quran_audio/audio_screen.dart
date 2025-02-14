import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:rafeek_eldarb/view/quran_audio/audio_widget.dart';
import 'package:rafeek_eldarb/view_model/cubit/audio_cubit/audio_cubit.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';

import '../../view_model/cubit/quran_cubit/quran_cubit.dart';
import '../../view_model/cubit/quran_cubit/quran_state.dart';
import '../../view_model/utils/local_keys.g.dart';
import 'package:flutter/widgets.dart';

import '../home/surahs_widget.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text(
            'الشيخ مشاري راشد العفاسي',
            style: TextStyle(color: AppColor.white),
          ),
          actions: [
            SizedBox(width: 20.w,),
            Image.asset('assets/images/headphones.png',width: 80.w,height: 80.h,fit: BoxFit.cover,),
            // Icon(Icons.headphones_rounded,color: Colors.white,),
            SizedBox(width: 30.w,),
          ],
        ),
        body: BlocBuilder<QuranCubit,QuranState>(
          builder: (context, state) {
            return Padding(
              padding:  EdgeInsets.all(20.0.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  children: [
                    ///Search Box -> need controller and apply search concept to make list and visibility
                    // SizedBox(
                    //   height: 100.h,
                    //   child: TextFormField(
                    //     cursorColor: AppColor.tealDark,
                    //     decoration: InputDecoration(
                    //       contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 25.w),
                    //       prefixIcon: Icon(Icons.search_rounded,color: Colors.blueGrey[700],),
                    //       hintText: 'اسم السورة',
                    //       hintStyle: TextStyle(color: AppColor.grey),
                    //       fillColor: Colors.white,
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(20.r),
                    //         borderSide: BorderSide(color: AppColor.grey,),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12.r),
                    //         borderSide: BorderSide(color: AppColor.grey),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12.r),
                    //         borderSide: BorderSide(color: AppColor.grey),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('اسم السورة',style: TextStyle(
                          color: AppColor.black,
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text('إستماع',style: TextStyle(
                          color: AppColor.black,
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                          itemBuilder: (context, index) {
                        return AudioWidget(surahModel: QuranCubit.get(context).surahsNameAndAyah[index]);
                      }, separatorBuilder: (context, index) {
                        return SizedBox(height: 20.h,);
                      }, itemCount: QuranCubit.get(context).surahsNameAndAyah.length),
                    )
      
                  ]
              ),
            );
          },
        )
      ),
    );
  }
}

/*
Center(
        child: Container(
          margin: EdgeInsetsDirectional.all(25.sp),
          padding: EdgeInsetsDirectional.all(20.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.black,
              width: 2.w,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: (){
                AudioCubit.get(context).audioPlay(getAudioURLBySurah(2));
              },
                  icon: Icon(Icons.play_arrow_outlined)),
              IconButton(onPressed: (){
                AudioCubit.get(context).audioResume();
              },
                  icon: Icon(Icons.pause)),
              IconButton(onPressed: (){
                AudioCubit.get(context).audioStop();
              },
                  icon: Icon(Icons.stop))
            ],
          ),
        ),
      ),
 */
