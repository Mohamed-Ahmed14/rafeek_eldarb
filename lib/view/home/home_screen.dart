import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rafeek_eldarb/view/home/surahs_widget.dart';

import '../../view_model/cubit/quran_cubit/quran_cubit.dart';
import '../../view_model/cubit/quran_cubit/quran_state.dart';
import '../../view_model/cubit/settings_cubit/settings_cubit.dart';
import '../../view_model/utils/app_colors.dart';
import '../../view_model/utils/local_keys.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
     QuranCubit.get(context).getSurahsNames();
     //Get Daily Message
     SettingsCubit.get(context).getDailyMessage();
     // Future.microtask(() {
     //   _focusNode.unfocus();
     // });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
           backgroundColor: AppColor.backgroundColor,
          //backgroundColor: Color(0xffd4b9BC),
          appBar: AppBar(
            backgroundColor: AppColor.foregroundColor,
            centerTitle: true,
            elevation: 0,
            title: Text(
              LocaleKeys.rafeekEldarb.tr(),
              style: TextStyle(color: AppColor.white),
            ),
            // actions: [
            //   Image.asset('assets/images/appIcon1.png'),
            //   SizedBox(width: 20.w,),
            // ],

          ),

          body: Padding(
            padding: EdgeInsetsDirectional.all(20.sp),
            child: BlocBuilder<QuranCubit,QuranState>(
              builder: (context, state) {
                return Column(
                  //shrinkWrap: true,
                    //physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          //Slider section
                          CarouselSlider(
                            options: CarouselOptions(height: 300.h,
                              autoPlay: true,
                              aspectRatio: 20/9,
                              autoPlayAnimationDuration: Duration(milliseconds: 500),
                              autoPlayCurve: Curves.linear,
                              autoPlayInterval: Duration(seconds: 2),),
                            items: ["assets/images/slider/slider_challenges.png",
                              "assets/images/slider/slider_prayertimes.png",
                              "assets/images/slider/slider_reading.png"].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Image.asset(i,height: 300.h,fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/slider/slider_reading.png'),),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20.h,),
                          //Search Input
                          TextFormField(
                            controller: QuranCubit.get(context).searchSurahController,
                            focusNode: QuranCubit.get(context).searchSurahNode,

                            onChanged: (value){
                              QuranCubit.get(context).searchSurah(value);
                            },
                            onTapOutside: (value){
                              QuranCubit.get(context).searchSurahNode.unfocus();
                            },
                            decoration: InputDecoration(
                              hintText: 'اكتب اسم السورة',
                              hintStyle: TextStyle(
                                color: AppColor.foregroundColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(color: AppColor.tealDark),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(color: AppColor.tealDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(color: AppColor.foregroundColor),
                              ),
                              prefixIcon: Icon(Icons.search_outlined,color: AppColor.foregroundColor,),
                              contentPadding: EdgeInsetsDirectional.all(8.sp),

                            ),
                            cursorColor: AppColor.foregroundColor,
                            style: TextStyle(color: AppColor.black),
                          ),
                          //El mushaf
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('المصحف',style: TextStyle(
                                color: AppColor.black,
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text('عدد الآيات',style: TextStyle(
                                color: AppColor.black,
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Expanded(
                        flex: 3,
                        child: Visibility(
                          visible: QuranCubit.get(context).searchSurahController.text.trim().isEmpty ||
                          QuranCubit.get(context).searchSurahList.isNotEmpty,
                          replacement: Center(child: Text('لم يتم العثور علي السورة',style: TextStyle(
                              color: AppColor.black
                                  ),)),
                          // replacement: Visibility(
                          //   visible: QuranCubit.get(context).searchSurahController.text.trim().isNotEmpty &&
                          //   QuranCubit.get(context).searchSurahList.isNotEmpty,
                          //   replacement: Center(child: Text('لم يتم العثور علي السورة',style: TextStyle(
                          //     color: AppColor.black
                          //   ),)),
                          //   child: ListView.separated(
                          //     shrinkWrap: true,
                          //     itemBuilder: (context, index) {
                          //       return SurahsWidget(
                          //         surahModel: QuranCubit.get(context).searchSurahList[index],);
                          //     },
                          //     separatorBuilder: (context, index) {
                          //       return SizedBox(height: 15.h,);
                          //     },
                          //     itemCount: QuranCubit.get(context).searchSurahList.length,
                          //   ),
                          // ),
                          child: ListView.separated(
                              shrinkWrap: true,
                              //physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SurahsWidget(
                                  surahModel: (QuranCubit.get(context).searchSurahController.text.trim().isEmpty) ?
                                  QuranCubit.get(context).surahsNameAndAyah[index]:
                                    QuranCubit.get(context).searchSurahList[index],);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15.h,);
                              },
                              itemCount:(QuranCubit.get(context).searchSurahController.text.trim().isEmpty) ?
                              QuranCubit.get(context).surahsNameAndAyah.length:
                              QuranCubit.get(context).searchSurahList.length,
                            ),
                        ),
                      ),
                    // SizedBox(height: 30.h,),
                    ]
                );
              },
            ),
          ),
        ),
      ),
    );
  }




}
