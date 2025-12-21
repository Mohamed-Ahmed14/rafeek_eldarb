import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view/azkar/azkar_widget.dart';
import 'package:rafeek_eldarb/view_model/cubit/azkar_cubit/azkar_cubit.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';

import '../../view_model/cubit/azkar_cubit/azkar_state.dart';


class AzkarScreen extends StatelessWidget {
  final int azkarIndex;
  const AzkarScreen({required this.azkarIndex,super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.foregroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.foregroundColor,
          leadingWidth: 100.w,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },
              icon: Icon(Icons.arrow_back_rounded,color: Colors.white,)),
          centerTitle: true,
          title: Row(
           mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              Text(AzkarCubit.get(context).categories[azkarIndex],style: TextStyle(
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
              SizedBox(width: 20.w,),
              AzkarCubit.get(context).azkarIcon[azkarIndex],
            ],
          ),
        ),
        body: ListView.separated(
              padding: EdgeInsetsDirectional.all(20.sp),
              itemBuilder: (context, index) {
                return AzkarWidget(azkarMap: AzkarCubit.get(context).getAzkarList(azkarIndex)[index],index: index,);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20.h,);
              },
              itemCount: AzkarCubit.get(context).getAzkarList(azkarIndex).length,

            ),

        )
    );

  }
}
