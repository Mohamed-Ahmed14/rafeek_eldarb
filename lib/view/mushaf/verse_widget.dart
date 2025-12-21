import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';

class VerseWidget extends StatelessWidget {
  final String verseText;
  const VerseWidget({required this.verseText,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.all(15.sp),
      padding: EdgeInsetsDirectional.all(15.sp),
      decoration: BoxDecoration(
        color: Colors.white12,
      ),
      child: Text(verseText,style: TextStyle(
        fontSize: QuranCubit.get(context).sliderValue.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),),
    );
  }
}
