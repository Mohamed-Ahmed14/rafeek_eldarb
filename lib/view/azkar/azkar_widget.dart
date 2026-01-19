import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/cubit/quran_cubit/quran_cubit.dart';

class AzkarWidget extends StatelessWidget {
  final Map<String,dynamic> azkarMap;
  final int index;
  const AzkarWidget({required this.index,required this.azkarMap,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(20.sp),
      decoration: BoxDecoration(
          color: Colors.brown[100],
          borderRadius: BorderRadius.circular(20.r)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(azkarMap["content"],style: TextStyle(
              fontSize: 50.sp,
              fontWeight: FontWeight.w700
          ),),
          Divider(
            color: Colors.grey,
          ),
          if(azkarMap["description"] != "")
          Text(azkarMap["description"],style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey[800]
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('العدد: ${QuranCubit.get(context).convertToArabicNumbers(
                  azkarMap["count"])}',style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red[700]
              ),),
              // BlocBuilder<AzkarCubit,AzkarState>(
              //   builder: (context, state) {
              //     return IconButton(onPressed: (){
              //       AzkarCubit.get(context).toggle(azkarMap,index);
              //     },
              //       icon: AzkarCubit.get(context).isSaved(index,azkarMap)?
              //       Icon(Icons.bookmark,color: Colors.blueGrey[700],):
              //       Icon(Icons.bookmark_border_rounded,color: Colors.blueGrey[700],),
              //     );
              //   },
              //
              // )
            ],

          ),
        ],
      ),
    );
  }
}
