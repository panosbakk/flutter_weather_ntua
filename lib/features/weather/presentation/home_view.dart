// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_weather_ntua/core/components/base/base_icon_button.dart';
import 'package:flutter_weather_ntua/core/components/base/empty_box.dart';
import 'package:flutter_weather_ntua/core/components/custom/weather_loading_indicator.dart';
import 'package:flutter_weather_ntua/core/components/custom/weather_text.dart';
import 'package:flutter_weather_ntua/core/constants/color_constant.dart';
import 'package:flutter_weather_ntua/core/enums/font_weights.dart';
import 'package:flutter_weather_ntua/core/enums/weather_interpretation_codes.dart';
import 'package:flutter_weather_ntua/core/util/date_formatter.dart';
import 'package:flutter_weather_ntua/core/util/size_helper.dart';
import 'package:flutter_weather_ntua/features/weather/presentation/widget/weather_card.dart';

import '../../../core/enums/localization_keys.dart';
import '../../settings/application/settings_view_model.dart';
import '../application/weather_state.dart';
import '../application/weather_viewmodel.dart';
import 'widget/selectable_city_bottom_sheet.dart';

part 'widget/current_weather.dart';
part 'widget/daily_weather.dart';
part 'widget/hourly_weather.dart';

class HomeView extends StatelessWidget {
  final WeatherViewModel weatherViewModel;

  const HomeView({super.key, required this.weatherViewModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! < 0) {
          _showBottomSheet(context, weatherViewModel);
        }
      },
      child: SingleChildScrollView(
        child: Consumer<WeatherViewModel>(
          builder: (context, weatherViewModel, _) {
            return Column(
              children: [
                _CurrentWeather(
                  weatherViewModel: weatherViewModel,
                ),
                _DailyWeather(
                  weatherViewModel: weatherViewModel,
                ),
                _HourlyWeather(weatherViewModel: weatherViewModel),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showBottomSheet(
      BuildContext context, WeatherViewModel weatherViewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectableCityBottomSheet();
      },
    ).then((_) {
      if (weatherViewModel.selectedChangableGeo != null) {
        Future.microtask(() {
          weatherViewModel.getDailyWeather(
              geoModel: weatherViewModel.selectedChangableGeo!);
        });
      }
    });
  }
}
