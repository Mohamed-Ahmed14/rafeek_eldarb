import '../data/local/shared_helper.dart';
import '../data/local/shared_keys.dart';

class Defaults{

 static Future<void> appDefaultInitialization() async{
    if(await SharedHelper.get(key:SharedKeys.isFirstTime) == null){
    await SharedHelper.set(key: SharedKeys.singleMode, value: true);
    await SharedHelper.set(key: SharedKeys.sliderValue, value: 60.0);
    await SharedHelper.set(key: SharedKeys.savedPage, value: 1);
    await SharedHelper.set(key: SharedKeys.audioNumber, value: 1);
    await SharedHelper.set(key: SharedKeys.isFirstTime, value: false);
    }

  }

}