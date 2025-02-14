import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{

  static SharedPreferences? _prefs;

  static Future<void> init() async{

    _prefs = await SharedPreferences.getInstance();
  }

  //write data
  static Future<void> set({required String key,required dynamic value})async{
    if(value is int){
      await _prefs?.setInt(key, value);
    }else if(value is double){
      await _prefs?.setDouble(key, value);
    }else if(value is bool){
      await _prefs?.setBool(key, value);
    }else if(value is String){
      await _prefs?.setString(key, value);
    }else if(value is List<String>){
      await _prefs?.setStringList(key, value);
    }
  }

  //read data
  static  get({required String key}){
    return _prefs?.get(key);
  }

//remove data
  static remove({required String key}) async{
    await _prefs?.remove(key);
  }

//clear data
  static clear() async{
    await _prefs?.clear();
  }

}