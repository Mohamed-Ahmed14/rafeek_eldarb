import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeek_eldarb/view_model/cubit/prayer_cubit/prayer_state.dart';


class PrayerCubit extends Cubit<PrayerState>{
  PrayerCubit() : super(PrayerInitState());
  static PrayerCubit get(context)=>BlocProvider.of<PrayerCubit>(context);


List<Map<String,dynamic>> times = [];
  // Prayer? prayer = null;
  // ///Get Prayer Times
  // Future<void> getPrayerTimes() async{
  //   emit(GetPrayerTimesLoadingState());
  //   await DioHelper.get(endPoint: 'getPrayerTimes',).then((value){
  //     prayer = Prayer.fromJson(value.data);
  //     setPrayerTimes();
  //     emit(GetPrayerTimesSuccessState());
  //   }).catchError((error){
  //     emit(GetPrayerTimesErrorState());
  //   });
  //
  // }

   final Dio _dio =Dio(
     BaseOptions(
       baseUrl: 'https://api.aladhan.com/v1/timingsByCity/',
       receiveDataWhenStatusError: true,
     ),
   );
   dynamic  prayerTimesByCity = null;
  Future<void> getPrayerTimesByCity() async{
    //print("in $prayerTimesByCity");
    //City is fixed now as Cairo
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    emit(GetPrayerTimesLoadingState());
    try{
      var response = await _dio.get('$date?city=Cairo&country=Egypt&method=5');
      if(response.data["code"] == 200){
        prayerTimesByCity =  response.data["data"]["date"]["hijri"];
       //print(prayerTimesByCity["weekday"]["ar"]);
        Map<String,dynamic> data = response.data["data"]["timings"];
        setPrayerTimes(prayerTimes: data);
        if(prayerTimesByCity !=  null && times.isNotEmpty){
          // print("out $prayerTimesByCity");
          emit(GetPrayerTimesSuccessState());
        }
        //emit(GetPrayerTimesSuccessState());
      }else{
        emit(GetPrayerTimesErrorState());
      }
    }catch(e){
      emit(GetPrayerTimesErrorState());
    }

  }

  void setPrayerTimes({Map<String,dynamic>? prayerTimes}){
  if(prayerTimes != null){
    times = [
      {
        "الفجر": prayerTimes["Fajr"],
      },
      {
        "الشروق": prayerTimes["Sunrise"],
      },
      {
        "الظهر": prayerTimes["Dhuhr"],
      },
      {
        "العصر": prayerTimes["Asr"],
      },
      {
        "المغرب": prayerTimes["Maghrib"],
      },
      {
        "العشاء": prayerTimes["Isha"],
      }
    ];
  }

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