import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AppBottomSheets {
  AppBottomSheets._();

  static counterOfferSheet({
    TextEditingController? amountPriceController,
    TextEditingController? noteController,
    VoidCallback? onTapCounter,
    Key? formKey,
  }) {
    showMaterialModalBottomSheet(
      barrierColor: Colors.black54,
      backgroundColor: AppColors.lightScaffoldBackgroundColor,
      context: Get.context!,
      expand: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
              Dimensions.getWidth(12)), // Adjust the radius value as needed
        ),
      ),
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: EdgeInsets.only(
              left: Dimensions.getWidth(16),
              right: Dimensions.getWidth(16),
              top: Dimensions.getHeight(24),
              bottom: Dimensions.getHeight(44)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextFields.textFieldWithTitle(
                    isRequired: true,
                    title: 'Amount',
                    controller: amountPriceController,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return Strings.thisFieldCantBeEmpty;
                      }
                      return null;
                    }),
                AppTextFields.textFieldWithTitle(
                    title: 'Note',
                    controller: noteController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return Strings.thisFieldCantBeEmpty;
                      }
                      return null;
                    }),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppButtons.btnWithBg(
                      onTap: onTapCounter,
                      width: Get.width * 0.3,
                      text: 'Counter'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static forgetPasswordSheet({
    TextEditingController? emailController,
    TextEditingController? noteController,
    VoidCallback? onTapResetPassword,
    Key? formKey,
  }) {
    showMaterialModalBottomSheet(
      barrierColor: Colors.black54,
      backgroundColor: AppColors.lightScaffoldBackgroundColor,
      context: Get.context!,
      expand: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
              Dimensions.getWidth(12)), // Adjust the radius value as needed
        ),
      ),
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: EdgeInsets.only(
              left: Dimensions.getWidth(16),
              right: Dimensions.getWidth(16),
              top: Dimensions.getHeight(24),
              bottom: Dimensions.getHeight(44)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextFields.textFieldWithTitle(
                  isRequired: true,
                  title: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return Strings.thisFieldCantBeEmpty;
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.center,
                  child: AppButtons.btnWithBg(
                    onTap: onTapResetPassword,
                    width: Get.width * 0.4,
                    text: 'Reset Password',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static imageSourceChooserWithFile({
    bool showFilePicker = false,
    required Function(ImageSource) onTapCam,
    required Function(ImageSource) onTapGallery,
    VoidCallback? onTapFile,
  }) {
    showMaterialModalBottomSheet(
      barrierColor: Colors.black54,
      backgroundColor: AppColors.lightScaffoldBackgroundColor,
      context: Get.context!,
      expand: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
              Dimensions.getWidth(12)), // Adjust the radius value as needed
        ),
      ),
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: EdgeInsets.only(
              left: Dimensions.getWidth(16),
              right: Dimensions.getWidth(16),
              top: Dimensions.getHeight(24),
              bottom: Dimensions.getHeight(44)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  onTapCam(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(Icons.camera_alt,
                        size: Dimensions.getWidth(24),
                        color: AppColors.primaryColor),
                    SizedBox(
                      width: Dimensions.getWidth(8),
                    ),
                    Expanded(
                      child: AppTexts.smallText(text: 'Camera'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.getHeight(16),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  onTapGallery(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(Icons.photo,
                        size: Dimensions.getWidth(24),
                        color: AppColors.primaryColor),
                    SizedBox(
                      width: Dimensions.getWidth(8),
                    ),
                    Expanded(
                      child: AppTexts.smallText(text: 'Gallery'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.getHeight(showFilePicker ? 16 : 0),
              ),
              if (showFilePicker)
                GestureDetector(
                  onTap: () async {
                    Get.back();
                    onTapFile?.call();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.file_copy,
                          size: Dimensions.getWidth(24),
                          color: AppColors.primaryColor),
                      SizedBox(
                        width: Dimensions.getWidth(8),
                      ),
                      Expanded(
                        child: AppTexts.smallText(text: 'File'),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  static filterByDate<T>({
    required String title,
    required List<T> items,
    required T? selectedItem,
    required Function(T?) onChanged,
  }) {
    showMaterialModalBottomSheet(
      barrierColor: Colors.black54,
      backgroundColor: AppColors.lightScaffoldBackgroundColor,
      context: Get.context!,
      expand: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
              Dimensions.getWidth(12)), // Adjust the radius value as needed
        ),
      ),
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: EdgeInsets.only(
              left: Dimensions.getWidth(16),
              right: Dimensions.getWidth(16),
              top: Dimensions.getHeight(24),
              bottom: Dimensions.getHeight(44)),
          child: Column(
            children: [
              AppTexts.mediumText(
                text: title,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: Dimensions.getWidth(8),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.getWidth(8),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius:
                        BorderRadius.circular(Dimensions.getWidth(4))),
                child: AppDropdowns.generalDropdown<T>(
                  items: items,
                  selectedItem: selectedItem,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showAccountControlBottomSheet({
    required String title,
    String? subTitle,
    required Widget body,
    bool isDismissible = true,
  }) {
    Get.bottomSheet(
      // Using GetX's bottomSheet for convenience
      Container(
        padding: const EdgeInsets.all(16.0), // Adjust padding as needed
        decoration: const BoxDecoration(
          color: Colors.white, // Or your app's background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left close icon
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(), // Close the bottom sheet
                ),
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Or your app's primary font color
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Placeholder for alignment, or if you have a right action
                const SizedBox(width: 48),
                // Same width as IconButton for centering title
              ],
            ),
            if (subTitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600], // Or your app's subtitle color
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20), // Space between subtitle and body
            body, // The custom content passed to the bottom sheet
          ],
        ),
      ),
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      // Allow dragging to dismiss if isDismissible is true
      backgroundColor:
          Colors.transparent, // To show the Container's borderRadius
    );
  }

  static void showAccountConfirmationBottomSheet({
    required String title,
    required String description,
    required VoidCallback onConfirm,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDismissible = true,
  }) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(Dimensions.getWidth(16)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.mFontSize20),
            topRight: Radius.circular(Dimensions.mFontSize20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close, color: AppColors.baseFontColor),
                // Close icon
                onPressed: () => Get.back(),
              ),
            ),
            SizedBox(height: Dimensions.getHeight(10)),
            AppTexts.largeText(
              // Title of the confirmation
              text: title,
              textAlign: TextAlign.center,
              color: AppColors.baseFontColor,
            ),
            SizedBox(height: Dimensions.getHeight(15)),
            AppTexts.mediumText(
              // Description
              text: description,
              textAlign: TextAlign.center,
              color: AppColors.extraLightFontColor,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: Dimensions.getHeight(30)),
            Row(
              children: [
                Expanded(
                  child: AppButtons.textBtnWithStrokeOnly(
                    // Cancel button
                    onTap: () => Get.back(), // Dismiss bottom sheet
                    text: cancelText,
                    textColor: AppColors.baseFontColor, // Adjust color
                  ),
                ),
                SizedBox(width: Dimensions.getWidth(15)),
                Expanded(
                  child: AppButtons.btnWithBg(
                    // Confirm button
                    onTap: onConfirm,
                    // Execute the provided confirmation action
                    text: confirmText,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.getHeight(20)),
          ],
        ),
      ),
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      backgroundColor: Colors.transparent,
    );
  }
}
