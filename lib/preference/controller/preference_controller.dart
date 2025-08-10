import 'package:shared_preferences/shared_preferences.dart';

class PreferenceController {
  final SharedPreferences _sharedPreferences;

  PreferenceController ({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  // String
  Future setString (String key, {required String value}) async{
    return await _sharedPreferences.setString(key, value);
  }

  String getString (String key){
    return  _sharedPreferences.getString(key)??'';
  }

  // Bool
  Future setBool (String key, {required bool value}) async{
    return await _sharedPreferences.setBool(key, value);
  }

  bool? getBool (String key){
    return _sharedPreferences.getBool(key);
  }

  // Int
  Future setInt (String key, {required int value}) async{
    return await _sharedPreferences.setInt(key, value);
  }

  int? getInt (String key){
    return _sharedPreferences.getInt(key) ?? 0;
  }

  // Contains Key
  bool containsKey (String key){
    return _sharedPreferences.containsKey(key);
  }

  // Contains Key
   Future<bool> clearData () async{
    return await _sharedPreferences.clear();
  }

}