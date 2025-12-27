import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  //Firebase Authentication
  var auth = FirebaseAuth.instance;
  void signInAnonymously() async{
    emit(SignInAnonymouslyLoadingState());
    try{
      final userCredential = await auth.signInAnonymously();
      print(userCredential.user!.uid);
      await SharedHelper.set(key: SharedKeys.uid, value: userCredential.user!.uid);
      emit(SignInAnonymouslySuccessState());
    }catch (e){
      print("error in signInAnonymously: $e");
      emit(SignInAnonymouslyErrorState());
    }
  }
  void signOutAnonymously() async{

    emit(SignOutAnonymouslyLoadingState());
    try{
       await auth.signOut();
      emit(SignOutAnonymouslySuccessState());
    }catch (e){
      print("error in signInAnonymously: $e");
      emit(SignOutAnonymouslyErrorState());
    }
  }

  bool isUserSignedIn(){
    User? user = auth.currentUser;
    if(user != null){
      return true;
    }else{
      return false;
    }
  }

 //For checking internet connection
  Future<bool> isInternetConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity(); //if none no internet
    for(var i in connectivityResult){
      if(i != ConnectivityResult.none){
      return   true;
      }else{
        return false;
      }
    }
  return false;
  }

  ///Enhance This Flow Later
  Future<void> getUserData() async{
    ///First Check Internet Connection
    bool isConnected = await isInternetConnected();
    if(!isConnected){
      print("No Internet Connection");
    }else{
      print("Internet Connection Available");
      ///Second Check if user is signed in
      bool isSignedIn = isUserSignedIn();
      if(!isSignedIn){
        print("User not signed in");
        signInAnonymously();
        ///Set Default Data for User
      }else{
        print("User is signed in");
        ///Then get user data from firebase && Shared Preferences
      }
    }


  }
}