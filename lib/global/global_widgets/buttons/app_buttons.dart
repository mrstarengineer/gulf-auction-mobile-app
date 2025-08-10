import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AppButtons {
  AppButtons._();

  static Widget iconButton(
      {double? size,
      VoidCallback? onTap,
      required IconData icon,
      Color? color}) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: color ?? AppColors.white,
          size: size ?? Dimensions.getHeight(24),
        ));
  }

  static Widget radioButton<T>(
      {required T value,
      required T selectedValue,
      ValueChanged<T>? onChanged}) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.grey,
      ),
      child: Radio<T>(
        value: value,
        groupValue: selectedValue,
        activeColor: AppColors.primaryColor,
        onChanged: (value) {
          if (value != null) {
            onChanged?.call(value);
          }
        },
      ),
    );
  }

  static Widget iconButtonWithBg(
      {double? size,
      VoidCallback? onTap,
      required IconData icon,
      double? radius,
      Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: radius ?? Dimensions.getHeight(12),
        child: Icon(
          icon,
          color: color ?? AppColors.white,
          size: size ?? Dimensions.getHeight(12),
        ),
      ),
    );
  }

  static Widget checkBox(
      {required bool value, ValueChanged<bool?>? onChanged}) {
    return Container(
      margin: EdgeInsets.only(right: Dimensions.getHeight(8)),
      child: SizedBox(
        width: Dimensions.getHeight(24),
        height: Dimensions.getHeight(24),
        child: Checkbox(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (!states.contains(WidgetState.selected)) {
              return AppColors.white;
            }
            return AppColors.primaryColor;
          }),
          side: BorderSide(color: AppColors.unselectedColor, width: 2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.getHeight(2))),
          activeColor: AppColors.primaryColor,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  static Widget svgIconButton(
      {double? size,
      VoidCallback? onTap,
      required String iconPath,
      Color? color,
      ValueKey<int>? key}) {
    return GestureDetector(
        key: key,
        onTap: onTap,
        child: AppIconWidgets.svgAssetIcon(
            iconPath: iconPath, size: size, color: color));
  }

  static Widget svgIconButtonWithText(
      {double? size,
      bool isIconAtRight = false,
      required String text,
      VoidCallback? onTap,
      required String iconPath,
      Color? color,
      Color? bgColor}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: bgColor == null
              ? null
              : EdgeInsets.symmetric(
                  horizontal: Dimensions.getWidth(16),
                  vertical: Dimensions.getHeight(10)),
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(Dimensions.getHeight(100))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              !isIconAtRight
                  ? AppIconWidgets.svgAssetIcon(
                      iconPath: iconPath, size: size, color: color)
                  : const SizedBox.shrink(),
              !isIconAtRight
                  ? SizedBox(
                      width: Dimensions.getHeight(6),
                    )
                  : const SizedBox.shrink(),
              AppTexts.mediumText(text: text, color: color),
              isIconAtRight
                  ? SizedBox(
                      width: Dimensions.getHeight(6),
                    )
                  : const SizedBox.shrink(),
              isIconAtRight
                  ? AppIconWidgets.svgAssetIcon(
                      iconPath: iconPath, size: size, color: color)
                  : const SizedBox.shrink(),
            ],
          ),
        ));
  }

  static Widget textButton(
      {required String text,
      double? fontSize,
      FontWeight fontWeight = FontWeight.w400,
      VoidCallback? onTap,
      Color? color}) {
    return GestureDetector(
        onTap: onTap,
        child: AppTexts.smallText(
            text: text,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? AppColors.blue));
  }

  static Widget btnWithBg({
    required String text,
    FontWeight fontWeight = FontWeight.bold,
    double? padding,
    double? width,
    double? height,
    double? radius,
    VoidCallback? onTap,
    Color? bgColor,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.maxFinite,
        height: height,
        padding: EdgeInsets.all(padding ?? Dimensions.getHeight(12)),
        decoration: BoxDecoration(
            color: bgColor ?? AppColors.primaryColor,
            borderRadius:
                BorderRadius.circular(radius ?? Dimensions.getHeight(6))),
        child: AppTexts.mediumText(
            text: text,
            color: textColor ?? AppColors.white,
            fontWeight: fontWeight),
      ),
    );
  }

  static Widget textBtnWithStrokeOnly({
    required String text,
    FontWeight fontWeight = FontWeight.bold,
    double? width,
    double? height,
    double? padding,
    double? radius,
    double? fontSize,
    VoidCallback? onTap,
    Color? strokeColor,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.maxFinite,
        height: height,
        padding: EdgeInsets.all(padding ?? Dimensions.getHeight(12)),
        decoration: BoxDecoration(
            border: Border.all(
                color: strokeColor ?? AppColors.primaryColor, width: 1),
            borderRadius:
                BorderRadius.circular(radius ?? Dimensions.getHeight(6))),
        child: AppTexts.mediumText(
            text: text,
            color: textColor ?? AppColors.primaryColor,
            fontWeight: fontWeight,
            fontSize: fontSize),
      ),
    );
  }

  static Widget iconBtnWithStrokeOnly({
    double? width,
    double? height,
    VoidCallback? onTap,
    Color? bgColor,
    String? svgIconPath,
    Color? strokeColor,
    String? pngIconPath,
    double? padding,
    IconData? icon,
    double? iconSize,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        padding: EdgeInsets.all(padding ?? Dimensions.getHeight(12)),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.transparent,
            border: Border.all(color: strokeColor ?? AppColors.grey, width: 1),
            borderRadius: BorderRadius.circular(
              Dimensions.getHeight(6),
            )),
        child: svgIconPath != null
            ? AppIconWidgets.svgAssetIcon(
                iconPath: svgIconPath,
                color: iconColor,
                size: iconSize ?? Dimensions.getHeight(18))
            : pngIconPath != null
                ? AppIconWidgets.pngAssetIcon(
                    iconPath: pngIconPath,
                    color: iconColor,
                    height: Dimensions.getWidth(18),
                    width: iconSize ?? Dimensions.getHeight(18))
                : Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  ),
      ),
    );
  }

  static Widget textIconBtnWithStrokeOnly({
    double? width,
    double? height,
    VoidCallback? onTap,
    Color? bgColor,
    String? svgIconPath,
    Color? strokeColor,
    String? pngIconPath,
    double? padding,
    IconData? icon,
    double? iconSize,
    Color? iconColor,
    required String text,
    FontWeight fontWeight = FontWeight.bold,
    double? radius,
    double? fontSize,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        padding: EdgeInsets.all(padding ?? Dimensions.getHeight(12)),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.transparent,
            border: Border.all(color: strokeColor ?? AppColors.grey, width: 1),
            borderRadius: BorderRadius.circular(
              Dimensions.getHeight(6),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgIconPath != null
                ? AppIconWidgets.svgAssetIcon(
                    iconPath: svgIconPath,
                    color: iconColor,
                    size: iconSize ?? Dimensions.getHeight(18))
                : pngIconPath != null
                    ? AppIconWidgets.pngAssetIcon(
                        iconPath: pngIconPath,
                        color: iconColor,
                        height: Dimensions.getWidth(18),
                        width: iconSize ?? Dimensions.getHeight(18))
                    : Icon(
                        icon,
                        size: iconSize,
                        color: iconColor,
                      ),
            AppTexts.mediumText(
                text: text,
                color: textColor ?? AppColors.primaryColor,
                fontWeight: fontWeight,
                fontSize: fontSize),
          ],
        ),
      ),
    );
  }

  static Widget circleButtonBg({
    double? iconSize,
    double? padding,
    String? svgIconPath,
    String? pngIconPath,
    IconData? icon,
    Color? iconColor,
    Color? bgColor,
    int? text,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: bgColor ?? AppColors.white.withOpacity(0.2),
            radius: iconSize ?? Dimensions.getHeight(18),
            child: Padding(
              padding: EdgeInsets.all(padding ?? Dimensions.getHeight(10)),
              child: svgIconPath != null
                  ? AppIconWidgets.svgAssetIcon(
                      iconPath: svgIconPath, size: iconSize, color: iconColor)
                  : pngIconPath != null
                      ? AppIconWidgets.pngAssetIcon(
                          iconPath: pngIconPath,
                          color: iconColor,
                          height: iconSize ?? Dimensions.getHeight(18),
                          width: iconSize ?? Dimensions.getHeight(18))
                      : Icon(
                          icon,
                          size: iconSize,
                          color: iconColor,
                        ),
            ),
          ),
          text == null || text == 0
              ? const SizedBox.shrink()
              : Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: iconSize ?? Dimensions.getHeight(10),
                    child: AppTexts.extraSmallText(
                        text: '$text', color: AppColors.baseFontColor),
                  ),
                )
        ],
      ),
    );
  }

  static Widget circleButtonStrokeOnly(
      {String? svgIconPath,
      Color? strokeColor,
      String? pngIconPath,
      double? padding,
      IconData? icon,
      double? iconSize,
      Color? color,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding ?? Dimensions.getHeight(4)),
        decoration: BoxDecoration(
          border: Border.all(color: strokeColor ?? AppColors.borderColor),
          shape: BoxShape.circle,
        ),
        child: svgIconPath != null
            ? AppIconWidgets.svgAssetIcon(
                iconPath: svgIconPath,
                color: color,
                size: iconSize ?? Dimensions.getHeight(18))
            : pngIconPath != null
                ? AppIconWidgets.pngAssetIcon(
                    iconPath: pngIconPath,
                    color: color,
                    height: Dimensions.getWidth(18),
                    width: iconSize ?? Dimensions.getHeight(18))
                : Icon(
                    icon,
                    size: iconSize,
                    color: color,
                  ),
      ),
    );
  }

  static Widget dropdownBtn<T>({
    bool isRequired = false,
    required String title,
    String? hintText,
    required T type,
    T? initialItem,
    required List<T> items,
    ValueChanged<T?>? onChanged,
    String? Function(T?)? validator,
    bool excludeSelected = false,
    CustomDropdownDecoration? decoration,
  }) {
    return DropdownFlutter<T>.search(
      hintText: hintText ?? title,
      items: items,
      initialItem: initialItem,
      excludeSelected: excludeSelected,
      decoration: decoration ??
          CustomDropdownDecoration(
              closedFillColor: AppColors.textFieldColor,
              errorStyle: TextStyle(fontSize: Dimensions.mFontSize11)),
      validator: validator,
      onChanged: onChanged,
    );
  }

  static Widget floatingActionBtn(BuildContext context,
      {double? size,
      double? iconSize,
      VoidCallback? onTap,
      Color? bgColor,
      Color? iconColor,
      required String svgIconPath}) {
    return Visibility(
      visible: context.viewInsetsBottom == 0.0,
      child: SizedBox(
        width: size ?? Dimensions.getHeight(60),
        height: size ?? Dimensions.getHeight(60),
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: bgColor ?? AppColors.primaryColor,
            onPressed: onTap,
            child: AppIconWidgets.svgAssetIcon(
                iconPath: svgIconPath,
                size: iconSize ?? Dimensions.getHeight(26),
                color: iconColor),
          ),
        ),
      ),
    );
  }
}
