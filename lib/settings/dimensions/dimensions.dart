import 'package:get/get.dart';

class Dimensions {
  Dimensions._();

  // Reference screen dimensions from Figma
  static const double referenceHeight = 812.0;
  static const double referenceWidth = 375.0;

  // Dynamic scaling functions based on screen size
  static double getHeight(double inputHeight) {
    double screenHeight = Get.height;
    return (inputHeight / referenceHeight) * screenHeight;
  }

  static double getWidth(double inputWidth) {
    double screenWidth = Get.width;
    return (inputWidth / referenceWidth) * screenWidth;
  }

  // Font size constants using reference height
  static double get mFontSize9 => getHeight(9);
  static double get mFontSize10 => getHeight(10);
  static double get mFontSize11 => getHeight(11);
  static double get mFontSize12 => getHeight(12);
  static double get mFontSize13 => getHeight(13);
  static double get mFontSize14 => getHeight(14);
  static double get mFontSize16 => getHeight(16);
  static double get mFontSize18 => getHeight(18);
  static double get mFontSize20 => getHeight(20);
  static double get mFontSize22 => getHeight(22);
  static double get mFontSize26 => getHeight(26);
  static double get mFontSize30 => getHeight(30);

  // Device Type
  static bool isMobile() {
    return Get.size.shortestSide < 600;
  }

  static bool isTablet() {
    return Get.size.shortestSide >= 600 ;
  }
}
