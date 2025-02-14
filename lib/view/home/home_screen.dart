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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
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
                        visible: QuranCubit.get(context).surahsNameAndAyah.isNotEmpty,
                        replacement: Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return SurahsWidget(
                                surahModel: QuranCubit.get(context).surahsNameAndAyah[index],);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15.h,);
                            },
                            itemCount: QuranCubit.get(context).surahsNameAndAyah.length,
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
    );
  }
}
