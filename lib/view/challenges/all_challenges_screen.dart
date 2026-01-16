import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view/challenges/challenge_screen.dart';
import 'package:rafeek_eldarb/view/challenges/challenge_widget.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_cubit.dart';

import '../../view_model/utils/app_colors.dart';

class AllChallengesScreen extends StatelessWidget {
  const AllChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.foregroundColor,
          leading: Padding(
            padding:  EdgeInsetsDirectional.all(24.w),
            child: CircleAvatar(
              backgroundColor: Colors.teal[700],
              maxRadius: 0.5,
              child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsetsDirectional.zero,
                  ),
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChallengeScreen(),),
                        (route) => false,);
                  },
                  icon: Icon(Icons.arrow_back_rounded,color: AppColor.white,)),
            ),
          ),
          centerTitle: true,
          title: Text(' كل التحديات ',style: TextStyle(
              color: Colors.white
          ),),
          actions: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/quiz/award.png'),
            ),
            SizedBox(width: 20.w,),
          ],
        ),
        backgroundColor: Colors.brown[100],
        body: ListView.separated(
          padding: EdgeInsetsDirectional.all(20.w),
            itemBuilder: (context, index) {
          return ChallengeWidget(challengeIndex: index,);
        },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20.h,);
            },
            itemCount: ChallengeCubit.get(context).challengesDetails.length),
      ),
    );
  }
}
