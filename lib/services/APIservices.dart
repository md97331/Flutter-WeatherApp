// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherAPIService {
  final String apiKey;

  WeatherAPIService({required this.apiKey});

  Future<Map<String, dynamic>> fetchWeatherByCityName(String cityName) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

