import 'package:flutter/material.dart';
import 'package:gulf_car_auction/core/extensions/extensions.dart';

class AppColors {
  AppColors._();

  // Main
  static Color baseColor = HexColor.fromHex('#222455');
  static Color primaryColor = HexColor.fromHex('#B11E24');
  static Color primaryColorLight = HexColor.fromHex('#F8E5E6');
  static Color primaryColorSuperLight = primaryColorLight.withOpacity(0.5);
  static Color lightScaffoldBackgroundColor = Colors.white;
  static Color darkScaffoldBackgroundColor = HexColor.fromHex('#2F2E2E');
  static Color secondaryAppColor = HexColor.fromHex('#05445E');
  static Color secondaryDarkAppColor = HexColor.fromHex('#2F2E2E');
  static Color textFieldColor = Colors.grey.shade100;
  static Color borderColor = HexColor.fromHex('#C1C1C1');
  static Color unselectedColor = HexColor.fromHex('#E2E8F0');
  static Color fillColor = HexColor.fromHex('#414141');
  static Color shadowColor = Colors.grey.withOpacity(.8);

  // Solid
  static Color black = Colors.black;
  static Color red = HexColor.fromHex('#D81D21');
  static Color blue = Colors.blue;
  static Color white = Colors.white;
  static Color grey = Colors.grey;
  static Color mediumLightGrey = HexColor.fromHex('#E2E2E2');
  static Color lightGrey = HexColor.fromHex('#F6F6F6');

  // Font
  static Color baseFontColor = Colors.black;
  static Color lightFontColor = HexColor.fromHex('#383C40');
  static Color extraLightFontColor =  HexColor.fromHex('#A4A9AF');
  static Color redFontColor =  HexColor.fromHex('#b11e24');

  //   Divider
  static Color dividerColor = HexColor.fromHex('#F4F3F3');

  // Skeleton
  static Color skeletonColor1 = Colors.grey.shade200;
  static Color skeletonColor2 = Colors.grey.shade100;

  //   BID

  static  Color bidStartCLR = AppColors.primaryColor.withOpacity(0.2);
  static Color myBidCLR = Colors.green.withOpacity(0.2);
  static Color outbidCLR = Colors.yellow.withOpacity(0.2);
}