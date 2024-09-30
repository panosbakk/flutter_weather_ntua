import 'package:flutter/material.dart';
import 'package:flutter_weather_ntua/core/components/custom/weather_text.dart';
import 'package:flutter_weather_ntua/core/constants/color_constant.dart';

class WeatherRadioTile<T> extends StatelessWidget {
  const WeatherRadioTile(
      {super.key,
      required this.text,
      required this.value,
      required this.groupValue,
      this.unselectedColor = const Color(0xFFAEAAAE),
      this.onChanged});

  final String text;
  final T value;
  final T groupValue;
  final Color unselectedColor;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: WeatherText(
        text: text,
        size: 16,
        color: ColorConstant.textWhite,
      ),
      leading: Radio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        fillColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return ColorConstant.primaryColor;
            } else {
              return unselectedColor;
            }
          },
        ),
      ),
    );
  }
}
