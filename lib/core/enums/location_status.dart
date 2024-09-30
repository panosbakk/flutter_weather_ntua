import 'package:flutter/widgets.dart';
import 'package:flutter_weather_ntua/core/util/geo_model.dart';

enum LocationStatus {
  initial,
  serviceUnavailable,
  approve,
  denied;
}

@immutable
class LocationInfo {
  final LocationStatus locationStatus;
  final GeoModel? geoModel;
  const LocationInfo({required this.locationStatus, this.geoModel});
}
