import 'package:flutter/material.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../global.dart';

class AppDropdowns {
  AppDropdowns._();

  static Widget simpleDropdown<T>({
    required String title,
    required List<T> items,
    required T? selectedItem,
    required Function(T?) onChanged,
    String Function(T)? itemLabelBuilder,
    double? fontSize,
    EdgeInsets? padding,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: selectedItem,
        isExpanded: true,
        icon: AppButtons.circleButtonStrokeOnly(
            svgIconPath: AppSvgIcons.arrowDown,
            padding: Dimensions.getWidth(10),
            iconSize: Dimensions.getWidth(16)),
        style: TextStyle(
          fontSize: fontSize ?? Dimensions.mFontSize14,
          fontWeight: FontWeight.w500,
          color: AppColors.baseFontColor,
          fontFamily: AppFonts.mulish,
        ),
        items: items.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(itemLabelBuilder?.call(value) ?? value.toString()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }


  static Widget generalDropdown<T>({
    required List<T> items,
    required T? selectedItem,
    required Function(T?) onChanged,
    String Function(T)? itemLabelBuilder,
    double? fontSize,
    EdgeInsets? padding,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: selectedItem,
        isExpanded: true,
        style: TextStyle(
          fontSize: fontSize ?? Dimensions.mFontSize14,
          fontWeight: FontWeight.w500,
          color: AppColors.baseFontColor,
          fontFamily: AppFonts.mulish,
        ),
        items: items.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(itemLabelBuilder?.call(value) ?? value.toString()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  static Widget bgDropdown<T>({
    required String title,
    required List<T> items,
    required T? selectedItem,
    required Function(T?) onChanged,
    String Function(T)? itemLabelBuilder,
    double? fontSize,
    EdgeInsets? padding,
  }) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.getHeight(8)),
      decoration: BoxDecoration(
        color: AppColors.skeletonColor1,
        borderRadius: BorderRadius.circular(
          Dimensions.getHeight(4),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedItem,
          isExpanded: true,
          icon: AppButtons.circleButtonBg(
              svgIconPath: AppSvgIcons.arrowDown,
              padding: Dimensions.getWidth(4),
              iconColor: AppColors.primaryColor,
              iconSize: Dimensions.getWidth(14)),
          style: TextStyle(
            fontSize: fontSize ?? Dimensions.mFontSize14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            fontFamily: AppFonts.mulish,
          ),
          items: items.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(itemLabelBuilder?.call(value) ?? value.toString(),
                  style: TextStyle(color: AppColors.primaryColor)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
