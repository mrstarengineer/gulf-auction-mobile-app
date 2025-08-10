import 'package:flutter/material.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AppShadow {
  AppShadow._();

  static List<BoxShadow> cardShadow = [
    BoxShadow(
        offset: const Offset(0, 0),
        blurRadius: 1,
        spreadRadius: 0,
        color: AppColors.shadowColor),
  ];

}