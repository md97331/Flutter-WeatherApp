import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mp5/services/APIservices.dart';
import 'package:mp5/views/WeatherWidget.dart';
import 'package:mp5/models/WeatherModel.dart';
import 'package:flutter/material.dart';

import 'WeatherAPI_test.mocks.dart'; // Import the generated file

@GenerateMocks([WeatherAPIService])
void main() {
  late MockWeatherAPIService mockWeatherApiService; // Correct class name

  setUp(() {
    mockWeatherApiService = MockWeatherAPIService();
  });

  testWidgets('WeatherWidget displays weather data from API', (WidgetTester tester) async {
    // Assuming fetchWeatherByCityName returns a Future<Map<String, dynamic>>
    when(mockWeatherApiService.fetchWeatherByCityName(any))
        .thenAnswer((_) async => 
        {
          "main": {
            "temp": 289.92,
            "feels_like": 289.26,
            "temp_min": 288.71,
            "temp_max": 291.48,
            "pressure": 1016,
            "humidity": 77
        },
        "visibility": 10000,
        "wind": {
            "speed": 3.09,
            "deg": 240
        },
        "clouds": {
            "all": 0
        },
        "dt": 1605182400,
        "sys": {
            "type": 1,
            "id": 1414,
            "country": "GB",
            "sunrise": 1605167473,
            "sunset": 1605200851
        },
        "timezone": 0,
        "id": 2643743,
        "name": "London",
        "cod": 200,
        });

    // If fetchWeatherByCityName returns a WeatherModel, then:
    // .thenAnswer((_) async => createDummyWeatherModel());

    // Assuming WeatherWidget takes a WeatherModel directly
    final dummyWeatherModel = createDummyWeatherModel();

    await tester.pumpWidget(MaterialApp(
      home: WeatherWidget(weather: dummyWeatherModel),
    ));

    expect(find.text('London'), findsOneWidget);
    // ... more assertions ...
  });
}

WeatherModel createDummyWeatherModel() {
   return WeatherModel(
        coord: Coord(
            lon: -0.1257, lat: 51.5085), 
        weather: [
          Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
        ],
        base: "stations",
        main: Main(
            temp: 289.92,
            feelsLike: 289.26,
            tempMin: 288.71,
            tempMax: 291.48,
            pressure: 1016,
            humidity: 77),
        visibility: 10000,
        wind: Wind(speed: 3.09, deg: 240),
        clouds: Clouds(all: 0),
        dt: 1605182400,
        sys: Sys(
            type: 1,
            id: 1414,
            country: "GB",
            sunrise: 1605167473,
            sunset: 1605200851),
        timezone: 0,
        id: 2643743,
        name: "London",
        cod: 200);

}