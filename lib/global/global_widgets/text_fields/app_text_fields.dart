import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AppTextFields {
  AppTextFields._();

  static Widget textFieldHintOnly({
    ValueChanged<String?>? onChanged,
    double? radius,
    bool obscureText = false,
    VoidCallback? onTapSuffixIcon,
    String? suffixIconSvgPath,
    String? fontFamily,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    VoidCallback? onTapPrefixIcon,
    String? prefixIconSvgPath,
    required String hintText,
    TextEditingController? controller,
    int maxLine = 1,
    Color? fillColor,
    Color? suffixIconColor,
    Color? preffixIconColor,
  }) =>
      TextFormField(
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          style:  TextStyle(
              fontFamily: fontFamily ?? AppFonts.mulish,
              fontWeight: FontWeight.normal
          ),
          obscureText: obscureText,
          maxLines: maxLine,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? AppColors.textFieldColor,
            isDense: prefixIconSvgPath == null ? false : true,
            hintText: hintText,
            prefixIcon: prefixIconSvgPath == null
                ? null
                : GestureDetector(
              onTap: onTapPrefixIcon,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(16)),
                // Adjust the padding as needed
                child: AppIconWidgets.svgAssetIcon(iconPath: prefixIconSvgPath, color: preffixIconColor ?? AppColors.baseColor, size: Dimensions.getWidth(20)),
              ),
            ),
            suffixIcon: suffixIconSvgPath == null
                ? const SizedBox()
                : GestureDetector(
              onTap: onTapSuffixIcon,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getWidth(16)),
                child: AppIconWidgets.svgAssetIcon(iconPath: suffixIconSvgPath, color: suffixIconColor ?? AppColors.baseColor, size: Dimensions.getWidth(18)),
              ),
            ),
            hintStyle: TextStyle(
                fontFamily: fontFamily ?? AppFonts.mulish,
                color: AppColors.extraLightFontColor,
                fontSize: Dimensions.mFontSize14,
                fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(10)),
                borderSide: const BorderSide(color: Colors.transparent)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(10)),
                borderSide: const BorderSide(color: Colors.transparent)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(10)),
                borderSide: const BorderSide(color: Colors.transparent)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(10)),
                borderSide: const BorderSide(color: Colors.transparent)
            ),
          ));

  static Widget textFieldWithTitle(
      {bool isRequired = false,
        ValueChanged<String?>? onChanged,
        ValueChanged<String?>? onSaved,
        ValueChanged<String?>? onFieldSubmitted,
        bool obscureText = false,
        VoidCallback? onTapSuffixIcon,
        String? suffixIconSvgPath,
        String? fontFamily,
        TextInputType? keyboardType,
        bool enabled = true,
        String? Function(String?)? validator,
        VoidCallback? onTapPrefixIcon,
        String? prefixIconSvgPath,
        required String title,
        String? hintText,
        TextEditingController? controller,
        int maxLine = 1,
        bool enableCountryPicker = false,
        bool isDense = false,
      }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Dimensions.getHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(child: AppTexts.mediumText(text: title, color: AppColors.lightFontColor, fontWeight: FontWeight.bold)),
                SizedBox(width: isRequired ? Dimensions.getWidth(4) : 0,),
                isRequired ? AppTexts.largeText(text: '*', color: AppColors.red) : const SizedBox.shrink(),
              ],
            ),
            SizedBox(height: Dimensions.getHeight(12),),
            TextFormField(
                keyboardType: keyboardType,
                validator: validator,
                controller: controller,
                style:  TextStyle(
                    fontFamily: fontFamily ?? AppFonts.mulish,
                    fontWeight: FontWeight.normal
                ),
                obscureText: obscureText,
                maxLines: maxLine,
                enabled: enabled,
                onChanged: onChanged,
                onSaved: onSaved,
                onFieldSubmitted: onFieldSubmitted,

                decoration: InputDecoration(

                  filled: true,
                  fillColor: !enabled ? Colors.grey.shade300 : AppColors.textFieldColor,
                  isDense: isDense == true ? isDense : prefixIconSvgPath == null ? false : true,
                  hintText: hintText ?? title,
                  prefixIcon: prefixIconSvgPath == null
                      ? null
                      : GestureDetector(
                    onTap: onTapPrefixIcon,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.getWidth(16)),
                      // Adjust the padding as needed
                      child: AppIconWidgets.svgAssetIcon(
                          iconPath: prefixIconSvgPath,
                          size: Dimensions.getWidth(20)),
                    ),
                  ),
                  suffixIcon: suffixIconSvgPath == null
                      ? const SizedBox()
                      : GestureDetector(
                    onTap: onTapSuffixIcon,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(16)),
                      child: AppIconWidgets.svgAssetIcon(iconPath: suffixIconSvgPath, size:Dimensions.getWidth(18)),
                    ),
                  ),
                  hintStyle: TextStyle(
                      fontFamily: fontFamily ?? AppFonts.mulish,
                      color: AppColors.extraLightFontColor,
                      fontSize: Dimensions.mFontSize14,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                      borderSide: const BorderSide(color: Colors.transparent)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                      borderSide: const BorderSide(color: Colors.transparent)
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                      borderSide: const BorderSide(color: Colors.red, width: 1.5)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                      borderSide: const BorderSide(color: Colors.transparent)
                  ),
                )),
          ],
        ),
      );

  static Widget textFieldBid({
    ValueChanged<String?>? onChanged,
    double? radius,
    bool obscureText = false,
    VoidCallback? onTapSuffixIcon,
    String? suffixIconSvgPath,
    String? fontFamily,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    VoidCallback? onTapPrefixIcon,
    String? prefixIconSvgPath,
    required String hintText,
    TextEditingController? controller,
    int maxLine = 1,
    Color? fillColor,
    Color? suffixIconColor,
    Color? preffixIconColor,
  }) =>
      TextFormField(
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          style:  TextStyle(
              fontFamily: fontFamily ?? AppFonts.mulish,
              fontWeight: FontWeight.normal
          ),
          obscureText: obscureText,
          maxLines: maxLine,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: false,
            fillColor: fillColor ?? AppColors.textFieldColor,
            isDense: prefixIconSvgPath == null ? false : true,
            hintText: hintText,
            prefixIcon: prefixIconSvgPath == null
                ? null
                : GestureDetector(
              onTap: onTapPrefixIcon,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(16)),
                // Adjust the padding as needed
                child: AppIconWidgets.svgAssetIcon(iconPath: prefixIconSvgPath, color: preffixIconColor ?? AppColors.baseColor, size: Dimensions.getWidth(20)),
              ),
            ),
            suffixIcon: suffixIconSvgPath == null
                ? const SizedBox()
                : GestureDetector(
              onTap: onTapSuffixIcon,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getWidth(16)),
                child: AppIconWidgets.svgAssetIcon(iconPath: suffixIconSvgPath, color: suffixIconColor ?? AppColors.baseColor, size: Dimensions.getWidth(18)),
              ),
            ),
            hintStyle: TextStyle(
                fontFamily: fontFamily ?? AppFonts.mulish,
                color: AppColors.extraLightFontColor,
                fontSize: Dimensions.mFontSize14,
                fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(100)),
                borderSide: BorderSide(color: AppColors.grey)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(10)),
                borderSide: const BorderSide(color: Colors.transparent)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(10)),
                borderSide: const BorderSide(color: Colors.transparent)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(10)),
                borderSide: const BorderSide(color: Colors.transparent)
            ),
          ));



  static Widget textFieldWithCountryCode({
    bool isRequired = false,
    ValueChanged<String?>? onChanged,
    bool obscureText = false,
    String? fontFamily,
    TextInputType keyboardType = TextInputType.number,
    bool enabled = true,
    String? Function(String?)? validator,
    required String title,
    String? hintText,
    TextEditingController? controller,
    int maxLine = 1,
    ValueChanged<CountryCode>? onCountryChanged,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Dimensions.getHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    child: AppTexts.mediumText(
                        text: title,
                        color: AppColors.lightFontColor,
                        fontWeight: FontWeight.bold)),
                isRequired
                    ? AppTexts.largeText(text: '*', color: AppColors.red)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
            TextFormField(
              keyboardType: keyboardType,
              validator: validator,
              controller: controller,
              style: TextStyle(
                  fontFamily: fontFamily ?? AppFonts.mulish,
                  fontWeight: FontWeight.normal),
              obscureText: obscureText,
              maxLines: maxLine,
              enabled: enabled,
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                !enabled ? Colors.grey.shade300 : AppColors.textFieldColor,
                isDense: true,
                hintText: hintText ?? title,
                prefixIcon: CountryCodePicker(
                  onChanged: onCountryChanged,
                  initialSelection: 'AE', // default selection
                  favorite: const ['+971', 'AE'],
                  showFlag: true,
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
                hintStyle: TextStyle(
                    fontFamily: fontFamily ?? AppFonts.mulish,
                    color: AppColors.extraLightFontColor,
                    fontSize: Dimensions.mFontSize14,
                    fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                    borderSide: const BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                    borderSide: const BorderSide(color: Colors.transparent)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                    borderSide: const BorderSide(color: Colors.transparent)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                    borderSide: const BorderSide(color: Colors.transparent)),
              ),
            ),
          ],
        ),
      );

}