import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:rafeek_eldarb/view/mushaf/mushaf_screen.dart';
import 'package:rafeek_eldarb/view/quran_audio/audio_surah_screen.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/settings_cubit/settings_cubit.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_keys.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';

import '../../view_model/cubit/settings_cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: AppColor.foregroundColor,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' بروفايل ',style: TextStyle(
                color: Colors.white
              ),),
              CircleAvatar(backgroundColor: Colors.white70,
                  child: Icon(Icons.book,color: Colors.blueGrey[900],size: 100.r,)),
              //Image.asset('assets/images/bookmarkIcon.png',height: 120.h,width: 120.h,fit: BoxFit.cover,),
            ],
          ),
        ),
        body: BlocBuilder<SettingsCubit,SettingsState>(
          builder: (context, state) {
            return  ListView(
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.all(20.sp),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' المصحف ',style: TextStyle(
                        color: Colors.black,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w700
                    ),),
                    Image.asset('assets/images/holy-quran.png',width: 80.w,height: 80.h,fit: BoxFit.cover,),
                  ],
                ),
                Material(
                  color: AppColor.foregroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MushafScreen(
                        pageIndex: SharedHelper.get(key: SharedKeys.savedPage),
                      ),));
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsetsDirectional.all(20.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(' سورة ',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.w700
                              ),),
                              Text(' ${SettingsCubit.get(context).getSurahName(getPageData(
                                  SharedHelper.get(key: SharedKeys.savedPage)).last["surah"])} ',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.w700
                              ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(' الصفحة ',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.w700
                              ),),
                              Text(' ${QuranCubit.get(context).convertToArabicNumbers(SharedHelper.get(key: SharedKeys.savedPage).toString())} ',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.w700
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.grey,thickness: 2.sp,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' إستماع ',style: TextStyle(
                        color: Colors.black,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w700
                    ),),
                    Image.asset('assets/images/headphone.png',
                      width: 80.w,height: 80.h,fit: BoxFit.fill,),
                  ],
                ),
                SizedBox(height: 10.h,),
                Material(
                  color: AppColor.foregroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AudioSurahScreen(
                            surahModel: QuranCubit.get(context).surahsNameAndAyah[SharedHelper.get(key: SharedKeys.audioNumber)-1]),));
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsetsDirectional.all(20.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(' سورة ',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.w700
                              ),),
                              Text(' ${SettingsCubit.get(context).getSurahName(
                                  SharedHelper.get(key: SharedKeys.audioNumber)
                              )} ',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.w700
                              ),),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

    );
  }
}
