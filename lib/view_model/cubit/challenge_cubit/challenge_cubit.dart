import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeek_eldarb/model/challenges/challenge_model.dart';
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
//Use That in UI
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


///Here Challenge Questions
 ChallengeModel? challengeModel;
Future<void> qetChallengeData(int challengeID) async{
  emit(GetChallengeDataLoadingState());
  try{
    await fs.collection(SharedKeys.challenges).doc(challengeID.toString()).get().then((value){
      if(value.data() != null){
        challengeModel = ChallengeModel.fromJson(value.data()!);
        challengeModel?.questions =[];
        //print(value.data());
      }
    });
    await fs.collection(SharedKeys.challenges).doc(challengeID.toString()).
    collection(SharedKeys.questions).get().then((value){
      for(var i in value.docs){
        challengeModel?.questions?.add(QuestionModel.fromJson(i.data()));
        //print(challengeModel?.questions?[0].opt1);
        //print(i.data());
        //challengeModel?.questions = ChallengeModel.fromJson(i.data());
        //print(challengeModel?.challengePoints?? []);
      }
    });
    emit(GetChallengeDataSuccessState());
  }catch(e){
    print(e.toString());
    emit(GetChallengeDataErrorState());
  }
}

///Dealing with single challenge
int quizNumber = 0; //Number of quiz
int quizPoints = 0; //quiz points
int userChallengePoints = 0; //Total user points per the active challenge
bool isRight = false;  //to check user ans
bool isSelected = false; //to check user select an option
String? quizAns = ""; //the true quiz ans
String? userAns = ""; //the user ans
int numOfRQ = 0; //Number of right questions
int numOfWQ = 0; //Number of wrong questions
int totalTimePassed = 0;  //Total time passed per challenge
int quizFixedTime = 15; //Quiz Fixed Time 15 sec
bool isTimeFinish = false;


//This function to init a challenge
void initChallenge(){
  quizNumber = 0;
  userAns = "";
  quizAns = "";
  quizPoints = 0;
  userChallengePoints = 0;
  isRight = false;
  isSelected = false;
  numOfRQ = 0;
  numOfWQ = 0;
  totalTimePassed = 0;
  isTimeFinish = false;
}
//This function increase quiz index++
void getNextQuiz(){
  stopTimer();
  quizNumber++;
  quizPoints=0;
  isSelected = false;
  isRight = false;
  isTimeFinish = false;
  startCountdown();
emit(GetNexQuizSuccessState());
}


void checkAns(String? optNum){
  totalTimePassed+=(quizFixedTime-remainingSeconds);
  isSelected =true;
  userAns = optNum;
  quizAns = challengeModel?.questions?[quizNumber].ans;
  if((quizAns ?? "") == optNum){
    isRight = true;
    quizPoints = 10;
    numOfRQ++;
  }else{
    isRight =false;
    quizPoints = 0;
    numOfWQ++;
  }
  userChallengePoints=userChallengePoints+quizPoints;
  emit(CheckAnsSuccessState());
}

///Dealing with timer
Timer? timer;
int remainingSeconds = 15;
void startCountdown(){
  timer?.cancel();
  remainingSeconds = quizFixedTime;
  timer = Timer.periodic(
  const Duration(seconds: 1),
      (timer) {
if(remainingSeconds == 0){
  timer.cancel();
  //Time Passed Go to next question
  userAns = "None";
  checkAns("wrong");
  print("Not Answer");
  isTimeFinish = true;
  emit(TimeUpState());
}else{
  if(!isSelected){
    remainingSeconds --;
    emit(QuizTimeState());
  }

}
      },);
}
// void startTimer(){
//   timer = Timer(Duration(seconds: 30), () => print("Time Finish"),);
// }
void stopTimer(){
  timer?.cancel();
  emit(TimerStopState());
}
}