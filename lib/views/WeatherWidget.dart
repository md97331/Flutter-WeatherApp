import 'package:flutter/material.dart';
import '../models/WeatherModel.dart'; // Import your WeatherModel

class WeatherWidget extends StatelessWidget {
  final WeatherModel weather;

  WeatherWidget({required this.weather});

  @override
  Widget build(BuildContext context) {
    // Assuming temperature is in Kelvin and needs to be converted to Celsius for display.
    double? temperatureCelsius =
        weather.main?.temp != null ? weather.main!.temp! - 273.15 : null;
    double? feelsLikeCelsius = weather.main?.feelsLike != null
        ? weather.main!.feelsLike! - 273.15
        : null;
    double? minTempCelsius =
        weather.main?.tempMin != null ? weather.main!.tempMin! - 273.15 : null;
    double? maxTempCelsius =
        weather.main?.tempMax != null ? weather.main!.tempMax! - 273.15 : null;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // First Row: Weather Information
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Center(
                child: Text(
                  weather.name ?? 'Unknown Location',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: WeatherInfoCard(
                    title: weather.weather?.first.main ?? 'Weather',
                    value: weather.weather?.first.description ?? 'Description',
                    iconData: _getWeatherIcon(weather.weather?.first.main),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),

            // Second Row: Temperature Information

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Temperature Info',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: WeatherInfoCard(
                    title: 'Temperature',
                    value:
                        '${temperatureCelsius?.toStringAsFixed(1) ?? 'N/A'}°C',
                    iconData: Icons.thermostat_rounded,
                  ),
                ),
                Expanded(
                  child: WeatherInfoCard(
                    title: 'Feels Like',
                    value:
                        '${feelsLikeCelsius?.toStringAsFixed(1) ?? 'N/A'}°C',
                    iconData: Icons.thermostat_outlined,
                  ),
                ),
                Expanded(
                  child: WeatherInfoCard(
                    title: 'Min',
                    value: '${minTempCelsius?.toStringAsFixed(1) ?? 'N/A'}°C',
                    iconData: Icons.arrow_downward,
                  ),
                ),
                Expanded(
                  child: WeatherInfoCard(
                    title: 'Max',
                    value: '${maxTempCelsius?.toStringAsFixed(1) ?? 'N/A'}°C',
                    iconData: Icons.arrow_upward,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),

            // Third Row: Wind and Cloud Information
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Wind and Cloud Info',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: WeatherInfoCard(
                    title: 'Wind Speed',
                    value:
                        '${weather.wind?.speed?.toStringAsFixed(1) ?? 'N/A'} m/s',
                    iconData: Icons.air,
                  ),
                ),
                Expanded(
                  child: WeatherInfoCard(
                    title: 'Cloudiness',
                    value: '${weather.clouds?.all ?? 'N/A'}%',
                    iconData: Icons.cloud_queue,
                  ),
                ),
                Expanded(
                  child: WeatherInfoCard(
                    title: 'Pressure',
                    value: '${weather.main?.pressure ?? 'N/A'} hPa',
                    iconData: Icons.compress,
                  ),
                ),
                Expanded(
                  child: WeatherInfoCard(
                    title: 'Humidity',
                    value: '${weather.main?.humidity ?? 'N/A'}%',
                    iconData: Icons.water_drop,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;

  const WeatherInfoCard({
    Key? key,
    required this.title,
    required this.value,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 48),
            SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.subtitle2),
            SizedBox(height: 10),
            Text(value, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}

IconData _getWeatherIcon(String? condition) {
  switch (condition) {
    case 'Thunderstorm':
      return Icons.flash_on; // Icon for thunderstorm
    case 'Drizzle':
      return Icons.grain; // Icon for drizzle
    case 'Rain':
      return Icons.invert_colors; // Icon for rain
    case 'Snow':
      return Icons.ac_unit; // Icon for snow
    case 'Mist':
    case 'Smoke':
    case 'Haze':
    case 'Dust':
    case 'Fog':
    case 'Sand':
    case 'Ash':
    case 'Squall':
      return Icons
          .blur_on; // Icon for atmospheric phenomena like mist/smoke/haze/etc.
    case 'Tornado':
      return Icons.filter_tilt_shift; // Icon for tornado
    case 'Clear':
      return Icons.wb_sunny; // Icon for clear sky
    case 'Clouds':
      return Icons.cloud; // Icon for clouds
    default:
      return Icons.error_outline; // Default icon for unknown conditions
  }
}
