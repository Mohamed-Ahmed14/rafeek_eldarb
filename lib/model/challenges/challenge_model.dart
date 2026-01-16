class ChallengeModel{
  String? id;
  String? category;
  int? challengePoints;
  int? numOfQuestions;
  int? order;
  List<QuestionModel>? questions;

  ChallengeModel({this.id,this.category,this.numOfQuestions,this.challengePoints,this.order,this.questions});

  ChallengeModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    category = json["category"];
    numOfQuestions = json["num_of_questions"];
    challengePoints = json["challenge_points"];
    order = json["order"];
    // if(json["questions"] != null){
    //   for(var i in json["questions"]){
    //    questions?.add(QuestionModel.fromJson(i));
    //   }
    // }
  }

}

class QuestionModel{
  String? id;
  String? quiz;
  String? opt1;
  String? opt2;
  String? opt3;
  String? opt4;
  String? ans;

  QuestionModel(
  {this.id,this.quiz, this.opt1, this.opt2, this.opt3, this.opt4, this.ans});

  QuestionModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    quiz = json["quiz"];
    opt1 = json["opt1"];
    opt2 = json["opt2"];
    opt3 = json["opt3"];
    opt4 = json["opt4"];
    ans = json["ans"];
  }
}