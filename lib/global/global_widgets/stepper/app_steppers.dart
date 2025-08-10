import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AppSteppers {
  AppSteppers._();

  /// [activeStepNo] represents the currently active step.
  /// [totalStepsCount] is the total number of steps.
  static Widget countStepper ({int? activeStepNo, int? totalStepsCount,}){
    return AnotherStepper(
      activeIndex: activeStepNo ?? 1,
      stepperList: List.generate(totalStepsCount ?? 4, (index) => StepperData(
          iconWidget: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: (activeStepNo ?? 1) >= (index+1) ? AppColors.primaryColor : AppColors.white,
                  border: Border.all(color: AppColors.primaryColor, width: 1.5),
                  shape: BoxShape.circle),
              child: AppTexts.mediumText(text: '${index+1}', color: (activeStepNo ?? 1) >= (index+1) ?  AppColors.white : AppColors.primaryColor)
          ))),
      activeBarColor: AppColors.primaryColor,
      inActiveBarColor:AppColors.mediumLightGrey,
      stepperDirection: Axis.horizontal,
      iconWidth: Dimensions.getWidth(30), // Height that will be applied to all the stepper icons
      iconHeight: Dimensions.getWidth(30), // Width that will be applied to all the stepper icons
    );
  }
}