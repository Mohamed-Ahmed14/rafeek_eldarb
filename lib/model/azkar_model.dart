class AzkarModel{
  String? content;
  String? description;
  String? category;
  String? count;
  bool? isBookmarked;
  int? id;

  AzkarModel({this.content, this.description, this.category, this.count,
  this.isBookmarked,this.id});

  AzkarModel.fromJson(Map<String,dynamic> json){
    content = json["content"];
    description = json["description"];
    category = json["category"];
    count = json["count"];
    isBookmarked = true;
  }
}