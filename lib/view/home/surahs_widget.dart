import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view/mushaf/mushaf_screen.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';

import '../../view_model/utils/app_colors.dart';


class SurahsWidget extends StatelessWidget {
  final Map surahModel;
  const SurahsWidget({required this.surahModel,super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.r),
      color: Colors.teal[900],
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          //QuranCubit.get(context).pageNumber = surahModel["surahNumber"];
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MushafScreen(
                pageIndex: QuranCubit.get(context).getSurahPageNumber(surahModel["surahNumber"]),),));

        },
        child: Container(
          padding: EdgeInsetsDirectional.all(15.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),

          ),
          child: Row(
            children: [
              SizedBox(width: 10.w,),
              Text(QuranCubit.get(context).convertToArabicNumbers(surahModel["surahNumber"].toString()),style: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(width: 25.w,),
              Expanded(
                child: Text(
                  surahModel["surahNameArabic"]?? "",
                  style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.sp),
                ),
              ),
              Text(QuranCubit.get(context).convertToArabicNumbers(surahModel["totalAyah"].toString()),style: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(width: 10.w,),
            ],
          ),
        ),
      ),
    );
  }
}
