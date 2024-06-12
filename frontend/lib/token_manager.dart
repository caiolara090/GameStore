import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }
}
