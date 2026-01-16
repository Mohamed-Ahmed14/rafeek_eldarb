import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view/challenges/all_challenges_screen.dart';
import 'package:rafeek_eldarb/view/layout/layout_screen.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_state.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';

import '../../view_model/utils/app_colors.dart';
import 'challenge_widget.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    ChallengeCubit.get(context).getUserData();
   // ChallengeCubit.get(context).signOutAnonymously();
    super.initState();
  }
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
                  QuranCubit.get(context).updateScreenIndex(0) ;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LayoutScreen(),),
                    (route) => false,);
              },
                  icon: Icon(Icons.arrow_back_rounded,color: AppColor.white,)),
            ),
          ),
          centerTitle: true,
          title: Text(' التحديات ',style: TextStyle(
              color: Colors.white
          ),),
          actions: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(tag: 'award',
                  child: Image.asset('assets/images/quiz/award.png')),
            ),
            SizedBox(width: 20.w,),
          ],
        ),
        body: BlocConsumer<ChallengeCubit,ChallengeState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            var cubit = ChallengeCubit.get(context);
          if(state is NoInternetConnectionState){
            return Center(child: Text('لا يوجد إتصال بالإنترنت',style: TextStyle(
              color: Colors.black,
              fontSize: 50.sp,
              fontWeight: FontWeight.w700,
            ),),);
          }

          else if(state is GetUserDataErrorState || state is GetChallengesDetailsErrorState){
            return Center(child: Text('حدث خطأ برجاء المحاولة في وقت اخر',style: TextStyle(
              color: Colors.black,
              fontSize: 50.sp,
              fontWeight: FontWeight.w700,
            ),),);

          }
          else if(state is GetUserDataSuccessState){
            return Column(
              children: [
                //Person Details -> total score & number of levels finished
                Container(
                  padding: EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                    color: AppColor.foregroundColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(120.w, 80.h),bottomLeft: Radius.elliptical(120.w, 80.h),
                    ),
                  ),child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsetsDirectional.all(30.w),
                            decoration: BoxDecoration(
                              color: Colors.teal[700],
                              border: Border.all(color: AppColor.white),
                              borderRadius: BorderRadius.circular(10),
                            ),child: Column(
                            children: [
                              Text("${cubit.userData?.totalScore ?? 0}",style: TextStyle(
                                  color: Color(0xffd4b996),
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("مجموع النقاط",style: TextStyle(
                                  color: AppColor.backgroundColor,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          ),
                        ),
                        SizedBox(width: 40.w,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsetsDirectional.all(30.w),
                            decoration: BoxDecoration(
                              color: Colors.teal[700],
                              border: Border.all(color: AppColor.white),
                              borderRadius: BorderRadius.circular(10),
                            ),child: Column(
                            children: [
                              Text("${cubit.userData?.challengesPassed ?? 0}",style: TextStyle(
                                  color: Color(0xffd4b996),
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("تحديات منجزة",style: TextStyle(
                                  color: AppColor.backgroundColor,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("تقدمك العام",
                          style: TextStyle(color: AppColor.white,
                              fontWeight: FontWeight.w700),),
                        Text('${cubit.challengesDetails.length} / ${cubit.userData?.challengesPassed ?? 0}',
                          style: TextStyle(color: AppColor.white,
                            fontWeight: FontWeight.w700),)
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    LinearProgressIndicator(
                      value: (cubit.userData?.challengesPassed??0)/50,
                      backgroundColor: Colors.black,
                      color: Color(0xffd4b996),
                      borderRadius: BorderRadius.circular(20.r),
                      minHeight: 20.h,
                    ),

                  ],
                ),
                ),
                Padding(
                  padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("التحديات المتاحة",style: TextStyle(
                          color: AppColor.foregroundColor
                      ),),
                      Row(
                        children: [
                          Text("عرض الكل",
                            style: TextStyle(
                                color: Colors.grey[700]
                            ),),
                          IconButton(style: IconButton.styleFrom(
                              padding: EdgeInsetsDirectional.zero
                          ),onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllChallengesScreen(),));
                          },
                              icon: Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.grey[700],size: 15,))
                        ],
                      )

                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      padding: EdgeInsetsDirectional.all(20.w),
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChallengeWidget(challengeIndex: index,);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20.h,);
                      },
                      itemCount: 3),
                ),
              ],
            );
          }
          else{
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.black,),
                  SizedBox(height: 10.h,),
                  Text(' جاري التحميل ',style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 50.sp,
                      color: Colors.black
                  ),)
                ],
              ),
            );
          }
          // else if(state is SignInAnonymouslyLoadingState ||
            //     state is CreateUserDataLoadingState || state is GetChallengesDetailsLoadingState){
            //
            // }
          },

        )
      )
    );
  }
}
