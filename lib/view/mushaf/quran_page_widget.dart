import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:rafeek_eldarb/view/mushaf/surah_header_widget.dart';
import 'package:rafeek_eldarb/view/mushaf/verse_widget.dart';

class QuranPageWidget extends StatelessWidget {
  final dynamic element;
  const QuranPageWidget({required this.element,super.key});

  @override
  Widget build(BuildContext context) {
    if(element.runtimeType == int){
      return SurahHeaderWidget(surahName: getSurahNameArabic(element));
    }else{
      return VerseWidget(verseText: element,);
    }

  }
}
