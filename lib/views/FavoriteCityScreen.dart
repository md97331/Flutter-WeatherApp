import 'package:flutter/material.dart';
import '../services/SessionManager.dart';
import '../views/HomeScreen.dart'; // Replace with the path to your WeatherWidget

class FavoriteCitiesScreen extends StatefulWidget {
  final String username;

  const FavoriteCitiesScreen({required this.username});

  @override
  _FavoriteCitiesScreenState createState() => _FavoriteCitiesScreenState();
}

class _FavoriteCitiesScreenState extends State<FavoriteCitiesScreen> {
  final SessionManager _sessionManager = SessionManager();
  List<String> favoriteCities =
      []; // Will be filled with user's favorite cities or default to Chicago
  TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavoriteCities();
  }

  void _loadFavoriteCities() async {
    // Load the user's favorite cities from session manager or preferences
    var cities = await _sessionManager.getFavoriteCities(widget.username);

    setState(() {
      favoriteCities = cities;
    });
  }

  void _showWeatherForCity(String cityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(cityName: cityName),
      ),
    );
  }

  void _addCity() {
    if (_cityController.text.isNotEmpty) {
      setState(() {
        favoriteCities.add(_cityController.text);
      });
      _sessionManager.saveFavoriteCities(widget.username, favoriteCities);
      _cityController.clear();
    }
  }

  void _deleteCity(String city) {
    setState(() {
      favoriteCities.remove(city);
    });
    _sessionManager.saveFavoriteCities(widget.username, favoriteCities);
  }

  void _showWeather(String city) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(cityName: city),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Cities'),
      ),
      body: ListView.builder(
        itemCount: favoriteCities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteCities[index]),
            onTap: () => _showWeatherForCity(favoriteCities[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteCity(favoriteCities[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add City'),
                content: TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    hintText: 'Enter city name',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () {
                      _addCity();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
