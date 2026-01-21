import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafeek_eldarb/view/challenges/question_screen.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_cubit.dart';

import '../../view_model/utils/app_colors.dart';

class ChallengeWidget extends StatelessWidget {
  final int challengeIndex;
  const ChallengeWidget({required this.challengeIndex,super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ChallengeCubit.get(context);
    return Container(
      padding: EdgeInsetsDirectional.all(40.w),
      decoration: BoxDecoration(
        color: AppColor.foregroundColor,
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
                  color: Color(0xffd4b996), //0xffd4b996
                  borderRadius: BorderRadius.circular(20.r),
                ),child: Text((challengeIndex+1).toString(),style: TextStyle(
                  color: AppColor.foregroundColor,
                  fontWeight: FontWeight.bold
              ),),
              ),
              Text("${cubit.challengesDetails[challengeIndex].category}",style: TextStyle(
                  color: Color(0xffd4b996),
                  fontSize: 55.sp,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
              ),),
              IconButton(onPressed: (){
                //if challenge is locked can't get its questions
                if(challengeIndex > (cubit.userData?.challengesPassed ?? 1)){
                  return;
                }
                //Get challenge Data (index + 1 ) challenges starts from 1 in FireStore
                ChallengeCubit.get(context).getChallengeData(challengeIndex + 1);
                //Init The challenge
                ChallengeCubit.get(context).initChallenge();
                ///Implement navigator to challenge screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(),));
              },
                  icon: Icon(challengeIndex <= ((cubit.userData?.challengesPassed ?? 1)) ?
                  FontAwesomeIcons.solidCirclePlay:FontAwesomeIcons.lock,color: Color(0xffd4b996),size: 80.w,))
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
                  SizedBox(width: 5.w,),
                  Text("10 أسئلة",style: TextStyle(
                    color: Color(0xffd4b996),//0xffd4b996
                    fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis
                  ),)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.timer_rounded,color: Color(0xffd4b996),),
                  SizedBox(width: 5.w,),
                  Text("2:30 دقائق",style: TextStyle(
                    color: Color(0xffd4b996),
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis
                  ),)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.stars_rounded,color: Color(0xffd4b996),),
                  SizedBox(width: 5.w,),
                  Text("${cubit.challengesDetails[challengeIndex].challengePoints ?? "50"} نقطة ",style: TextStyle(
                    color: Color(0xffd4b996),
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis
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
