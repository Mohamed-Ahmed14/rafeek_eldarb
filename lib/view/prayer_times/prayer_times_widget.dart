import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';
import '../../view_model/cubit/quran_cubit/quran_cubit.dart';

class PrayerTimesWidget extends StatelessWidget {
  final Map<String,dynamic> time;
  const PrayerTimesWidget({required this.time,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

        padding: EdgeInsetsDirectional.all(20.sp),
        height: 150.h,
        decoration: BoxDecoration(
            color: AppColor.foregroundColor,
            borderRadius: BorderRadius.circular(15.r)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/mosque3.png'),
            Text("${time.keys}".replaceAll(RegExp(r'\('), '').replaceAll(RegExp(r'\)'), ''),style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.sp,
              color: Colors.grey[300]
            ),),
            Text('${QuranCubit.get(context).convertToArabicNumbers(
                (time.values).toString())}'.replaceAll(RegExp(r'\('), '').replaceAll(RegExp(r'\)'),''),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                color: Colors.grey[300]
              ),),

          ],
        )
    );
  }
}
