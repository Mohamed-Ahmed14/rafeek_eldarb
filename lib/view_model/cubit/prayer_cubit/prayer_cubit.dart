import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeek_eldarb/model/prayer_model.dart';
import 'package:rafeek_eldarb/view_model/cubit/prayer_cubit/prayer_state.dart';
import 'package:rafeek_eldarb/view_model/data/network/dio_helper.dart';

class PrayerCubit extends Cubit<PrayerState>{
  PrayerCubit() : super(PrayerInitState());
  static PrayerCubit get(context)=>BlocProvider.of<PrayerCubit>(context);


Prayer? prayer = null;
List<Map<String,dynamic>> times = [];
  ///Get Prayer Times
  Future<void> getPrayerTimes() async{
    emit(GetPrayerTimesLoadingState());
    await DioHelper.get(endPoint: 'getPrayerTimes',).then((value){
      prayer = Prayer.fromJson(value.data);
      setPrayerTimes();
      emit(GetPrayerTimesSuccessState());
    }).catchError((error){
      emit(GetPrayerTimesErrorState());
    });

  }

  void setPrayerTimes(){
    Map<String,dynamic> map;
  if(prayer != null){
    times = [
      {
        "الفجر": prayer?.prayerTimes?.fajr ?? "",
      },
      {
        "الشروق": prayer?.prayerTimes?.sunrise ?? "",
      },
      {
        "الظهر": prayer?.prayerTimes?.duhr ?? "",
      },
      {
        "العصر": prayer?.prayerTimes?.asr ?? "",
      },
      {
        "المغرب": prayer?.prayerTimes?.maghrib ?? "",
      },
      {
        "العشاء": prayer?.prayerTimes?.isha ?? "",
      }
    ];
  }
    emit(GetPrayerTimesSuccessState());
  }

  bool isConnected = true;
  Future<void> isInternetConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity(); //if none no internet4
    for(var i in connectivityResult){
      if(i != ConnectivityResult.none){
        isConnected = true;
      }else{
        isConnected = false;
      }
    }
     emit(InternetConnectionState());
  }

}