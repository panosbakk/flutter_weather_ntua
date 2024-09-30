import 'package:flutter/widgets.dart';
import 'package:flutter_weather_ntua/core/enums/temperature_unit.dart';
import 'package:flutter_weather_ntua/core/enums/weather_interpretation_codes.dart';
import 'package:flutter_weather_ntua/core/util/unit_converter.dart';
import 'package:flutter_weather_ntua/features/weather/domain/weather_model.dart';

enum WeatherFetchStatus { initial, loading, success, failure }

@immutable
final class WeatherState {
  final String? error;
  final Weather? weatherModel;
  final WeatherFetchStatus weatherFetchStatus;
  final String? cityName;

  const WeatherState(
      {this.error,
      this.weatherModel,
      this.cityName,
      required this.weatherFetchStatus});

  WeatherState copyWith({
    String? error,
    Weather? weatherModel,
    String? cityName,
    WeatherFetchStatus? weatherFetchStatus,
  }) {
    return WeatherState(
      error: error ?? this.error,
      weatherModel: weatherModel ?? this.weatherModel,
      cityName: cityName ?? this.cityName,
      weatherFetchStatus: weatherFetchStatus ?? this.weatherFetchStatus,
    );
  }

  int _getDayIndexByTimes(List<DateTime>? time) {
    if (time != null) {
      final now = DateTime.now();
      return time.indexWhere((element) =>
          element.day == now.day &&
          element.month == now.month &&
          element.year == now.year);
    }
    return -1;
  }

  WMOWeather getWMOCurrent() {
    final dailyData = weatherModel?.daily;
    if (dailyData?.time != null &&
        dailyData?.time?.isNotEmpty == true &&
        dailyData!.weatherCode != null) {
      final dayIndex = _getDayIndexByTimes(dailyData.time);

      if (dayIndex != -1 && dayIndex < dailyData.weatherCode!.length) {
        return WMOWeather.getWMOFromCode(dailyData.weatherCode![dayIndex]);
      }
    }
    return WMOWeather.unknown;
  }

  String getCurrentTemp({TemperatureUnit unit = TemperatureUnit.c}) {
    final tempUnitText = unit == TemperatureUnit.c ? "°C" : "°F";

    if (weatherModel?.daily?.temperature2MMin != null &&
        weatherModel?.daily?.temperature2MMax != null) {
      final dayIndex = _getDayIndexByTimes(weatherModel?.daily?.time);
      if (dayIndex == -1) return "";

      final temperature = unit == TemperatureUnit.c
          ? ((weatherModel!.daily!.temperature2MMin![dayIndex] +
                  weatherModel!.daily!.temperature2MMax![dayIndex]) /
              2)
          : UnitConverter.celsiusToFahrenheit(
              ((weatherModel!.daily!.temperature2MMin![dayIndex] +
                      weatherModel!.daily!.temperature2MMax![dayIndex]) /
                  2));
      return temperature.toStringAsFixed(0) + tempUnitText;
    }

    return "";
  }

  List<String> getHourlyTemp({TemperatureUnit unit = TemperatureUnit.c}) {
    final tempUnitText = unit == TemperatureUnit.c ? "°C" : "°F";
    final dayIndex = _getDayIndexByTimes(weatherModel?.hourly?.time);
    List<String> temp = [];

    for (var i = dayIndex;
        i < weatherModel!.hourly!.temperature2m!.length;
        i++) {
      final item = weatherModel!.hourly!.temperature2m![i];
      unit == TemperatureUnit.c
          ? temp.add(item.toStringAsFixed(0) + tempUnitText)
          : temp.add(
              UnitConverter.celsiusToFahrenheit(item).toStringAsFixed(0) +
                  tempUnitText);
    }

    return temp;
  }
}
