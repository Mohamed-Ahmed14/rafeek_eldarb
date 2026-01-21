import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';
import '../../view_model/cubit/quran_cubit/quran_cubit.dart';

class PrayerTimesWidget extends StatelessWidget {
  final Map<String,dynamic> time;
  final int prayerIndex;
  const PrayerTimesWidget({required this.prayerIndex,required this.time,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

        padding: EdgeInsetsDirectional.all(30.sp),
        height: 150.h,
        decoration: BoxDecoration(
            color: AppColor.foregroundColor,
            borderRadius: BorderRadius.circular(15.r)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image.asset('assets/images/mosque3.png'),
            getPrayerIcon(prayerIndex),
            Text("${time.keys}".replaceAll(RegExp(r'\('), '').replaceAll(RegExp(r'\)'), ''),style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.sp,
              color: Colors.grey[300]
            ),),
            Text('${QuranCubit.get(context).convertToArabicNumbers(
                (time.values).toString())}'.replaceAll(RegExp(r'\('), '').replaceAll(RegExp(r'\)'),''),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                color: Colors.grey[300]
              ),),

          ],
        )
    );
  }
}


Widget getPrayerIcon(int prayerIndex){

  switch(prayerIndex){
    case 0:
      return Icon(FontAwesomeIcons.solidMoon,color: AppColor.white,);
    case 1:
      return Icon(Icons.cloud,color:Colors.white70);
    case 2:
      return Icon(Icons.sunny,color: Colors.yellow,);
    case 3:
      return Icon(Icons.sunny_snowing,color: Colors.yellow[800],);
    case 4:
      return Icon(FontAwesomeIcons.moon,color: AppColor.white);
    case 5:
      return Icon(FontAwesomeIcons.cloudMoon,color:AppColor.white);
    default:
  return Image.asset('assets/images/mosque3.png');
  }


}