import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/WeatherModel.dart';

void main() {
  test('WeatherModel.fromJson should parse JSON correctly', () {
    final json = {
      'coord': {'lon': 10.0, 'lat': 20.0},
      'weather': [{'id': 801, 'main': 'Clouds', 'description': 'Few clouds'}],
      'base': 'stations',
      'main': {
        'temp': 20.0,
        'feels_like': 18.0,
        'temp_min': 18.0,
        'temp_max': 22.0,
        'pressure': 1010,
        'humidity': 50,
      },
      'visibility': 10000,
      'wind': {'speed': 5.0, 'deg': 180},
      'clouds': {'all': 20},
      'dt': 1677312000,
      'sys': {'type': 1, 'id': 123, 'country': 'US', 'sunrise': 1677276000, 'sunset': 1677316000},
      'timezone': -18000,
      'id': 123456,
      'name': 'Test City',
      'cod': 200,
    };

    final weatherModel = WeatherModel.fromJson(json);

    expect(weatherModel.coord?.lon, 10.0);
    expect(weatherModel.weather?.first.main, 'Clouds');
    expect(weatherModel.base, 'stations');
    expect(weatherModel.main?.temp, 20.0);
    expect(weatherModel.wind?.speed, 5.0);
    expect(weatherModel.sys?.country, 'US');
    expect(weatherModel.timezone, -18000);
  });

  test('Coord.fromJson should parse JSON correctly', () {
    final json = {'lon': 10.0, 'lat': 20.0};

    final coord = Coord.fromJson(json);

    expect(coord.lon, 10.0);
    expect(coord.lat, 20.0);
  });

  test('Weather.fromJson should parse JSON correctly', () {
    final json = {'id': 801, 'main': 'Clouds', 'description': 'Few clouds', 'icon': '02d'};

    final weather = Weather.fromJson(json);

    expect(weather.id, 801);
    expect(weather.main, 'Clouds');
    expect(weather.description, 'Few clouds');
    expect(weather.icon, '02d');
  });

  test('Main.fromJson should parse JSON correctly', () {
    final json = {
      'temp': 20.0,
      'feels_like': 18.0,
      'temp_min': 18.0,
      'temp_max': 22.0,
      'pressure': 1010,
      'humidity': 50,
    };

    final main = Main.fromJson(json);

    expect(main.temp, 20.0);
    expect(main.feelsLike, 18.0);
    expect(main.tempMin, 18.0);
    expect(main.tempMax, 22.0);
    expect(main.pressure, 1010);
    expect(main.humidity, 50);
  });

  test('Wind.fromJson should parse JSON correctly', () {
    final json = {'speed': 5.0, 'deg': 180, 'gust': 7.0};

    final wind = Wind.fromJson(json);

    expect(wind.speed, 5.0);
    expect(wind.deg, 180);
    expect(wind.gust, 7.0);
  });

  test('Clouds.fromJson should parse JSON correctly', () {
    final json = {'all': 20};

    final clouds = Clouds.fromJson(json);

    expect(clouds.all, 20);
  });

  test('Sys.fromJson should parse JSON correctly', () {
    final json = {
      'type': 1,
      'id': 123,
      'country': 'US',
      'sunrise': 1677276000,
      'sunset': 1677316000,
    };

    final sys = Sys.fromJson(json);

    expect(sys.type, 1);
    expect(sys.id, 123);
    expect(sys.country, 'US');
    expect(sys.sunrise, 1677276000);
    expect(sys.sunset, 1677316000);
  });
}

