import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view_model/cubit/azkar_cubit/azkar_cubit.dart';

import 'azkar_category_widget.dart';

class AzkarCategoriesScreen extends StatelessWidget {
  const AzkarCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int rowCount = 3;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.only(top: 0,start: 20.w,end: 20.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 20.w,
              childAspectRatio: ((screenWidth/2) / (screenHeight/4.5)),
            ),
            itemBuilder: (context, index) {
              return AzkarCategoryWidget(categoryIndex:index);
            },
            itemCount: AzkarCubit.get(context).categories.length,
          ),
        ),
      ),
    );
  }
}
