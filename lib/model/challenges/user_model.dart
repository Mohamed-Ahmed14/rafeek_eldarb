class UserModel{
  String? uid;
  int? totalScore;
  int? challengesPassed;

  UserModel({this.uid,this.totalScore,this.challengesPassed});
   UserModel.fromJson(Map<String,dynamic> json){
     uid = json["uid"];
     totalScore = json["totalScore"];
     challengesPassed = json["challengesPassed"];
  }
  Map<String,dynamic> toJson(){
     return {
       "uid":uid,
       "totalScore":totalScore,
       "challengesPassed":challengesPassed
     };
  }
}