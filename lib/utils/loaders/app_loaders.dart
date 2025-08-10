import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

abstract class AppLoaders {


  static Widget spinningLines ({Key? key, double? size, Color? color}){
    return SpinKitThreeBounce(
      key: key,
      color:  color ?? AppColors.primaryColor,
      size: size ?? Dimensions.getWidth(25),
    );
  }

  static Widget pulse ({Key? key, double? size, Color? color}){
    return SpinKitPulse(
      key: key,
      color:  color ?? AppColors.primaryColor,
      size: size ?? Dimensions.getHeight(25),
    );
  }

  static Widget wave ({Key? key, double? size, Color? color}){
    return SpinKitWave(
      key: key,
      color:  color ?? AppColors.primaryColor,
      size: size ?? Dimensions.getHeight(25),
    );
  }

  static Widget dancingSquare ({Key? key, double? size, Color? color}) {
    return SpinKitDancingSquare(
      key: key,
      color: color ?? AppColors.primaryColor,
      size: size ?? Dimensions.getHeight(25),
    );
  }

  static Widget foldingCube ({Key? key, double? size, Color? color}) {
    return SpinKitFoldingCube(
      key: key,
      color: color ?? AppColors.primaryColor,
      size: size ?? Dimensions.getHeight(25),
    );
  }

  static Widget loaderWithText ({String? text, Widget? loaderWidget}){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loaderWidget ?? AppLoaders.foldingCube(),
          SizedBox(height: Dimensions.getWidth(14),),
          AppTexts.smallText(
              text: text ?? 'Loading...',
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}