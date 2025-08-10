import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../helper/helper.dart';
import '../../global.dart';

class AppBars {
  AppBars._();

  static PreferredSizeWidget appBar(
      {VoidCallback? onTapBack, required String title, bool isHome = true}) {
    return AppBar(
      actions: [
        if (isHome)
          AppButtons.circleButtonStrokeOnly(
            onTap: () {
              gotoHone();
            },
            icon: Icons.home,
            color: AppColors.white,
            strokeColor: AppColors.white,
            iconSize: Dimensions.getHeight(18),
          ),
        SizedBox(
          width: Dimensions.getWidth(8),
        ),
      ],
      backgroundColor: AppColors.primaryColor,
      leadingWidth: Dimensions.getHeight(65),
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
        child: AppButtons.circleButtonStrokeOnly(
          onTap: onTapBack ?? () => Get.back(),
          svgIconPath: AppSvgIcons.arrowLeft,
          color: AppColors.white,
          strokeColor: AppColors.white,
          iconSize: Dimensions.getHeight(18),
        ),
      ),
      title: AppTexts.smallText(text: title, color: AppColors.white),
      centerTitle: true,
    );
  }

  static PreferredSizeWidget appBarWithAction({
    VoidCallback? onTapBack,
    required String title,
    required Widget action,
    bool isHome = true,
    bool isConfirmationRequired = false,
  }) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leadingWidth: Dimensions.getHeight(65),
      actions: [
        if (isHome)
          AppButtons.circleButtonStrokeOnly(
            onTap: () {
              if (isConfirmationRequired) {
                AppDialogs.closingConfirmation(Get.context!,
                    title: 'Leave Auction?', onTapBtn2: () {
                  gotoHone();
                });
              } else {
                gotoHone();
              }
            },
            icon: Icons.home,
            color: AppColors.white,
            strokeColor: AppColors.white,
            iconSize: Dimensions.getHeight(18),
          ),
        action,
      ],
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
        child: AppButtons.circleButtonStrokeOnly(
          onTap: onTapBack ?? () => Get.back(),
          svgIconPath: AppSvgIcons.arrowLeft,
          color: AppColors.white,
          strokeColor: AppColors.white,
          iconSize: Dimensions.getHeight(18),
        ),
      ),
      title: AppTexts.smallText(text: title, color: AppColors.white),
      centerTitle: true,
    );
  }

  static PreferredSizeWidget appBarSignUp(
      {required String title, VoidCallback? onTapBack, bool isHome = true}) {
    return AppBar(
      actions: [
        if (isHome)
          AppButtons.circleButtonStrokeOnly(
            onTap: () {
              gotoHone();
            },
            icon: Icons.home,
            color: AppColors.black,
            strokeColor: AppColors.black,
            iconSize: Dimensions.getHeight(18),
          ),
        SizedBox(
          width: Dimensions.getWidth(8),
        ),
      ],
      leadingWidth: Dimensions.getWidth(44),
      leading: Padding(
        padding: EdgeInsets.only(left: Dimensions.getWidth(16)),
        child: AppButtons.circleButtonStrokeOnly(
            svgIconPath: AppSvgIcons.arrowLeft,
            onTap: onTapBack ?? () => Get.back()),
      ),
      centerTitle: true,
      title: AppTexts.mediumText(text: title, color: AppColors.lightFontColor),
    );
  }
}
