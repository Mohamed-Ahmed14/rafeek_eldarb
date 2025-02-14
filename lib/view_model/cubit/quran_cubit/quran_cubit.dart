import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeek_eldarb/model/mushaf_model.dart';
import 'package:rafeek_eldarb/model/quran_surahs_model.dart';
import 'package:rafeek_eldarb/model/surah_model.dart';
import 'package:rafeek_eldarb/view/home/home_screen.dart';
import 'package:rafeek_eldarb/view/mushaf/mushaf_screen.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_state.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_keys.dart';
import 'package:rafeek_eldarb/view_model/data/network/dio_helper.dart';
import 'package:rafeek_eldarb/view_model/data/network/end_points.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';
import 'package:quran/quran.dart' as quran;

import '../../../view/azkar/azkar_categories_screen.dart';
import '../../../view/azkar/azkar_screen.dart';
import '../../../view/prayer_times/prayer_times_screen.dart';
import '../../../view/quran_audio/audio_screen.dart';
import '../../../view/settings/settings_screen.dart';

class QuranCubit extends Cubit<QuranState>{
  QuranCubit():super(QuranInitState());

  static QuranCubit get(context)=>BlocProvider.of<QuranCubit>(context);

  ///Layout Screen [BottomNavigationBar]
  ///List of screens and current_index
  List<Widget> screens = [
    SettingsScreen(),
    AzkarCategoriesScreen(),
    HomeScreen(),
    AudioScreen(),
    PrayerTimesScreen(),
  ];

  int screenIndex = 2;
  void updateScreenIndex(int index){
    screenIndex = index;
    emit(UpdateScreenIndexState());
  }

  ///To Convert English Number to Arabic Number
  String convertToArabicNumbers(String input) {
    const englishToArabic = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    return input.split('').map((char) {
      return englishToArabic[char] ?? char;
    }).join();
  }

  //initialization
  MushafModel? mushafModel ;
  void quranInitialization () async{
    mushafModel =  MushafModel(
        totalJuzCount: quran.totalJuzCount,
        totalPagesCount: quran.totalPagesCount,
        totalSurahCount: quran.totalSurahCount,
        totalVerseCount: quran.totalVerseCount,
    basmala: quran.basmala);
  }

  //Visible and non-visible app Bar
  bool isVisible = false;
  void changeAppBarStatus(){
    emit(ChangeAppBarLoadingState());
    isVisible = !isVisible;
    emit(ChangeAppBarState());
  }

  //change text mode
  bool isSingleLine = true;
  void changeTextMode() async{
    isSingleLine = !isSingleLine;
    await SharedHelper.set(key: SharedKeys.singleMode, value: isSingleLine);
    emit(ChangeTextModeState());
  }

  ///Note: Used to changed font size
  double sliderValue = 60;
  void changeSliderValue(double value)async{
    emit(ChangeSliderLoadingState());
    sliderValue = value;
    await SharedHelper.set(key: SharedKeys.sliderValue, value: sliderValue);
    emit(ChangeSliderValueState());
  }

  ///First Text Mode (Single Line)
  ///List<dynamic> to contain surahs number and Verses in the page
  ///each verse is also a List of String and end Verse symbol
  List<dynamic> pageDetails = [];
  List<dynamic> data = [];
  String verseText = '';
  int pageIndex = 1;
  void getPageDetails(int pageNumber){
    pageIndex = pageNumber;
    data.clear();
    pageDetails = quran.getPageData(pageNumber);
    for(int i = 0;i<pageDetails.length;i++){
        if(pageDetails[i]["start"] == 1){
          data.add(pageDetails[i]["surah"]); // insert surah number in list
        }
      for(int j=pageDetails[i]["start"];j<=pageDetails[i]["end"];j++){
        verseText = '';
        verseText = quran.getVerse(pageDetails[i]["surah"], j,verseEndSymbol: true);
        data.add(verseText); // insert verse in List
      }
    }
    emit(GetPageDetailsState());
  }

  String getSurahName(int pageNumber){
    int surahNumber = quran.getPageData(pageNumber).last["surah"];
    String surahName = quran.getSurahNameArabic(surahNumber);
    return surahName;
  }

  int getJuzNumberEnglish(){
    int surahNumber = quran.getPageData(pageIndex).last["surah"];
    int verseNumber = quran.getPageData(pageIndex).last["end"];
    return quran.getJuzNumber(surahNumber, verseNumber);
  }

  List<dynamic> pageData = [];
  List<InlineSpan> spans = [];
  //int pageNumber = 0;

  void getQuranPage(int value) {
    List<InlineSpan> newSpans = [];
    spans.clear();

   // pageNumber = value;
    pageIndex = value;
   pageData = quran.getPageData(pageIndex);
   
   emit(GetSurahLoadingState());
      for(int i=0;i<pageData.length;i++){
        if(isNewSurah(i)){
          ///Draw Header Contain Surah Name
          newSpans.add(WidgetSpan(child: Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.all(10.sp),
            //margin: EdgeInsetsDirectional.all(20.sp),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown),
              image: DecorationImage(image: AssetImage('assets/images/surah_name_header.png'),fit: BoxFit.fill),
            ),
            child: Text(quran.getSurahNameArabic(pageData[i]["surah"]),textAlign: TextAlign.center,style: TextStyle(
                fontSize: 60.sp,fontWeight: FontWeight.bold
            ),),
          ),));
          newSpans.add(TextSpan(text: '\n'));
          if(pageData[i]["surah"] != 1 && pageData[i]["surah"] != 9)
            {
              newSpans.add(WidgetSpan(
                child: Center(
                  child: Text("${quran.basmala}   ",style: TextStyle(
                      fontSize: sliderValue.sp,
                      fontWeight: FontWeight.bold,
                  ),textAlign: TextAlign.center,),
                )
              ),);
            }
        }
        newSpans.add(WidgetSpan(child: Text('\n')));
        ///Same Surah Name -> Write Verse and VerseSymbol
        for(int j = pageData[i]["start"];j<=pageData[i]["end"]; j++){
          newSpans.add(TextSpan(text: quran.getVerse(pageData[i]["surah"], j,)
          ,style: TextStyle(fontFamily: 'QCF',fontSize: sliderValue.sp,)));
          newSpans.add(TextSpan(text: ' '));
          newSpans.add(TextSpan(
              text: quran.getVerseEndSymbol(j,arabicNumeral: true),
              style: TextStyle(
              color: AppColor.tealDark
          )
          )
          );
          newSpans.add(TextSpan(text: ' '));
        }
      }
      spans = newSpans;
    emit(GetQuranSurahsSuccessState());
  }

  List<Map<String,dynamic>> surahsNameAndAyah = [];

  Future<void> getSurahsNames() async{
    surahsNameAndAyah.clear();
    emit(GetQuranSurahsLoadingState());
    for(int i=1;i<=114;i++){
      surahsNameAndAyah.add({
        "surahNumber" : i,
        "surahNameArabic":quran.getSurahNameArabic(i),
        "totalAyah" :quran.getVerseCount(i)
      });
    }
    emit(GetQuranSurahsSuccessState());
  }

  int getSurahPageNumber (int surahCount) {
    int pageIndex = quran.getPageNumber(surahCount, 1);
    //pageController.jumpToPage(pageIndex);
    return pageIndex;

  }

  //To Get if it is new surah or not
  bool isNewSurah(int surahNumber){
    if(pageData[surahNumber]["start"] == 1)
      {
        return true;
      }
    return false;
  }

  int surahVerseCount(int surahNumber){
     return quran.getVerseCount(surahNumber);
  }


}