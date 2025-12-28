import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeek_eldarb/model/challenges/user_model.dart';
import 'package:rafeek_eldarb/view_model/cubit/challenge_cubit/challenge_state.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_keys.dart';

class ChallengeCubit extends Cubit<ChallengeState>{
  ChallengeCubit():super(ChallengeInitState());

  static ChallengeCubit get(context)=>BlocProvider.of<ChallengeCubit>(context);

  //auth instance
  var auth = FirebaseAuth.instance;
  //FireStore Instance
  var fs = FirebaseFirestore.instance;
  //First Check internet connection
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
  //get user data
  ///Enhance This Flow Later
  Future<void> getUserData() async{
    //First Check Internet Connection
    bool isConnected = await isInternetConnected();
    if(!isConnected){
      print("No Internet Connection");
      emit(NoInternetConnectionState());
      return;
    }
    else{
      print("Internet Connection Available");
      //Second Check if user is signed in and have uid stored in shared preference
      String? uid = await SharedHelper.get(key: SharedKeys.uid);
      if(uid == null) {
        await signInAnonymously();
      }
        ///get user data from firebase fireStore
      await getUserDataFireStore();
      //emit(GetUserDataSuccessState());

    }
  }

 //Sign In Anonymously
  Future<void> signInAnonymously() async{
    emit(SignInAnonymouslyLoadingState());
    try{
      final userCredential = await auth.signInAnonymously();
      //check created
      print(userCredential.user!.uid);
      await SharedHelper.set(key: SharedKeys.uid, value: userCredential.user!.uid);
      ///create doc in fireStore users collection
      String? uid = await SharedHelper.get(key: SharedKeys.uid);
      if(uid != null){
        UserModel user = UserModel(
            uid: uid,
            challengesPassed: 0,
            totalScore: 0
        );
        await createUserInitialData(user.toJson());
      }
      print("SignInAnonymouslySuccess");
      print(auth.currentUser!.uid);
      emit(SignInAnonymouslySuccessState());
    }catch (e){
      print("error in signInAnonymously: $e");
      emit(SignInAnonymouslyErrorState());
    }
  }
///store uid in first time to fireStore
  Future<void> createUserInitialData(Map<String,dynamic> data)async{
    emit(CreateUserDataLoadingState());
    try{
      String uid = await SharedHelper.get(key: SharedKeys.uid);
      await fs.collection(SharedKeys.users).doc(uid).set(data);
      print("Create user doc successfully");
      emit(CreateUserDataSuccessState());
    }catch(e){
      print("Error creating userData");
      emit(CreateUserDataErrorState());
    }
  }

///Get User Data
 UserModel? userData;
Future<void> getUserDataFireStore() async{
    emit(GetUserDataLoadingState());
    String? uid = await SharedHelper.get(key: SharedKeys.uid);
    if(uid == null){
      return;
    }
    try{
      await fs.collection(SharedKeys.users).doc(uid).get().then((value){
        print(value.data());
        if(value.data() != null){
          userData = UserModel.fromJson(value.data()!);
        }
      });
      // await fs.collection(SharedKeys.users).get().then((value){
      //   for(var doc in value.docs){
      //     if(doc.id == uid){
      //       userData = UserModel.fromJson(doc.data());
      //     }
      //   }
      // });
      print("Get user Data Successfully");
      print(userData!.uid);
      print(userData!.totalScore);
      print(userData!.challengesPassed);
      emit(GetUserDataSuccessState());
    }catch(e){
      print("Error Getting User Data");
      emit(GetUserDataErrorState());
    }
}
 // Firebase Authentication
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

}