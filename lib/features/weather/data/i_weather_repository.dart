import 'package:flutter_weather_ntua/core/enums/weather_api_uri.dart';

import '../domain/weather_model.dart';

abstract interface class IWeatherRepository {
  Future<Weather?> getWeather(
      {required String lat,
      required String long,
      required WeatherApiUri weatherApiUri});
}
