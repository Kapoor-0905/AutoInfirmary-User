import 'package:shared_preferences/shared_preferences.dart';

class SF {
  static Future<bool> saveSessionToken(String session) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString('session', session);
  }

  static Future<String?> getSessionToken() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString('session');
  }
}
