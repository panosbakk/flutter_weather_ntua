import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_weather_ntua/core/components/custom/weather_text.dart';
import 'package:flutter_weather_ntua/core/constants/color_constant.dart';
import 'package:flutter_weather_ntua/core/util/size_helper.dart';
import 'package:flutter_weather_ntua/features/weather/application/weather_viewmodel.dart';

import '../../../../core/util/location_helper.dart';

class SelectableCityBottomSheet extends StatelessWidget {
  const SelectableCityBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = context.watch<WeatherViewModel>();

    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
            color: const Color(0xFFAEAAAE),
            child: ListView.separated(
              padding: EdgeInsets.only(
                  top: SizeHelper.highPadding,
                  left: SizeHelper.mediumPadding,
                  right: SizeHelper.mediumPadding),
              itemCount: weatherViewModel.selectableCitiesGeo.length,
              separatorBuilder: (context, index) => const Divider(
                color: ColorConstant.scaffoldBackgroundColor,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final e = weatherViewModel.selectableCitiesGeo[index];
                final isSelected = weatherViewModel.selectedChangableGeo ==
                    weatherViewModel.selectableCitiesGeo
                        .firstWhere((element) => element == e);

                return FutureBuilder<String?>(
                    future:
                        LocationHelper.cityNameFromCoordinates(e.lat, e.long),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator.adaptive();
                      }

                      return GestureDetector(
                        onTap: () {
                          weatherViewModel.updateSelectedChangableGeo(
                              weatherViewModel.selectableCitiesGeo
                                  .indexWhere((element) => element == e));
                        },
                        child: AnimatedContainer(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeHelper.defaultPadding),
                          duration: const Duration(milliseconds: 300),
                          height: SizeHelper.blockSizeVertical * 9,
                          width: double.maxFinite,
                          color: isSelected
                              ? ColorConstant.primaryColor
                              : Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeHelper.mediumPadding),
                            child: Column(
                              children: [
                                WeatherText(
                                  text: snapshot.requireData ?? "-",
                                  size: 18,
                                  color: isSelected
                                      ? ColorConstant.textWhite
                                      : ColorConstant.textBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            )));
  }
}
