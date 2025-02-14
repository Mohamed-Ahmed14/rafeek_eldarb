abstract class PrayerState{}
class PrayerInitState extends PrayerState{}

class GetPrayerTimesLoadingState extends PrayerState{}
class GetPrayerTimesSuccessState extends PrayerState{}
class GetPrayerTimesErrorState extends PrayerState{}

class InternetConnectionState extends PrayerState{}