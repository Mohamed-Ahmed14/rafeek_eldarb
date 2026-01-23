import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  ///Message
  String defaultMessage = "وَمَنْ يَتَّقِ اللَّهَ يَجْعَلْ لَهُ مَخْرَجًا * وَيَرْزُقْهُ مِنْ حَيْثُ لَا يَحْتَسِبُ وَمَنْ يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ إِنَّ اللَّهَ بَالِغُ أَمْرِهِ قَدْ جَعَلَ اللَّهُ لِكُلِّ شَيْءٍ قَدْرًا";
  String defaultMsgDesc = "سورة الطلاق";
  bool isMsgDescActive = false;
  String msgDocID = '1';

  String? dailyMsg;
  String? dailyMsgDesc;
  bool isDailyMsgDescActive = false;
  
  
  Future<void> getDailyMessage() async{
     dailyMsg = null;
     dailyMsgDesc = null;
     isDailyMsgDescActive = false;

    emit(GetMessageLoadingState());
    try{
      await FirebaseFirestore.instance.collection(SharedKeys.message).doc(msgDocID).get().then((value){
        if(value.data() != null && value.get('msg') != ""){
          dailyMsg = value.get('msg');
          dailyMsgDesc = value.get('desc');
          isDailyMsgDescActive = value.get('isDescActive');
      }});
      emit(GetMessageSuccessState());
    }catch(e){
      emit(GetMessageErrorState());
    }
  }

  ///Notification
 bool isActive = true;

 void initNotificationStatus() async{
   isActive =  await SharedHelper.get(key: SharedKeys.notificationEnabled) ?? true;
   emit(GetNotificationStatusState());
 }
  void changeNotificationStatus()  async{
    isActive = !isActive;
    await SharedHelper.set(key: SharedKeys.notificationEnabled, value: isActive);
    if(isActive){
      FirebaseMessaging.instance.subscribeToTopic("All");
    }else{
      FirebaseMessaging.instance.unsubscribeFromTopic("All");
    }
    emit(ChangeNotificationStatusState());
  }



}