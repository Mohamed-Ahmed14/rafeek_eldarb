import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_state.dart';


class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    QuranCubit.get(context).checkForUpdate();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit,QuranState>(
      builder: (context, state) {
        var cubit = QuranCubit.get(context);
        return Scaffold(
        body: cubit.screens[cubit.screenIndex],

          bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(icon: Image.asset('assets/images/dua.png'),title: ' بروفايل '),
                TabItem(icon: Image.asset('assets/images/arabic.png'),title: ' الأذكار ',),
                TabItem(icon: Image.asset('assets/images/holy-quran.png'),title: ' المصحف '),
                TabItem(icon: Image.asset('assets/images/audio5.png'),title: ' إستماع ',),
                TabItem(icon: Image.asset('assets/images/calendar.png'),title: ' الصلاة ',),
              ],
            initialActiveIndex: 2,
            backgroundColor: Colors.brown[100],
            activeColor:Colors.teal[900],
            color: Colors.black,
            style: TabStyle.react,
            height: 140.h,
            curveSize: 80,

            onTap: (index) {
              cubit.updateScreenIndex(index);
            },
          ),
        );
      },

    );
  }
}
