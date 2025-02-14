import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';

abstract class QuranState{}

class QuranInitState extends QuranState{}

class UpdateScreenIndexState extends QuranState{}

class ChangeAppBarLoadingState extends QuranState{}
class ChangeAppBarState extends QuranState{}

class ChangeTextModeState extends QuranState{}
class ChangeSliderLoadingState extends QuranState{}
class ChangeSliderValueState extends QuranState{}

class GetPageDetailsState extends QuranState{}

class GetPageLoadingState extends QuranState{}

class GetQuranSurahsLoadingState extends QuranState{}
class GetQuranSurahsSuccessState extends QuranState{}
class GetQuranSurahsErrorState extends QuranState{}

class GetSurahLoadingState extends QuranState{}
class GetSurahSuccessState extends QuranState{}
class GetSurahErrorState extends QuranState{}

class GetNextPageSuccessState extends QuranState{}
class GetPreviousPageSuccessState extends QuranState{}