import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';

extension BuildContextExtension on BuildContext {

  get showLoaderOverlay => loaderOverlay.show(widgetBuilder: (progress) => _overlayLoader());

  get hideLoaderOverlay => loaderOverlay.hide();


  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  Size get screenSize => MediaQuery.of(this).size;

  double get screenRatio => MediaQuery.of(this).size.aspectRatio;

  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;


}

Widget _overlayLoader (){
  return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.5,
          sigmaY: 4.5,
        ),
        child: Center(
          child: Container(
            width: Dimensions.getWidth(60),
            height:  Dimensions.getWidth(60),
            padding: EdgeInsets.all(Dimensions.getWidth(10)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular( Dimensions.getWidth(8)),
            ),
            child: AppLoaders.dancingSquare(),
          ),
        ),
      ));
}


extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  /// Ex: #541d1f.
  static Color fromHex(String hexString) => Color(int.parse(hexString.replaceAll('#', '0xFF')));


}