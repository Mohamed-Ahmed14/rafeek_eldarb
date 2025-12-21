import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/surah_data.dart';

import 'package:rafeek_eldarb/view/quran_audio/audio_widget.dart';

import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';

import '../../view_model/cubit/quran_cubit/quran_cubit.dart';
import '../../view_model/cubit/quran_cubit/quran_state.dart';

import 'package:flutter/widgets.dart';



class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: Colors.brown[100],
          appBar: AppBar(
            backgroundColor: Colors.brown[600],
            title: Text(
              'الشيخ مشاري راشد العفاسي',
              style: TextStyle(color: AppColor.white),
            ),
            actions: [
              SizedBox(width: 20.w,),
              //Icon(Icons.queue_music_outlined,color: Colors.white,size: 100.sp,),
              Image.asset('assets/images/headphone.png',width: 120.w,height: 110.h,fit: BoxFit.fill,),
              // Icon(Icons.headphones_rounded,color: Colors.white,),
              SizedBox(width: 30.w,),
            ],
          ),
          body: BlocBuilder<QuranCubit,QuranState>(
            builder: (context, state) {
              var cubit = QuranCubit.get(context);
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.all(20.sp),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cubit.searchAudioController,
                        focusNode: cubit.searchAudioNode,
                        onChanged: (value){
                          QuranCubit.get(context).searchAudio(value);
                        },
                        onTapOutside: (value){
                          cubit.searchAudioNode.unfocus();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.brown[600]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.brown[600]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.brown[600]!),
                          ),
                          prefixIcon: Icon(Icons.search_outlined,color: Colors.brown[600]!,),
                          contentPadding: EdgeInsetsDirectional.all(8.sp),

                        ),
                        cursorColor: Colors.brown[600]!,
                        style: TextStyle(color: Colors.brown[900]),
                      ),
                      SizedBox(height: 20.h,),
                      Visibility(
                        visible: cubit.searchAudioController.text.trim().isEmpty ||
                        cubit.searchAudioList.isNotEmpty,
                        replacement: Center(child: Text('لم يتم العثور علي السورة',style: TextStyle(
                            color: Colors.brown[600]
                        ),)),
                        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                        crossAxisSpacing: 10.w,mainAxisSpacing: 10.h,childAspectRatio: 15/10),shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AudioWidget(surahModel: cubit.searchAudioController.text.trim().isEmpty ?
                          cubit.surahsNameAndAyah[index]:
                          cubit.searchAudioList[index]);
                        },
                        itemCount: cubit.searchAudioController.text.trim().isEmpty ?
                        cubit.surahsNameAndAyah.length:cubit.searchAudioList.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ),
      ),
    );
  }
}

