class SurahModel{
  String? surahName;
  String? surahNameArabicLong;
  int? totalAyah;
  int? surahNo;
  ReciterAudio? reciterAudio;
  List<String>? arabic1 = [];

  SurahModel({this.surahName,this.surahNameArabicLong,
    this.totalAyah,this.surahNo,this.reciterAudio,this.arabic1});

  SurahModel.fromJson(Map<String,dynamic> json){
    surahName = json["surahNameArabic"];
    surahNameArabicLong = json["surahNameArabicLong"];
    surahNo = json["surahNo"];
    totalAyah = json["totalAyah"];
   ReciterAudio.fromJson(json["audio"]);
   if(json["arabic1"] != null){
     for(var i in json["arabic1"]){
       arabic1?.add(i);
     }
   }
  }


}

class ReciterAudio{
  ReciterAudio.fromJson(Map<String,dynamic> json){
      ReciterData1.fromJson(json["1"]);
      ReciterData2.fromJson(json["2"]);
      ReciterData3.fromJson(json["3"]);
  }
}
class ReciterData1 {
  String? name;
  String? url;
  String? originalUrl;

  ReciterData1({this.name, this.url, this.originalUrl});

  ReciterData1.fromJson(Map<String, dynamic> json){
    name = json["reciter"];
    url = json["url"];
    originalUrl = json["originalUrl"];
  }
}
  class ReciterData2 {
    String? name;
    String? url;
    String? originalUrl;

    ReciterData2({this.name, this.url, this.originalUrl});

    ReciterData2.fromJson(Map<String, dynamic> json){
      name = json["reciter"];
      url = json["url"];
      originalUrl = json["originalUrl"];
    }
  }
  class ReciterData3{
  String? name;
  String? url;
  String? originalUrl;

  ReciterData3({this.name,this.url,this.originalUrl});
  ReciterData3.fromJson(Map<String,dynamic> json){
  name = json["reciter"];
  url = json["url"];
  originalUrl = json["originalUrl"];

  }
}