import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/profile/controller/profile_controller.dart';

import '../../../global/global_widgets/buttons/app_buttons.dart';
import '../../../global/global_widgets/texts/app_texts.dart';
import '../../../settings/colors/app_colors.dart';
import '../../../settings/dimensions/dimensions.dart';
import '../../../utils/bottom_sheets/app_bottom_sheets.dart';

Widget tabBarBodyAccountControlWidget({
  VoidCallback? onTapDeleteAccount,
}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: GestureDetector(
      onTap: () {
        Get.find<ProfileController>().deleteConfirmed = false;
        AppBottomSheets.showAccountControlBottomSheet(
          title: 'Deleting your Gulf account',
          subTitle:
          'If you want to take a break from Gulf you can logout. If you want to permanently delete your account then let us know.',
          isDismissible: true,
          body: GetBuilder<ProfileController>(builder: (pController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.getHeight(16)),
                GestureDetector(
                  onTap: () {
                    pController.isDeleteConfirmed =
                    !pController.isDeleteConfirmed;
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTexts.mediumText(text: 'Delete account'),
                      ),
                      // Radio button to confirm deletion
                      Radio<bool>(
                        value: true,
                        groupValue: pController.isDeleteConfirmed,
                        onChanged: (bool? newValue) {
                          pController.isDeleteConfirmed =
                              newValue??false;
                        },
                        activeColor:
                        AppColors.primaryColor, // Your primary color
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.getHeight(8)),
                AppTexts.smallText(
                  text:
                  'Delete your account is permanent.\nWhen you delete your account, your main profile and everything you\'ve added will permanently delete. You won\'t be able to retrieve anything you have added, bought. All additional documents and files also be deleted.',
                  color: AppColors.extraLightFontColor,
                ),
                SizedBox(height: Dimensions.getHeight(24)),
                // "Confirm Deletion" button, enabled/disabled based on _isDeleteConfirmed
                AppButtons.btnWithBg(
                  onTap: pController.isDeleteConfirmed
                      ? () {
                    Get.back(); // Close the current bottom sheet
                    AppBottomSheets.showAccountConfirmationBottomSheet(
                      title: 'Are you sure?',
                      description:
                      'Are you sure you want to permanently delete your account? This action cannot be undone.',
                      onConfirm: () {
                        Get.back(); // Close confirmation bottom sheet
                        onTapDeleteAccount
                            ?.call(); // Call the delete account API
                      },
                      confirmText: 'Yes, Delete',
                      cancelText: 'Cancel',
                    );
                  }
                      : null,
                  // Set onTap to null to disable the button
                  text: 'Confirm Deletion',
                  // You might need to adjust button styling for disabled state
                  bgColor: pController.isDeleteConfirmed
                      ? AppColors.primaryColor // Enabled color
                      : AppColors.lightGrey, // Disabled color
                ),
                SizedBox(height: Dimensions.getHeight(20)),
              ],
            );
          }),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.getWidth(16),
            vertical: Dimensions.getHeight(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.getHeight(24)),
            AppTexts.mediumText(
                text: 'Gulf Cars Auction Account Deletion',
                fontWeight: FontWeight.bold),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: AppTexts.mediumText(
                    text:
                        'Permanently delete your Gulf Cars Auction account and profile',
                    maxLine: 3,
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: Dimensions.mFontSize16,
                    color: AppColors.extraLightFontColor),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
