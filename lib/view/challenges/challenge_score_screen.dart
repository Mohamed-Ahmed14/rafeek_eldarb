import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafeek_eldarb/view/challenges/challenge_screen.dart';

import '../../view_model/utils/app_colors.dart';

class ChallengeScoreScreen extends StatelessWidget {
  const ChallengeScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal[800],
        body: Padding(
          padding: EdgeInsetsDirectional.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

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
              Text('تهانينا لقد فزت !',style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.w600
              ),),
              Text('90%',style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.w600
              ),),
              Text('اداء رائع استمر في التقدم',style: TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 40.h,),

              //Details of points,question number,challenge category,time
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
                            padding: EdgeInsetsDirectional.all(5.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.tealAccent)],
                              )
                              ,child: Icon(Icons.check_circle_rounded,color: Colors.teal[400],)),
                          SizedBox(height: 20.h,),
                          Text('9',style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white
                          ),),
                          SizedBox(height: 10.h,),
                          Text('إجابات صحيحة',style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white
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
                              padding: EdgeInsetsDirectional.all(5.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.redAccent)],
                              )
                              ,child: Icon(Icons.cancel,color: Colors.red[900],)),
                          SizedBox(height: 20.h,),
                          Text('1',style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white
                          ),),
                          SizedBox(height: 10.h,),
                          Text('إجابات خاطئة',style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white
                          ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الوقت المستغرق',style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w600
                  ),textAlign: TextAlign.start,),
                  Text('2:30',style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w600
                  ),textAlign: TextAlign.start,),
                ],
              ),
              LinearProgressIndicator(
                value: 45/50,
                backgroundColor: Colors.black,
                color: Colors.teal[400],
                borderRadius: BorderRadius.circular(20.r),
                minHeight: 20.h,
              ),
              SizedBox(height: 80.h,),
              //PLay Again
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      )
                  ),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChallengeScreen(),),);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('العودة إلي التحديات',style: TextStyle(
                          color: AppColor.black
                      ),),
                      SizedBox(width: 20.w,),
                      Icon(Icons.arrow_forward,color: AppColor.black,)
                    ],
                  )),
              SizedBox(height: 40.h,),
              //Button to navigate to challenges screen
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      )
                  ),
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('العودة إلي التحديات',style: TextStyle(
                          color: AppColor.black
                      ),),
                      SizedBox(width: 20.w,),
                      Icon(Icons.arrow_forward,color: AppColor.black,)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
