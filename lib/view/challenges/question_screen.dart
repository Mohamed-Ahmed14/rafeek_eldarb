import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view/challenges/challenge_score_screen.dart';
import 'package:rafeek_eldarb/view/challenges/choice_widget.dart';

import '../../view_model/utils/app_colors.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown[100],
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
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_rounded,color: AppColor.white,)),
            ),
          ),
          centerTitle: true,
          title: Text(' التحدي 1 ',style: TextStyle(
              color: Colors.white
          ),),

        ),
        body: Padding(
          padding: EdgeInsetsDirectional.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Details of points,question number,challenge category,time
                Container(
                  padding: EdgeInsetsDirectional.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColor.foregroundColor,
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('النقاط',style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColor.white
                          ),),
                          Text('التقدم',style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white
                          ),),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('120',style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white
                          ),),
                          Text('5/10',style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white
                          ),),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          Icon(Icons.timer_rounded,color: AppColor.white,),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.3,
                              backgroundColor: Colors.black,
                              color: AppColor.teal,
                              borderRadius: BorderRadius.circular(20.r),
                              minHeight: 20.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80.h,),
                //The Question
                Text("ما هو اسم الغزوة التي وقعت في السنة الثانية للهجرة؟",style: TextStyle(
                  color: AppColor.black,
                  fontSize: 60.sp,
                  fontFamily: 'QCF',
                  fontWeight: FontWeight.w800,
                ),textAlign: TextAlign.center,),
                SizedBox(height: 40.h,),
                //The Choices
                ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (context, index) {
                  return ChoiceWidget();
                },
                    separatorBuilder: (context, index) {
                  return SizedBox(height: 40.h,);
                }, itemCount: 4),
                SizedBox(height: 80.h,),
                //Button to navigate to next question or get result
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    )
                  ),
                    onPressed: (){
                    //Temp navigate to result screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeScoreScreen(),));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('التالي',style: TextStyle(
                          color: AppColor.black
                        ),),
                        SizedBox(width: 20.w,),
                        Icon(Icons.arrow_forward,color: AppColor.black,)
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
