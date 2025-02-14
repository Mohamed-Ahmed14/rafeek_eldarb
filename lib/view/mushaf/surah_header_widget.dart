import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';

import '../../view_model/utils/app_colors.dart';

class SurahHeaderWidget extends StatelessWidget {
  final String surahName;
  const SurahHeaderWidget({required this.surahName, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.all(10.sp),
          //margin: EdgeInsetsDirectional.all(20.sp),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.brown),
            image: DecorationImage(image: AssetImage('assets/images/surah_name_header.png'),fit: BoxFit.fill),
          ),
          child: Text(surahName,textAlign: TextAlign.center,style: TextStyle(
            fontSize: 60.sp,fontWeight: FontWeight.bold
          ),),
        ),
        SizedBox(height: 10.h,),
        if(QuranCubit.get(context).pageIndex != 1 && QuranCubit.get(context).pageIndex != 187)
          Text(QuranCubit.get(context).mushafModel?.basmala ?? "",style: TextStyle(
            fontSize: QuranCubit.get(context).sliderValue.sp,
            fontWeight: FontWeight.bold
          ),),
      ],
    );
  }
}
