import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_state.dart';

import '../../view_model/utils/app_colors.dart';

class ChoiceWidget extends StatelessWidget {
  final String? optionValue;
  final String? optionNum; //"opt1"
  final Color? bgColor;
  const ChoiceWidget({required this.bgColor,required this.optionNum,this.optionValue,super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ChallengeCubit,ChallengeState>(
      builder: (context, state) {
        var cubit =  ChallengeCubit.get(context);
        return Material(
          //color: (cubit.isSelected && optionNum == cubit.userAns && cubit.isRight)?Colors.green:
          //(cubit.isSelected && optionNum == cubit.userAns && !cubit.isRight)?Colors.red:Color(0xffd4b996),
         color: (cubit.isSelected && optionNum == cubit.userAns)?bgColor: Color(0xffd4b996),
          borderRadius: BorderRadius.circular(20.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              //can choose only one answer at each question
              if(cubit.isSelected == false && cubit.remainingSeconds != cubit.quizFixedTime){
                cubit.checkAns(optionNum);
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.all(20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),child: Text(optionValue??"",style: TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.w800,
            ),textAlign: TextAlign.center,),
            ),
          ),
        );
      },
    );
  }
}
