import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quran/quran.dart';
import 'package:rafeek_eldarb/view/mushaf/mushaf_screen.dart';
import 'package:rafeek_eldarb/view/quran_audio/audio_surah_screen.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/settings_cubit/settings_cubit.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_keys.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';

import '../../view_model/cubit/settings_cubit/settings_state.dart';
import '../challenges/challenge_screen.dart';
import 'adaptiveBannerAd_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  // late BannerAd? _bannerAd;
  // bool _isBannerLoaded = false;

  @override
  void initState() {
    super.initState();
    //Get Notification Status
    SettingsCubit.get(context).initNotificationStatus();
    // _bannerAd = BannerAd(
    //   size: AdSize.banner,
    //   adUnitId: 'ca-app-pub-3940256099942544/6300978111', // TEST Unit ID
    //   request: const AdRequest(),
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) {
    //       setState(() {
    //         _isBannerLoaded = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       ad.dispose();
    //     },
    //   ),
    // );
    //
    // _bannerAd?.load();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.foregroundColor,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' بروفايل ',
                style: TextStyle(color: Colors.white),
              ),
              // CircleAvatar(backgroundColor: Colors.brown[100],
              //     child: Icon(Icons.book,color: Colors.brown[900],size: 100.r,)),
              //Image.asset('assets/images/bookmarkIcon.png',height: 120.h,width: 120.h,fit: BoxFit.cover,),
            ],
          ),
          actions: [
            Image.asset('assets/images/dua.png'),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            var cubit = SettingsCubit.get(context);
            return ListView(
              //shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.all(20.sp),
              children: [
                //Message Section
                Container(
                  padding: EdgeInsetsDirectional.all(30.w),
                  decoration: BoxDecoration(
                    //color: Color(0xff07451F),//0xff07351F//0xff072A1F
                    color: Color(0xff072A1F),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColor.lightGreen,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidMoon,
                              color: AppColor.white,
                              size: 50.r,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'رسالة اليوم',
                              style: TextStyle(color: AppColor.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          cubit.dailyMsg ?? cubit.defaultMessage,
                          style: TextStyle(
                            color: AppColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if(cubit.isDailyMsgDescActive)
                        Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text('\"${cubit.dailyMsgDesc ?? cubit.defaultMsgDesc}\"',style: TextStyle(
                          color: AppColor.white,

                        ),),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                //Challenges Section
                Material(
                  borderRadius: BorderRadius.circular(25.r),
                  color: AppColor.foregroundColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25.r),
                    onTap: () {
                      ///Navigate to challenges screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChallengeScreen(),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(
                          vertical:30.h,horizontal: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Hero(
                                tag: 'award',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/quiz/award.png',
                                  width: 80.w,
                                  height: 80.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                'التحديات',
                                style: TextStyle(color: AppColor.white,
                                  fontSize: 60.sp,
                                  overflow: TextOverflow.ellipsis,),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Container(
                            padding: EdgeInsetsDirectional.all(20.w),
                            decoration: BoxDecoration(
                              color: AppColor.backgroundColor,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsetsDirectional.all(20.w),
                                  decoration: BoxDecoration(color: AppColor.foregroundColor,
                                      borderRadius: BorderRadius.circular(25.r)),
                                  child: Image.asset('assets/images/quiz/skill-development.png',
                                    color: AppColor.white,width: 80.w,height: 80.h,fit: BoxFit.cover,),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'اختبر معلوماتك',
                                      style: TextStyle(
                                        color: AppColor.foregroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.sp,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      'تحديات حماسية , مستويات متعددة',
                                      style: TextStyle(
                                        color: AppColor.foregroundColor,
                                        fontSize: 45.sp,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: AppColor.foregroundColor,
                                  radius: 40.r,
                                  child: Center(
                                      child: Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: AppColor.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h,),
                //Last Read and Last Listen Section
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: 20.h, horizontal: 40.w),
                          decoration: BoxDecoration(
                            color: AppColor.foregroundColor,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/headphones.png',
                                    width: 80.w,
                                    height: 80.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    'إستماعي',
                                    style: TextStyle(
                                      color: AppColor.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ' سورة ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    ' ${SettingsCubit.get(context).getSurahName(SharedHelper.get(key: SharedKeys.audioNumber))} ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                ' الشيخ مشاري راشد ',
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 40.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      backgroundColor:
                                      AppColor.lightBlueGrey,//0xf060957F
                                      padding: EdgeInsetsDirectional.zero),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AudioSurahScreen(
                                              surahModel: QuranCubit.get(context)
                                                  .surahsNameAndAyah[
                                              SharedHelper.get(
                                                  key: SharedKeys
                                                      .audioNumber) -
                                                  1]),
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'تشغيل',
                                        style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 50.sp,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Icon(
                                        Icons.play_circle_rounded,
                                        color: AppColor.white,
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: 20.h, horizontal: 40.w),
                          decoration: BoxDecoration(
                            color: AppColor.foregroundColor,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/holy-quran.png',
                                    width: 80.w,
                                    height: 80.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    'قراءتي',
                                    style: TextStyle(
                                      color: AppColor.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ' سورة ',
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    ' ${SettingsCubit.get(context).getSurahName(getPageData(SharedHelper.get(key: SharedKeys.savedPage)).last["surah"])} ',
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ' الصفحة ',
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 40.sp,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    ' ${QuranCubit.get(context).convertToArabicNumbers(SharedHelper.get(key: SharedKeys.savedPage).toString())} ',
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 40.sp,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      backgroundColor:
                                      AppColor.lightBlueGrey, //0xf060957F
                                      padding: EdgeInsetsDirectional.zero),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MushafScreen(
                                            pageIndex: SharedHelper.get(
                                                key: SharedKeys.savedPage),
                                          ),
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'متابعة',
                                        style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 50.sp,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: AppColor.white,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                ///Still Need Implement Notification logic -> Setting Cubit
                //Notification Section
                Container(
                  padding: EdgeInsetsDirectional.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColor.foregroundColor,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notifications_active_rounded,color:AppColor.backgroundColor,),
                          // Image.asset('assets/images/notification.png',
                          // width: 80.w,height: 80.h,fit: BoxFit.cover,),
                          SizedBox(width: 20.w,),
                          Text('الإشعارات',style: TextStyle(
                            color: AppColor.white,
                            fontSize: 60.sp,
                            overflow: TextOverflow.ellipsis,
                          ),),
                        ],
                      ),
                      CupertinoSwitch(
                          inactiveTrackColor: AppColor.backgroundColor,
                          activeTrackColor: AppColor.backgroundColor,
                          inactiveThumbColor: Colors.grey[600],
                          thumbColor: AppColor.foregroundColor,
                          value: cubit.isActive,
                          onChanged: (value) {
                            cubit.changeNotificationStatus();
                          })
                    ],
                  ),
                ),

                SizedBox(height: 30.h,),
                AdaptiveBannerAd(),
                SizedBox(height: 30.h,),
                //Google Ads
                // if (_isBannerLoaded && _bannerAd != null)
                //   SizedBox(
                //     width: _bannerAd?.size.width.toDouble(),
                //     height: _bannerAd?.size.height.toDouble(),
                //     child: AdWidget(ad: _bannerAd!),
                //   ),
              ],
            );
          },
        ),
      ),
    );
  }
}
