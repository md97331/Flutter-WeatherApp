import 'package:flutter/material.dart';
import '../models/WeatherModel.dart';
import '../services/APIservices.dart';
import '../views/WeatherWidget.dart'; // Import the WeatherWidget

class HomeScreen extends StatefulWidget {
  final String cityName;

  HomeScreen({Key? key, required this.cityName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel? _weatherData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    setState(() {
      _isLoading = true;
    });
    final weatherAPIService = WeatherAPIService(apiKey: '684dbc202a0e4bc0e3a553c59209dc3a');
    try {
      final data = await weatherAPIService.fetchWeatherByCityName(widget.cityName);
      setState(() {
        _weatherData = WeatherModel.fromJson(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load weather data: ${e.toString()}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadWeatherData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _weatherData != null
              ? WeatherWidget(weather: _weatherData!) // Use the WeatherWidget
              : const Center(child: Text('No weather data available.')),
    );
  }
}
