import 'package:flutter/material.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:pinput/pinput.dart';

class AppOTPInputFields {
  AppOTPInputFields._();

  static Widget customOtpInputField1(
      {TextEditingController? controller,
        FocusNode? focusNode,
        int length = 4,
        ValueChanged<String>? onSubmitted,
        ValueChanged<String>? onCompleted,
        ValueChanged<String>? onChanged}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        focusNode: focusNode,
        length: length,
        defaultPinTheme: PinTheme(
            width: Dimensions.getWidth(40),
            height: Dimensions.getWidth(40),
          textStyle: TextStyle(fontSize: Dimensions.mFontSize26),
        ),
        separatorBuilder: (index) => SizedBox(width: Dimensions.getWidth(16),),
        hapticFeedbackType: HapticFeedbackType.vibrate,
        onCompleted: onCompleted,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        followingPinTheme: PinTheme(
            width: Dimensions.getWidth(72),
            height: Dimensions.getWidth(44),
            textStyle: TextStyle(fontSize: Dimensions.mFontSize22),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
                border:
                Border.all(color: AppColors.mediumLightGrey))),
        focusedPinTheme: PinTheme(
            width: Dimensions.getWidth(72),
            height: Dimensions.getWidth(44),
            textStyle: TextStyle(fontSize: Dimensions.mFontSize22),
            decoration: BoxDecoration(
                color: AppColors.lightGrey,
                border:
                Border.all(color: AppColors.mediumLightGrey))),
        submittedPinTheme: PinTheme(
            width: Dimensions.getWidth(72),
            height: Dimensions.getWidth(44),
            textStyle: TextStyle(fontSize: Dimensions.mFontSize22),
            decoration: BoxDecoration(
                color: AppColors.lightGrey,
                border:
                Border.all(color: AppColors.mediumLightGrey))),
        errorPinTheme: PinTheme(
            width: Dimensions.getWidth(72),
            height: Dimensions.getWidth(44),
            decoration: BoxDecoration(
                color: AppColors.red,
                border:
                Border.all(color: AppColors.red))),
      ),
    );
  }
}