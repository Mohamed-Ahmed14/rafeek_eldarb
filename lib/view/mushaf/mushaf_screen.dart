import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/view/mushaf/quran_page_widget.dart';
import 'package:rafeek_eldarb/view_model/cubit/settings_cubit/settings_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/settings_cubit/settings_state.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_keys.dart';
import '../../view_model/cubit/quran_cubit/quran_cubit.dart';
import '../../view_model/cubit/quran_cubit/quran_state.dart';
import '../../view_model/utils/app_colors.dart';

class MushafScreen extends StatefulWidget {
  final int pageIndex;
  const MushafScreen({this.pageIndex = 1,super.key});

  @override
  State<MushafScreen> createState() => _MushafScreenState();
}

class _MushafScreenState extends State<MushafScreen> {
  late PageController pageController;
  late int currentPage;

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController(initialPage: widget.pageIndex-1);
    if(QuranCubit.get(context).isSingleLine){
      QuranCubit.get(context).getPageDetails(widget.pageIndex);
    }else{
      QuranCubit.get(context).getQuranPage(widget.pageIndex);
    }
    QuranCubit.get(context).isVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit,QuranState>(
        builder: (context, state)
        {
          var cubit = QuranCubit.get(context);
          return SafeArea(
              child: GestureDetector(
                onTap: (){
                  //to show sticky bar
                  cubit.changeAppBarStatus();
                },
                child: Scaffold(
                  backgroundColor: Colors.brown[100],
                  appBar: !cubit.isVisible ?
                  AppBar(
                    backgroundColor: Colors.brown[100],
                    elevation: 0.8,
                    toolbarHeight: 100.h,
                    leadingWidth: 200.w,
                    leading: Text('  ${cubit.getSurahName(cubit.pageIndex)}',style: TextStyle(
                        fontSize: 40.sp,fontWeight: FontWeight.w700,height: 8.h
                    ),),
                    actions: [
                      Text("الجزء ${cubit.convertToArabicNumbers(
                          cubit.getJuzNumberEnglish().toString())}  ",style: TextStyle(
                        fontSize: 40.sp,fontWeight: FontWeight.w700
                      ),),
                      SizedBox(width: 10.w,),
                    ],
                  ):
                  AppBar(
                    backgroundColor: Colors.brown[100],
                    elevation: 1,
                    toolbarHeight: 100.h,
                    leading: IconButton(onPressed:(){
                      Navigator.pop(context);
                    },
                      icon: Icon(Icons.arrow_back_ios_rounded,size: 60.sp,),color: Colors.teal,),
                    actions: [
                      IconButton(onPressed:() {
                        cubit.changeTextMode();
                        if(QuranCubit.get(context).isSingleLine){
                          QuranCubit.get(context).getPageDetails(cubit.pageIndex);

                        }else{
                          QuranCubit.get(context).getQuranPage(cubit.pageIndex);

                        }
                      },
                          icon: Icon(Icons.wrap_text_rounded,
                            color: cubit.isSingleLine ? Colors.teal : Colors.brown[700],)),
                      SizedBox(width: 10.w,),
                    ],
                  ),

                  body: PageView.builder(
                      controller: pageController,
                      onPageChanged: (int value) {
                        if(cubit.isSingleLine){
                          QuranCubit.get(context).getPageDetails(value+1);
                        }else{
                          QuranCubit.get(context).getQuranPage(value + 1);
                        }

                      },
                      itemCount: QuranCubit
                          .get(context)
                          .mushafModel
                          ?.totalPagesCount ?? 604,
                      itemBuilder: (context, index) {
                        return Stack(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          children: [
                            //Page Date
                            cubit.isSingleLine?
                            ListView.builder(
                              padding: cubit.pageIndex <= 2 ? EdgeInsetsDirectional.only(
                                  top:MediaQuery.of(context).size.height/10):null,
                              itemBuilder: (context, index) {
                                return QuranPageWidget(element: cubit.data[index]);
                              },
                              itemCount: cubit.data.length,):
                            Container(
                              margin: EdgeInsetsDirectional.all(10.sp),
                              child: ListView(
                                shrinkWrap: true,
                                padding: cubit.pageIndex <= 2 ? EdgeInsetsDirectional.only(
                                    top:MediaQuery.of(context).size.height/10):null,
                                children: [
                                  RichText(
                                    textAlign: (pageController.page==0 || pageController.page==1)?TextAlign.center:TextAlign.start ,
                                    text: TextSpan(
                                      children: QuranCubit.get(context).spans,
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: MediaQuery.of(context).size.width*0.045,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'QCF'
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                  ///We should remove that and column
                                  //Text("Page Number = ${QuranCubit.get(context).pageNumber}"),
                                ],
                              ),
                            ),
                            // Sticky bar
                            AnimatedOpacity(
                              opacity: cubit.isVisible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 80.h,
                                  color: AppColor.foregroundColor,
                                  child:  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BlocBuilder<SettingsCubit,SettingsState>(
                                          builder: (context, state) {
                                            return IconButton(onPressed: () {
                                              SettingsCubit.get(context).savePageNumber(cubit.pageIndex);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: SizedBox(height: 80.h,
                                                  child: Text('تم حفظ الصفحة',style: TextStyle(
                                                    color: Colors.white,
                                                  ),textAlign: TextAlign.center,),
                                                ),duration: Duration(seconds: 2),
                                                backgroundColor: Colors.brown,
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                padding: EdgeInsetsDirectional.all(0),),
                                              );
                                            },
                                              icon: SettingsCubit.get(context).isSaved &&
                                                  (cubit.pageIndex == SharedHelper.get(key: SharedKeys.savedPage))
                                                  ?Icon(Icons.bookmark_rounded,size: 60.w,
                                                color: Colors.white,):Icon(Icons.bookmark_border_rounded,size: 60.w,
                                              color: Colors.black,),);
                                          },
                                        ),
                                        Text(
                                          ' صفحة ${cubit.convertToArabicNumbers(cubit.pageIndex.toString())}',style: TextStyle(
                                            color: Colors.white
                                        ),
                                        ),
                                        IconButton(onPressed: () {
                                          showModalBottomSheet(useSafeArea: true,
                                            context: context, builder: (context) {
                                              return BlocBuilder<QuranCubit,QuranState>(
                                                buildWhen: (previous, current) {
                                                  return current is ChangeSliderValueState;
                                                },
                                                builder: (context, state) {
                                                  return Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12.r),
                                                        color: AppColor.tealDark
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Text(' حجم الخط :',style: TextStyle(
                                                            color: Colors.white
                                                        ),),
                                                        Slider(
                                                          value: SharedHelper.get(key: SharedKeys.sliderValue),
                                                          onChanged: (value){
                                                            cubit.changeSliderValue(value);
                                                            if(cubit.isSingleLine){
                                                              QuranCubit.get(context).getPageDetails(cubit.pageIndex);
                                                            }else{
                                                              QuranCubit.get(context).getQuranPage(cubit.pageIndex);
                                                            }
                                                          },
                                                          activeColor: Colors.black,
                                                          inactiveColor: Colors.white,
                                                          thumbColor: Colors.black,
                                                          min: 50,
                                                          max: 75,
                                                          divisions: 4,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },);
                                        },
                                          icon: Icon(Icons.keyboard_arrow_up_rounded,size: 60.w,color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                ),
              )
          );
        }
    );


  }
}