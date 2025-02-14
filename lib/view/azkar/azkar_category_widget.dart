import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view_model/cubit/azkar_cubit/azkar_cubit.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';

import 'azkar_screen.dart';

class AzkarCategoryWidget extends StatelessWidget {
  final int categoryIndex;
  const AzkarCategoryWidget({required this.categoryIndex,super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.foregroundColor,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AzkarScreen(azkarIndex: categoryIndex,),));
        },
        child: Container(
          padding: EdgeInsetsDirectional.all(20.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AzkarCubit.get(context).azkarIcon[categoryIndex],
              Text(AzkarCubit.get(context).categories[categoryIndex],
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),textAlign: TextAlign.center,),


            ],
          ),
        ),
      ),
    );
  }
}
