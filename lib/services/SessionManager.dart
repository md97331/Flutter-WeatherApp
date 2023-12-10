import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _usernameKey = 'username';
  static const String _usersKey = 'users'; // Key to store users list
  static const String _favoriteCitiesKey = 'favoriteCities';

  Future<void> login(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var users = getUsersList(prefs);
    if (users.contains(username)) {
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_usernameKey, username);
      // Set Chicago as default favorite city upon login if not set
      String favoriteCity = await getFavoriteCity(username);
      if (favoriteCity.isEmpty) {
        await setFavoriteCity(username, 'Chicago');
      }
    }
  }

  Future<void> setFavoriteCities(String username, List<String> cities) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('${username}_$_favoriteCitiesKey', cities);
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_usernameKey);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  Future<void> createUser(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var users = getUsersList(prefs);
    if (!users.contains(username)) {
      users.add(username);
      await prefs.setStringList(_usersKey, users);
    }
  }

  Future<void> deleteUser(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var users = getUsersList(prefs);
    if (users.contains(username)) {
      users.remove(username);
      await prefs.setStringList(_usersKey, users);
      if (await getUsername() == username) {
        await logout(); // Logout if the deleted user was logged in
      }
    }
  }

  Future<List<String>> getAllUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return getUsersList(prefs);
  }

  List<String> getUsersList(SharedPreferences prefs) {
    return prefs.getStringList(_usersKey) ?? [];
  }

  Future<void> setFavoriteCity(String username, String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('${username}_favoriteCity', city);
  }

  Future<String> getFavoriteCity(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('${username}_favoriteCity') ?? 'Chicago';
  }

  Future<void> addFavoriteCity(String username, String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cities = await getFavoriteCities(username);
    if (!cities.contains(city)) {
      cities.add(city);
      await prefs.setStringList('${username}_favoriteCities', cities);
    }
  }

  Future<void> removeFavoriteCity(String username, String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cities = await getFavoriteCities(username);
    cities.remove(city);
    await prefs.setStringList('${username}_favoriteCities', cities);
  }

  // Method to save favorite cities for a user
  Future<bool> saveFavoriteCities(String username, List<String> cities) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('favorite_cities_$username', cities);
  }

  // Method to get favorite cities for a user
  Future<List<String>> getFavoriteCities(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorite_cities_$username') ?? [];
  }

  // Method to delete favorite cities for a user (optional)
  Future<bool> deleteFavoriteCities(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('favorite_cities_$username');
  }
}
