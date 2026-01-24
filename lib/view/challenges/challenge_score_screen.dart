import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafeek_eldarb/view/challenges/challenge_screen.dart';
import 'package:rafeek_eldarb/view/challenges/question_screen.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_state.dart';
import '../../view_model/utils/app_colors.dart';

class ChallengeScoreScreen extends StatefulWidget {
  const ChallengeScoreScreen({super.key});

  @override
  State<ChallengeScoreScreen> createState() => _ChallengeScoreScreenState();
}

class _ChallengeScoreScreenState extends State<ChallengeScoreScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChallengeCubit.get(context).updateChallengeScore();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        _handleBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.teal[800],
          body: BlocBuilder<ChallengeCubit,ChallengeState>(
            builder: (context, state) {
              if(state is GetUserDataSuccessState){
                return Padding(
                  padding: EdgeInsetsDirectional.all(20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.sizeOf(context).height/16),
                        //Award Img
                        Container(
                          padding: EdgeInsetsDirectional.all(40.w),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal
                          ),
                          child: Image.asset('assets/images/quiz/award.png',
                            width: 120.w,height: 120.h,fit: BoxFit.cover,),
                        ),
                        SizedBox(height: 40.h,),
                        //Total points
                        Text('مجموع النقاط',style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600
                        ),),
                        Text('${ChallengeCubit.get(context).userChallengePoints}',style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 100.sp,
                            fontWeight: FontWeight.w800
                        ),),

                        //The message based on score
                        if(ChallengeCubit.get(context).numOfRQ <= 5)
                          Text('عمل رائع يمكنك التحسن !',style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w600
                          ),),
                        if(ChallengeCubit.get(context).numOfRQ  > 5 &&
                            ChallengeCubit.get(context).numOfRQ  <= 8)
                          Text('اداء رائع استمر في التقدم !',style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w600
                          ),),
                        if(ChallengeCubit.get(context).numOfRQ >8 &&
                            ChallengeCubit.get(context).numOfRQ <= 10)
                          Text('ممتاز !',style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w600
                          ),),
                        SizedBox(height: 40.h,),
                        //Details of time passed and score
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsetsDirectional.all(20.w),
                                decoration: BoxDecoration(
                                  color: Colors.teal[900],
                                  border: Border.all(color: Colors.teal),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsetsDirectional.all(10.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [BoxShadow(color: Colors.teal[800]!)],
                                        )
                                        ,child: Icon(Icons.percent_rounded,color: Colors.cyanAccent,)),
                                    SizedBox(height: 20.h,),
                                    Text('${ChallengeCubit.get(context).numOfRQ * 10}%',style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.white
                                    ),),
                                    SizedBox(height: 10.h,),
                                    Text('النتيجة',style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white54
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w,),
                            Expanded(
                              child: Container(
                                padding: EdgeInsetsDirectional.all(20.w),
                                decoration: BoxDecoration(
                                  color: Colors.teal[900],
                                  border: Border.all(color: Colors.teal),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsetsDirectional.all(10.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [BoxShadow(color: Colors.teal[800]!)],
                                        )
                                        ,child: Icon(Icons.timer_rounded,color: Color(0xffeeeeee),)),
                                    SizedBox(height: 20.h,),
                                    Text('${ChallengeCubit.get(context).totalTimePassed %60} : '
                                        '${ChallengeCubit.get(context).totalTimePassed ~/ 60}',style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.white
                                    ),),
                                    SizedBox(height: 10.h,),
                                    Text('الوقت المستغرق',style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white54
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h,),
                        //Details of correct ans and wrong ans
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsetsDirectional.all(20.w),
                                decoration: BoxDecoration(
                                  color: Colors.teal[900],
                                  border: Border.all(color: Colors.teal),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsetsDirectional.all(10.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [BoxShadow(color: Colors.teal[800]!)],
                                        )
                                        ,child: Icon(Icons.check_circle_rounded,color: Colors.cyanAccent,)),
                                    SizedBox(height: 20.h,),
                                    Text('${ChallengeCubit.get(context).numOfRQ}',style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.white
                                    ),),
                                    SizedBox(height: 10.h,),
                                    Text('إجابات صحيحة',style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white54
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w,),
                            Expanded(
                              child: Container(
                                padding: EdgeInsetsDirectional.all(20.w),
                                decoration: BoxDecoration(
                                  color: Colors.teal[900],
                                  border: Border.all(color: Colors.teal),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsetsDirectional.all(10.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [BoxShadow(color: Colors.teal[800]!)],
                                        )
                                        ,child: Icon(Icons.cancel,color: Colors.red[900],)),
                                    SizedBox(height: 20.h,),
                                    Text('${ChallengeCubit.get(context).numOfWQ}',style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.white
                                    ),),
                                    SizedBox(height: 10.h,),
                                    Text('إجابات خاطئة',style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white54
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80.h,),
                        ///Implement play again strategy
                        //PLay Again
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                )
                            ),
                            onPressed: (){
                              var cubit = ChallengeCubit.get(context);
                              //Init the challenge
                              cubit.initChallenge();
                              //Get data challenge data
                              cubit.getChallengeData(cubit.challengeNumber);
                              //Navigate To QuestionScreen
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => QuestionScreen(),));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.replay_rounded,color: AppColor.white,),
                                SizedBox(width: 20.w,),
                                Text('إعادة التحدي',style: TextStyle(
                                    color: AppColor.white
                                ),),
                              ],
                            )),
                        SizedBox(height: 40.h,),
                        //Button to navigate to challenges screen
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                )
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChallengeScreen(),),);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Icon(FontAwesomeIcons.list,color: AppColor.black,size: 50.w,),
                                SizedBox(width: 20.w,),
                                Text('العودة إلي التحديات',style: TextStyle(
                                    color: AppColor.black
                                ),),

                              ],
                            )),
                      ],
                    ),
                  ),
                );
              }else if(state is UpdateChallengeScoreErrorState || state is UpdateUserDataErrorState){
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
      ),
    );
  }
}


Future<bool> _handleBack(BuildContext context) async {
  // لو عايز pop
  ChallengeCubit.get(context).getUserData();
  Navigator.pop(context);
 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChallengeScreen(),));

  // لو عايز pushReplacement
  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(builder: (_) => NextPage()),
  // );

  return false;
}