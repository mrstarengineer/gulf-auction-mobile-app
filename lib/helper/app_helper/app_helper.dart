import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/dashboard/controller/dashboard_controller.dart';
import 'package:gulf_car_auction/routes/app_pages/app_pages.dart';

void ePrintWrapped(String text) {
  if (kDebugMode) {
    final pattern = RegExp('.{1,800}');
    if (kDebugMode) {
      pattern.allMatches(text).forEach((match) {
        if (kDebugMode) {
          print(match.group(0));
        }
      });
    }
  }
}

void gotoHone() {
  Get.until((route) => Get.currentRoute == AppRoutes.dashboard);
  var dashboardController = Get.find<DashboardController>();
  if (dashboardController.selectedScreenIndex != 0) {
    Get.find<DashboardController>().updateSelectedScreenIndex(0);
  }
}
