import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafeek_eldarb/view/challenges/question_screen.dart';

import '../../view_model/utils/app_colors.dart';

class ChallengeWidget extends StatelessWidget {
  const ChallengeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(40.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsetsDirectional.all(40.w),
                decoration: BoxDecoration(
                  color: Color(0xffd4b996),
                  borderRadius: BorderRadius.circular(20.r),
                ),child: Text("01",style: TextStyle(
                  color: AppColor.foregroundColor,
                  fontWeight: FontWeight.bold
              ),),
              ),
              Text("أسئلة عامة",style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w700
              ),),
              IconButton(onPressed: (){
                ///Implement navigator to challenge screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(),));
              },
                  icon: Icon(FontAwesomeIcons.solidCirclePlay,color: AppColor.foregroundColor,))
            ],
          ),
          SizedBox(height:20.h ,),
          Divider(color: Colors.grey[300],
            thickness: 1,),
          SizedBox(height:20.h ,),
          //Number of questions,time and points
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.help_rounded,textDirection: TextDirection.ltr,color: Color(0xffd4b996),),
                  Text("10 أسئلة",style: TextStyle(
                    color: Color(0xffd4b996),
                  ),)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.timer_rounded,color: Color(0xffd4b996),),
                  Text("5 دقائق",style: TextStyle(
                    color: Color(0xffd4b996),
                  ),)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.stars_rounded,color: Color(0xffd4b996),),
                  Text("50 نقطة",style: TextStyle(
                    color: Color(0xffd4b996),
                  ),)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
