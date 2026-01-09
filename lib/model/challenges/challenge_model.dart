class ChallengeModel{
  String? category;
  int? challengePoints;
  int? numOfQuestions;
  List<QuestionModel>? questions;

  ChallengeModel({this.category,this.numOfQuestions,this.challengePoints,this.questions});

  ChallengeModel.fromJson(Map<String,dynamic> json){
    category = json["category"];
    numOfQuestions = json["num_of_questions"];
    challengePoints = json["challenge_points"];
    // if(json["questions"] != null){
    //   for(var i in json["questions"]){
    //    questions?.add(QuestionModel.fromJson(i));
    //   }
    // }
  }

}

class QuestionModel{
  String? quiz;
  String? opt1;
  String? opt2;
  String? opt3;
  String? opt4;
  String? ans;

  QuestionModel(
  {this.quiz, this.opt1, this.opt2, this.opt3, this.opt4, this.ans});

  QuestionModel.fromJson(Map<String,dynamic> json){
    quiz = json["quiz"];
    opt1 = json["opt1"];
    opt2 = json["opt2"];
    opt3 = json["opt3"];
    opt4 = json["opt4"];
    ans = json["ans"];
  }
}