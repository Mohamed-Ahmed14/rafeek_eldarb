import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart';
import 'package:rafeek_eldarb/view_model/cubit/settings_cubit/settings_state.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_keys.dart';

class SettingsCubit extends Cubit<SettingsState>{

  SettingsCubit() : super(SettingsInitState());

  static SettingsCubit get(context)=>BlocProvider.of<SettingsCubit>(context);




  //Saving Mushaf Page Number
  bool isSaved = false;
  void savePageNumber(int value){
    SharedHelper.set(key: SharedKeys.savedPage, value: value);
    isSaved = true;
    emit(SavedPageSuccessState());
  }

  String getSurahName(int surahNumber){
    return getSurahNameArabic(surahNumber);
  }

  //Saving Playing audio
  bool isAudioSaved = false;
  void saveSurahAudio(int value){
    SharedHelper.set(key: SharedKeys.audioNumber, value: value);
    isAudioSaved = true;
    emit(SavedAudioSuccessState());
  }

}