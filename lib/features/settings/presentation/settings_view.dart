import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_weather_ntua/core/components/base/empty_box.dart';
import 'package:flutter_weather_ntua/core/enums/app_languages.dart';
import 'package:flutter_weather_ntua/core/enums/localization_keys.dart';
import 'package:flutter_weather_ntua/core/enums/temperature_unit.dart';
import 'package:flutter_weather_ntua/features/settings/application/settings_view_model.dart';
import 'package:flutter_weather_ntua/features/settings/presentation/language_selector.dart';
import 'package:flutter_weather_ntua/features/settings/presentation/temp_unit_selector.dart';
import 'package:flutter_weather_ntua/core/constants/color_constant.dart';

import '../../../core/components/custom/weather_text.dart';
import '../../../core/enums/font_weights.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeatherText(
            text:
                LocalizationKeys.settingsSettings.localKey.tr(context: context),
            size: 24,
            weatherTextWeight: WeatherTextWeight.bold,
            color: ColorConstant.textWhite,
          ),
          const EmptyBox(height: 24),
          WeatherText(
            text: LocalizationKeys.settingsUnit.localKey.tr(context: context),
            size: 16,
            weatherTextWeight: WeatherTextWeight.regular,
            color: ColorConstant.textWhite,
          ),
          Selector<SettingsViewModel, TemperatureUnit>(
            selector: (p0, p1) => p1.temperatureUnit,
            builder: (context, tempUnit, _) {
              return TempUnitSelector(
                defaultUnit: tempUnit,
                onSelected: (unit) {
                  context.read<SettingsViewModel>().updateTemperatureUnit(unit);
                },
              );
            },
          ),
          const EmptyBox(height: 24),
          WeatherText(
            text:
                LocalizationKeys.settingsLanguage.localKey.tr(context: context),
            size: 16,
            weatherTextWeight: WeatherTextWeight.regular,
            color: ColorConstant.textWhite,
          ),
          Selector<SettingsViewModel, AppLanguages>(
            selector: (p0, p1) => p1.appLanguages,
            builder: (context, appLang, _) {
              return LanguageSelector(
                defaultLang: appLang,
                onSelected: (lang) {
                  context
                      .read<SettingsViewModel>()
                      .updateAppLanguage(languages: lang, context: context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
