import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<bool> saveFavoriteCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('favorite_city', city);
  }

  Future<String?> getFavoriteCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('favorite_city');
  }

}

