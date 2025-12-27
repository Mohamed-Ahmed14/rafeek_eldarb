import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/utils/app_colors.dart';

class ChoiceWidget extends StatelessWidget {
  const ChoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(20.w),
      decoration: BoxDecoration(
        color: Color(0xffd4b996),
        borderRadius: BorderRadius.circular(20.r),
      ),child: Text('غزوة احد',style: TextStyle(
      color: AppColor.white,
      fontWeight: FontWeight.w800,
    ),textAlign: TextAlign.center,),
    );
  }
}
