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

  static Future<bool> saveUserId(String id) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString('userId', id);
  }

  static Future<String?> getUserId() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString('userId');
  }

  static Future<bool> saveJwtToken(String jwt) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString('jwt', jwt);
  }

  static Future<String?> getJwtToken() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString('jwt');
  }
}
