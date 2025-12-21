import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:rafeek_eldarb/view/home/surahs_widget.dart';

import '../../view_model/cubit/quran_cubit/quran_cubit.dart';
import '../../view_model/cubit/quran_cubit/quran_state.dart';
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
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            backgroundColor: AppColor.foregroundColor,
            title: Text(
              LocaleKeys.rafeekEldarb.tr(),
              style: TextStyle(color: AppColor.white),
            ),
            actions: [
              Image.asset('assets/images/appIcon1.png'),
              SizedBox(width: 20.w,),
            ],

          ),

          body: Padding(
            padding: EdgeInsetsDirectional.all(20.sp),
            child: BlocBuilder<QuranCubit,QuranState>(
              builder: (context, state) {
                return Column(
                    children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('اسم السورة',style: TextStyle(
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
                      SizedBox(height: 10.h,),
                      Expanded(
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
