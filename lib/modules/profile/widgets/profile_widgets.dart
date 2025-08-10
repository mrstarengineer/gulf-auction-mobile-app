import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';
import '../../../utils/skeleton/app_skeletons.dart';
import 'account_control_widget.dart';

class ProfileWidgets {
  ProfileWidgets._();

  static Widget header({
    String? profilePicUrl,
    String? name,
    String? accountTypeName,
    String? roleName,
    ValueChanged<String>? onTapUpdateProfilePhoto,
    ValueChanged<String>? onTapProfilePhoto,
  }) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: profilePicUrl ?? '',
          imageBuilder: (context, imageProvider) => Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (profilePicUrl != null) {
                    onTapProfilePhoto?.call(profilePicUrl);
                  }
                },
                child: CircleAvatar(
                  radius: Dimensions.getHeight(40),
                  backgroundColor: AppColors.lightGrey,
                  backgroundImage: imageProvider,
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: AppButtons.iconButtonWithBg(
                      onTap: () {
                        AppBottomSheets.imageSourceChooserWithFile(
                            onTapCam: (imgSrc) {
                          AppPickers.imagePicker(imgSrc: imgSrc)
                              .then((imgPath) {
                            if (imgPath != null) {
                              onTapUpdateProfilePhoto?.call(imgPath);
                            }
                          });
                        }, onTapGallery: (imgSrc) {
                          AppPickers.imagePicker(imgSrc: imgSrc)
                              .then((imgPath) {
                            if (imgPath != null) {
                              onTapUpdateProfilePhoto?.call(imgPath);
                            }
                          });
                        });
                      },
                      icon: Icons.edit))
            ],
          ),
          placeholder: (context, url) => AppSkeletons.shimmerCircle(
            radius: Dimensions.getHeight(40),
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: AppColors.lightGrey,
            radius: Dimensions.getHeight(40),
            backgroundImage: AssetImage(AppPngIcons.placeholder),
          ),
        ),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.mediumText(text: name ?? ''),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.extraSmallText(
            text: accountTypeName ?? '', color: AppColors.extraLightFontColor),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.extraSmallText(
            text: roleName ?? '', color: AppColors.extraLightFontColor),
      ],
    );
  }

  static Widget tabBar({
    TabController? controller,
    required String title1,
    required String title2,
    required String title3,
  }) {
    return TabBar(
      indicatorColor: AppColors.primaryColor,
      labelStyle: TextStyle(
          color: AppColors.baseFontColor,
          fontFamily: AppFonts.mulish,
          fontSize: Dimensions.mFontSize16),
      controller: controller,
      isScrollable: true,
      tabs: [
        Tab(
          text: title1,
        ),
        Tab(text: title2),
        Tab(text: title3),
      ],
    );
  }

  static Widget tabBarBody({
    TabController? controller,
    String? fName,
    String? lName,
    String? phone,
    String? status,
    String? email,
    String? country,
    String? address,
    TextEditingController? oldPassController,
    TextEditingController? newPassController,
    TextEditingController? confirmNewPassController,
    Key? formKey,
    VoidCallback? onTapUpdatePass,
    VoidCallback? onTapDeleteAccount,
  }) {
    return Expanded(
      child: TabBarView(
        controller: controller,
        children: [
          tabBarBodyPersonalInfo(
              fName: fName,
              lName: lName,
              phone: phone,
              status: status,
              email: email,
              country: country,
              address: address),
          tabBarBodyPassword(
              formKey: formKey,
              oldPassController: oldPassController,
              newPassController: newPassController,
              confirmNewPassController: confirmNewPassController,
              onTapUpdatePass: onTapUpdatePass),
          tabBarBodyAccountControlWidget(
            onTapDeleteAccount: onTapDeleteAccount,
          ),
        ],
      ),
    );
  }
}

Widget tabBarBodyPersonalInfo({
  String? fName,
  String? lName,
  String? phone,
  String? status,
  String? email,
  String? country,
  String? address,
}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        _infoField(title: 'First Name', value: fName),
        _infoField(title: 'Last Name', value: lName),
        _infoField(title: 'Phone', value: phone),
        _infoField(title: 'Status', value: status),
        _infoField(title: 'Email', value: email),
        _infoField(title: 'Country', value: country),
        _infoField(title: 'Address', value: address, isLast: true),
      ],
    ),
  );
}

Widget tabBarBodyPassword({
  TextEditingController? oldPassController,
  TextEditingController? newPassController,
  TextEditingController? confirmNewPassController,
  Key? formKey,
  VoidCallback? onTapUpdatePass,
}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Form(
      key: formKey,
      child: Column(
        children: [
          AppTextFields.textFieldWithTitle(
            isRequired: true,
            title: 'Old Password',
            hintText: 'Enter old password',
            controller: oldPassController,
            validator: (confirmPass) {
              if (confirmPass == null || confirmPass.isEmpty) {
                return 'filedCanNotBeEmptyTxt'.tr;
              }
              return null;
            },
          ),
          SizedBox(
            height: Dimensions.getHeight(12),
          ),
          AppTextFields.textFieldWithTitle(
            isRequired: true,
            title: 'New Password',
            hintText: 'Enter new password',
            controller: newPassController,
            validator: (pass) {
              if (pass == null || pass.isEmpty) {
                return 'filedCanNotBeEmptyTxt'.tr;
              } else if (!AppRegex.isPassUpperCaseValidated(pass)) {
                return 'passUpperCaseNotValidTxt'.tr;
              } else if (!AppRegex.isPassLowerCaseValidated(pass)) {
                return 'passLowerCaseNotValidTxt'.tr;
              } else if (!AppRegex.isPassSpecialCharValidated(pass)) {
                return 'passSpecialCharNotValidTxt'.tr;
              }
              return null;
            },
          ),
          SizedBox(
            height: Dimensions.getHeight(12),
          ),
          AppTextFields.textFieldWithTitle(
            isRequired: true,
            title: 'Confirm New Password',
            hintText: 'Confirm your password',
            controller: confirmNewPassController,
            validator: (confirmPass) {
              if (confirmPass == null || confirmPass.isEmpty) {
                return 'filedCanNotBeEmptyTxt'.tr;
              } else if (confirmPass != newPassController?.text) {
                return 'passMismatchedTxt'.tr;
              }
              return null;
            },
          ),
          SizedBox(
            height: Dimensions.getHeight(16),
          ),
          AppButtons.btnWithBg(onTap: onTapUpdatePass, text: 'Update Password'),
        ],
      ),
    ),
  );
}

Widget _infoField({required String title, String? value, bool isLast = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: Dimensions.getHeight(10)),
    width: double.maxFinite,
    decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: AppColors.lightGrey))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.mediumText(text: title.toUpperCase(), color: AppColors.grey),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.mediumText(
            text: value == null || value == 'null' || value.isEmpty
                ? 'N/A'
                : value,
            overflow: TextOverflow.visible),
      ],
    ),
  );
}
