import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class SignInWidgets {
  SignInWidgets._();

  static Widget bgParticle1() {
    return AppIconWidgets.pngAssetIcon(
        iconPath: AppParticles.particle1, height: Dimensions.getHeight(113));
  }

  static Widget bgParticle2() {
    return AppIconWidgets.pngAssetIcon(
        iconPath: AppParticles.particle2, height: Dimensions.getHeight(270));
  }

  static Widget body(
      {TextEditingController? emailController,
      TextEditingController? passController,
      VoidCallback? onTapForgetPass,
      required bool isPassVisible,
      VoidCallback? onTapPassVisibility,
      Key? formKey}) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.getWidth(18)),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.getHeight(23),
            ),
            AppIconWidgets.pngAssetIcon(
                iconPath: AppPngIcons.appLogo, width: Dimensions.getWidth(81)),
            SizedBox(
              height: Dimensions.getHeight(23),
            ),
            AppTexts.extraLargeText(
                text: 'loginTxt'.tr,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.mFontSize30),
            SizedBox(
              height: Dimensions.getHeight(23),
            ),
            AppTextFields.textFieldWithTitle(
                controller: emailController,
                title: 'emailTxt'.tr,
                keyboardType: TextInputType.emailAddress,
                prefixIconSvgPath: AppSvgIcons.mail,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'filedCanNotBeEmptyTxt'.tr;
                  }
                  // else if (!AppRegex.isEmailValidated(email)) {
                  //   return Strings.emailNotValid;
                  // }
                  return null;
                }),
            SizedBox(
              height: Dimensions.getHeight(16),
            ),
            AppTextFields.textFieldWithTitle(
                controller: passController,
                title: 'passwordTxt'.tr,
                hintText: 'passwordHintTxt'.tr,
                prefixIconSvgPath: AppSvgIcons.lock,
                obscureText: !isPassVisible,
                suffixIconSvgPath: !isPassVisible
                    ? AppSvgIcons.eyeClosed
                    : AppSvgIcons.eyeOpened,
                onTapSuffixIcon: onTapPassVisibility,
                validator: (pass) {
                  if (pass == null || pass.isEmpty) {
                    return 'filedCanNotBeEmptyTxt'.tr;
                  }
                  return null;
                }),
            Align(
                alignment: Alignment.centerRight,
                child: AppButtons.textButton(
                  text: 'forgotPasswordTxt'.tr,
                  onTap: onTapForgetPass,
                )),
          ],
        ),
      ),
    );
  }

  static Widget footer(
      {VoidCallback? onTapLogin,
      VoidCallback? onTapReg,
      VoidCallback? onTapGuest}) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.getWidth(18)),
      child: Column(
        children: [
          AppButtons.btnWithBg(text: 'Login', onTap: onTapLogin),
          SizedBox(
            height: Dimensions.getHeight(23),
          ),
          AppTexts.richTextWithTap(
              normalText: 'New to Gulf Auction?',
              tappableText: 'Register',
              onTap: onTapReg),
          SizedBox(
            height: Dimensions.getHeight(43),
          ),
          AppButtons.textBtnWithStrokeOnly(text: 'Guest', onTap: onTapGuest),
        ],
      ),
    );
  }
}
