import 'package:flutter/material.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AppSlider {
  AppSlider._();

  static Widget rangeSlider(
      {required RangeValues currentRangeValue,
      Color? color,
      double? min,
      double? max,
      int? divisions,
      ValueChanged<RangeValues>? onChanged}) {
    return RangeSlider(
      activeColor: AppColors.primaryColor,
      inactiveColor: AppColors.primaryColorSuperLight,
      values: currentRangeValue,
      max: max ?? 100,
      divisions: divisions?? 99,
      onChanged: onChanged,
    );
  }
}
