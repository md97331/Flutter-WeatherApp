import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/WeatherModel.dart';
import 'package:mp5/views/WeatherWidget.dart';

void main() {
   testWidgets('WeatherWidget should display weather description correctly', (WidgetTester tester) async {
    final weather = WeatherModel(
      weather: [
        Weather(
          main: 'Clouds', 
          description: 'Partly cloudy', // Weather description
          icon: '04d', 
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WeatherWidget(weather: weather),
        ),
      ),
    );

    expect(find.text('Partly cloudy'), findsOneWidget);
  });

  testWidgets('WeatherInfoCard should display information correctly', (WidgetTester tester) async {
    const weatherInfoCard = WeatherInfoCard(
      title: 'Temperature',
      value: '20.0 °C',
      iconData: Icons.thermostat_rounded,
    );

    // Build the WeatherInfoCard
    await tester.pumpWidget(const MaterialApp(home: weatherInfoCard));

    expect(find.text('Temperature'), findsOneWidget); // Title
    expect(find.text('20.0 °C'), findsOneWidget); // Value
    expect(find.byIcon(Icons.thermostat_rounded), findsOneWidget); // Icon
  });
}
