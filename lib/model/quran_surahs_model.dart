class SurahsModel{
  String? arabicName;
  String? arabicNameLong;
  String? revelationPlace;
  int? totalAyah;

  SurahsModel({this.arabicName,this.arabicNameLong,this.revelationPlace,this.totalAyah});

  SurahsModel.fromJson(Map<String,dynamic> json){
    arabicName = json["surahNameArabic"];
    arabicNameLong = json["surahNameArabicLong"];
    revelationPlace = json["revelationPlace"];
    totalAyah = json["totalAyah"];
  }

}