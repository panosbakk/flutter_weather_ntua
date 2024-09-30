import 'package:flutter/material.dart';
import 'package:flutter_weather_ntua/core/util/size_helper.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard(
      {super.key,
      required this.child,
      this.cardColor = const Color(0xFFAEAAAE)});

  final Widget child;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      color: const Color(0xFFAEAAAE),
      child: SizedBox(
        width: SizeHelper.blockSizeHorizontal * 30,
        child: child,
      ),
    );
  }
}
