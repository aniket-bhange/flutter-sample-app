import 'package:shared_preferences/shared_preferences.dart';

class Utils{
  storeValue(key, value, { dynamic options }) async{
    var prefs = (await SharedPreferences.getInstance());
    prefs.setString(key, value);
  }
}