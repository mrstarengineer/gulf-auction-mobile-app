import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AppAlertMessages {
  AppAlertMessages._();

  static Widget loginAlert() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.getWidth(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconWidgets.svgAssetIcon(
                iconPath: AppSvgIcons.loginAlert, size: Get.width * 0.6),
            SizedBox(height: Dimensions.getHeight(24),),
            AppTexts.mediumText(
                text: 'Please log in to view this content.',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center),
            
            SizedBox(height: Dimensions.getHeight(24),),
            // AppButtons.textBtnWithStrokeOnly(
            //     onTap: () => Get.toNamed(AppRoutes.SIGN_IN, parameters: {'isFromGuestUser' : 'true'}),
            //     text: 'Login Now', width: Get.width * 0.5)
          ],
        ),
      ),
    );
  }

  static Widget emptyAlert() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.getWidth(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconWidgets.svgAssetIcon(
                iconPath: AppSvgIcons.loginAlert, size: Get.width * 0.5),
            SizedBox(height: Dimensions.getHeight(24),),
            AppTexts.mediumText(
                text: 'Oops! No results found.',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  static Widget errorAlert() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.getWidth(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconWidgets.svgAssetIcon(
                iconPath: AppSvgIcons.errorAlert, size: Get.width * 0.5),
            SizedBox(height: Dimensions.getHeight(24),),
            AppTexts.mediumText(
                text: 'Oops! Unknown Error, Try again after sometime.',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
