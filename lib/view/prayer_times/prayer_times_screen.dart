import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view/prayer_times/prayer_times_widget.dart';
import 'package:rafeek_eldarb/view_model/cubit/prayer_cubit/prayer_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';

import '../../view_model/cubit/prayer_cubit/prayer_state.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    PrayerCubit.get(context).getPrayerTimes();
    PrayerCubit.get(context).isInternetConnected();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: BlocBuilder<PrayerCubit,PrayerState>(
          builder: (context, state){
            var cubit = PrayerCubit.get(context);
            return Visibility (
              visible: (PrayerCubit.get(context).isConnected == true),
              replacement: Center(child: Text('لا يوجد إتصال بالإنترنت',style: TextStyle(
                color: Colors.black,
                fontSize: 50.sp,
                fontWeight: FontWeight.w700,
              ),),),
              child: Visibility(
                replacement: Center(
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
                ),
                visible:cubit.prayer!=null,
                child: Padding(
                  padding: EdgeInsets.all(20.0.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(20.sp),
                        decoration: BoxDecoration(
                          color: AppColor.foregroundColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(cubit.prayer?.date?.dateHijri?.weekDay ?? "",style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white
                                ),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("${cubit.prayer?.date?.dateHijri?.day}-"
                                        " ${cubit.prayer?.date?.dateHijri?.month} -"
                                        "${cubit.prayer?.date?.dateHijri?.year} هجري ",style: TextStyle(
                                        fontSize: 50.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.white
                                    ),),
                                    Text('${DateTime.now().day} -'
                                        ' ${DateTime.now().month} -'
                                        ' ${DateTime.now().year} م ',style: TextStyle(
                                        fontSize: 50.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.white
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                            Divider(thickness: 2,color: Colors.black,),
                            SizedBox(height: 30.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("الصلاة ",style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white
                                ),),
                                Text(" التوقيت ",style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold,
                                  color: AppColor.white
                                ),),

                              ],
                            ),
                          ],
                        )
                      ),
                      SizedBox(height: 30.h,),
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return PrayerTimesWidget(time: PrayerCubit.get(context).times[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20.h,);
                        },
                        itemCount: PrayerCubit.get(context).times.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
