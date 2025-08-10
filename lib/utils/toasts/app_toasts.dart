import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AppToasts {
  AppToasts._();

  static void longToast (message, {ToastGravity? gravity}){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: AppColors.baseColor,
      textColor: Colors.white,
      fontSize: Dimensions.mFontSize12,
    );
  }

  static void shortToast (message, {ToastGravity? gravity}){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: AppColors.baseColor,
      textColor: Colors.white,
      fontSize: Dimensions.mFontSize12,
    );
  }
}