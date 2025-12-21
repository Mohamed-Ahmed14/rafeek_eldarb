import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/model/azkar_model.dart';
import '../../view_model/cubit/azkar_cubit/azkar_cubit.dart';
import '../../view_model/cubit/quran_cubit/quran_cubit.dart';

class AzkarBookmarkWidget extends StatelessWidget {
  final Map<String,dynamic> zkrModel;
  const AzkarBookmarkWidget({required this.zkrModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(20.sp),
      decoration: BoxDecoration(
          color: Colors.teal[900], borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            zkrModel["content"],
            style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w700,color: Colors.white),
          ),
          if (zkrModel["description"] != "")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.white,
                ),
                Text(
                  zkrModel["description"],
                  style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey[300]),
                ),
                Text(
                  'العدد: ${QuranCubit.get(context).convertToArabicNumbers(zkrModel["count"])}',
                  style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
