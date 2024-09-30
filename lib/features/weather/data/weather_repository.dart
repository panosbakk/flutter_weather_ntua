import 'dart:developer';

import 'package:flutter_weather_ntua/core/api/i_api_client.dart';
import 'package:flutter_weather_ntua/core/enums/weather_api_uri.dart';
import 'package:flutter_weather_ntua/features/weather/data/i_weather_repository.dart';
import 'package:flutter_weather_ntua/features/weather/domain/weather_model.dart';

class WeatherRepository implements IWeatherRepository {
  final IApiClient apiClient;

  WeatherRepository({required this.apiClient});
  @override
  Future<Weather?> getWeather(
      {required String lat,
      required String long,
      required WeatherApiUri weatherApiUri}) async {
    try {
      final response = await apiClient.fetch<Map<String, dynamic>>(
          apiUri: weatherApiUri.toUri(lat, long));
      if (response != null) {
        return Weather.fromJson(response);
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
