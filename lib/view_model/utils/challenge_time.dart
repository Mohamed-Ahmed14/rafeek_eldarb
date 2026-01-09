// import 'dart:async';
//
// class ChallengeTimer{
//   Timer? timer;
//   int remainingSeconds = 30;
//
//   void startCountdown(){
//     //timer?.cancel();
//    remainingSeconds = 30;
//     timer = Timer.periodic(
//       const Duration(seconds: 1),
//           (timer) {
//         if(remainingSeconds == 0){
//           timer.cancel();
//           print("Time Up!!");
//         }else{
//           remainingSeconds --;
//         }
//       },);
//   }
//
//   void stopTimer(){
//     timer?.cancel();
//   }
// }