import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/views/WeatherWidget.dart';
import 'package:mp5/models/WeatherModel.dart';

void main() {
  group('WeatherWidget Tests', () {
    testWidgets('WeatherWidget displays correct data', (WidgetTester tester) async {
      final weatherModel = createDummyWeatherModel("Clear");

      await tester.pumpWidget(
        MaterialApp(
          home: WeatherWidget(weather: weatherModel),
        ),
      );

      expect(find.text('London'), findsOneWidget);
      expect(find.text('16.1°C'), findsOneWidget); 
    });

  });
}

WeatherModel createDummyWeatherModel(String condition) {
  return WeatherModel(
    coord: Coord(lon: -0.1257, lat: 51.5085),
    weather: [Weather(id: 800, main: condition, description: "$condition sky", icon: "01d")],
    base: "stations",
    main: Main(temp: 289.92, feelsLike: 289.26, tempMin: 288.71, tempMax: 291.48, pressure: 1016, humidity: 77),
    visibility: 10000,
    wind: Wind(speed: 3.09, deg: 240),
    clouds: Clouds(all: 0),
    dt: 1605182400,
    sys: Sys(type: 1, id: 1414, country: "GB", sunrise: 1605167473, sunset: 1605200851),
    timezone: 0,
    id: 2643743,
    name: "London",
    cod: 200
  );
}
