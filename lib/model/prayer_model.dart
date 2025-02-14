class Prayer{

  PrayerTimes? prayerTimes;
  Date? date;
  Prayer({this.prayerTimes,this.date});
  Prayer.fromJson(Map<String,dynamic> json){
    prayerTimes = PrayerTimes.fromJson(json["prayer_times"]);
    date = Date.fromJson(json["date"]);
  }
}

class PrayerTimes{
  String? fajr;
  String? sunrise;
  String? duhr;
  String? asr;
  String? maghrib;
  String? isha;

  PrayerTimes({this.fajr,this.duhr,this.sunrise,this.asr,this.maghrib,this.isha});

  PrayerTimes.fromJson(Map<String,dynamic> json){
   fajr = json["Fajr"];
   sunrise = json["Sunrise"];
   duhr = json["Dhuhr"];
   asr = json["Asr"];
   maghrib = json["Maghrib"];
   isha = json["Isha"];
  }
}

class Date{
    String? dateEn;
    DateHijri? dateHijri;
    Date({this.dateEn,this.dateHijri});
    Date.fromJson(Map<String,dynamic> json){

      dateEn = json["date_en"];
      dateHijri = DateHijri.fromJson(json["date_hijri"]);
    }

}

class DateHijri{
  String? day;
  String? month;
  String? year;
  String? weekDay;

  DateHijri({this.day,this.month,this.year,this.weekDay});
  DateHijri.fromJson(Map<String,dynamic> json){
    day = json["day"];
    weekDay = json["weekday"]["ar"];
    month = json["month"]["ar"];
    year = json["year"];
  }
}