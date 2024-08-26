import 'package:shared_preferences/shared_preferences.dart';

class DarkTheme {
  setDarkTheme(bool value)
  async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
  preferences.setBool('DarkTheme', value);
  }
Future<bool> getTheme()
async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool('DarkTheme') ?? false;
}
}