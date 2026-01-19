import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view/challenges/challenge_score_screen.dart';
import 'package:rafeek_eldarb/view/challenges/challenge_screen.dart';
import 'package:rafeek_eldarb/view/challenges/choice_widget.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_state.dart';


import '../../view_model/utils/app_colors.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // print("Happy");
    //print(ChallengeCubit.get(context).quizNumber);
     ChallengeCubit.get(context).startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: AppColor.foregroundColor,
          leading: Padding(
            padding: EdgeInsetsDirectional.all(24.w),
            child: CircleAvatar(
              backgroundColor: Colors.teal[700],
              maxRadius: 0.5,
              child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsetsDirectional.zero,
                  ),
                  onPressed: () {
                    ChallengeCubit.get(context).stopTimer();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChallengeScreen(),),
                        (route) => false,);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColor.white,
                  )),
            ),
          ),
          centerTitle: true,
          title: Text(
            ' التحدي 1 ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocConsumer<ChallengeCubit, ChallengeState>(
          listener: (context, state) {
            var cubit = ChallengeCubit.get(context);
            if(state is TimeUpState && cubit.isTimeFinish){
              if (((cubit.challengeModel?.questions?.length ??
                  0)-1) ==
                  cubit.quizNumber) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChallengeScoreScreen(),
                      ));
              } else {
                  cubit.getNextQuiz();
              }
            }
          },
          builder: (context, state) {
            var cubit = ChallengeCubit.get(context);
            if (state is GetChallengeDataSuccessState ||
                state is GetNexQuizSuccessState || state is CheckAnsSuccessState
            || state is QuizTimeState) {
              return Padding(
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
                                Text(
                                  'النقاط',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                                Text(
                                  'السؤال',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${cubit.userChallengePoints}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                                Text(
                                  '${cubit.quizNumber+1}/10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_rounded,
                                  color: AppColor.white,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: cubit.remainingSeconds/cubit.quizFixedTime,
                                    backgroundColor: Colors.black,
                                    color: AppColor.teal,
                                    borderRadius: BorderRadius.circular(20.r),
                                    minHeight: 20.h,
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Text(" ${cubit.remainingSeconds} ثانية",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      //The Question
                      Text(
                        cubit.challengeModel?.questions?[cubit.quizNumber]
                                .quiz ??
                            "",
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 60.sp,
                          fontFamily: 'QCF',
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      //The Choices
                      ChoiceWidget(
                          optionValue: cubit.challengeModel
                              ?.questions?[cubit.quizNumber].opt1 ?? "",
                      optionNum: "opt1",
                        bgColor:(cubit.quizAns == "opt1") ? AppColor.foregroundColor:Colors.red,),
                      SizedBox(
                        height: 40.h,
                      ),
                      ChoiceWidget(
                          optionValue: cubit.challengeModel
                              ?.questions?[cubit.quizNumber].opt2 ?? "",
                          optionNum: "opt2",
                        bgColor:(cubit.quizAns == "opt2") ? AppColor.foregroundColor:Colors.red,),
                      SizedBox(
                        height: 40.h,
                      ),
                      ChoiceWidget(
                          optionValue: cubit.challengeModel
                          ?.questions?[cubit.quizNumber].opt3 ?? "",
                          optionNum: "opt3",
                        bgColor:(cubit.quizAns == "opt3") ? AppColor.foregroundColor:Colors.red,),
                      SizedBox(
                        height: 40.h,
                      ),
                      ChoiceWidget(
                          optionValue: cubit.challengeModel
                              ?.questions?[cubit.quizNumber ].opt4 ?? "",
                          optionNum: "opt4",
                      bgColor: (cubit.quizAns == "opt4") ? AppColor.foregroundColor:Colors.red,),
                      SizedBox(
                        height: 80.h,
                      ),
                      //Button to navigate to next question or get result
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.lightGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              )),
                          onPressed: () {
                            //Temp navigate to result screen
                            if (((cubit.challengeModel?.questions?.length ??
                                    0)-1) ==
                                cubit.quizNumber) {
                             if(cubit.isSelected){
                               Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) =>
                                         ChallengeScoreScreen(),
                                   ));
                             }
                            } else {
                              if(cubit.isSelected){
                                cubit.getNextQuiz();
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'التالي',
                                style: TextStyle(color: AppColor.black,
                                fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColor.black,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              );
            }
            else if (state is GetChallengeDataErrorState) {
              return Center(
                child: Text(
                  'حدث خطأ برجاء المحاولة في وقت اخر',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            } else if(state is GetChallengeDataLoadingState){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      ' جاري التحميل ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50.sp,
                          color: Colors.black),
                    )
                  ],
                ),
              );
            }else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      ' جاري التحميل ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50.sp,
                          color: Colors.black),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

