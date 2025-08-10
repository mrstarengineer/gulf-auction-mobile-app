import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../sign_up.dart';

class SignUpWidgets {
  SignUpWidgets._();

  static Widget header({
    bool showStepper = false,
    int? activeStepNo,
    int? totalStepsCount,
    MProfileType selectedProfileType = MProfileType.individual,
    ValueChanged<MProfileType>? onTapBusiness,
    ValueChanged<MProfileType>? onTapIndividual,
  }) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.getHeight(19),
        ),
        AppIconWidgets.pngAssetIcon(
            iconPath: AppPngIcons.appLogo, width: Dimensions.getWidth(81)),
        SizedBox(
          height: Dimensions.getHeight(15),
        ),
        (() {
          if (showStepper) {
            return Column(
              children: [
                AppSteppers.countStepper(
                    activeStepNo: activeStepNo,
                    totalStepsCount: totalStepsCount),
              ],
            );
          } else {
            return Column(
              children: [
                AppTexts.extraLargeText(
                    text: 'setProfileTxt'.tr,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.mFontSize30),
                SizedBox(
                  height: Dimensions.getHeight(15),
                ),
                _profileTypeToggle(
                    selectedProfileType: selectedProfileType,
                    onTapBusiness: onTapBusiness,
                    onTapIndividual: onTapIndividual),
              ],
            );
          }
        }()),
      ],
    );
  }

  static Widget body({
    TextEditingController? companyController,
    TextEditingController? trnController,
    TextEditingController? ibanController,
    TextEditingController? fNameController,
    TextEditingController? lNameController,
    TextEditingController? emailController,
    TextEditingController? numberController,
    required MProfileType selectedProfileType,
    ValueChanged<CountryCode>? onCountryChanged,
  }) {
    return Column(
      children: [
        selectedProfileType == MProfileType.business
            ? AppTextFields.textFieldWithTitle(
                controller: companyController,
                title: 'companyNameTxt'.tr,
                hintText: 'companyNameHintTxt'.tr,
                prefixIconSvgPath: AppSvgIcons.mail,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'filedCanNotBeEmptyTxt'.tr;
                  }
                  return null;
                })
            : const SizedBox.shrink(),
        selectedProfileType == MProfileType.business
            ? AppTextFields.textFieldWithTitle(
                controller: trnController,
                title: 'trnTxt'.tr,
                hintText: 'trnHintTxt'.tr,
                prefixIconSvgPath: AppSvgIcons.trnNo,
                validator: (number) {
                  if (number == null || number.isEmpty) {
                    return 'filedCanNotBeEmptyTxt'.tr;
                  }
                  return null;
                })
            : const SizedBox.shrink(),
        AppTextFields.textFieldWithTitle(
            controller: fNameController,
            title: 'firstNameTxt'.tr,
            hintText: 'firstNameHintTxt'.tr,
            prefixIconSvgPath: AppSvgIcons.user,
            validator: (name) {
              if (name == null || name.isEmpty) {
                return 'filedCanNotBeEmptyTxt'.tr;
              }
              return null;
            }),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
        AppTextFields.textFieldWithTitle(
            controller: lNameController,
            title: 'lastNameTxt'.tr,
            hintText: 'lastNameHintTxt'.tr,
            prefixIconSvgPath: AppSvgIcons.user,
            validator: (name) {
              if (name == null || name.isEmpty) {
                return 'filedCanNotBeEmptyTxt'.tr;
              }
              return null;
            }),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
        AppTextFields.textFieldWithTitle(
            controller: emailController,
            title: 'emailTxt'.tr,
            hintText: 'hintEmailTxt'.tr,
            prefixIconSvgPath: AppSvgIcons.mail,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'filedCanNotBeEmptyTxt'.tr;
              } else if (!AppRegex.isEmailValidated(email)) {
                return 'validEmailConfirmationTxt'.tr;
              }
              return null;
            }),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
        AppTextFields.textFieldWithCountryCode(
            controller: numberController,
            title: 'phoneNumberTxt'.tr,
            hintText: 'hintPhoneNumberTxt'.tr,
            onCountryChanged: onCountryChanged,
            validator: (phoneNo) {
              if (phoneNo == null || phoneNo.isEmpty) {
                return 'filedCanNotBeEmptyTxt'.tr;
              }
              return null;
            }),
        selectedProfileType == MProfileType.business
            ? AppTextFields.textFieldWithTitle(
                controller: trnController,
                title: 'IBAN',
                hintText: 'Enter IBAN',
                prefixIconSvgPath: AppSvgIcons.trnNo,
                validator: (number) {
                  if (number == null || number.isEmpty) {
                    return 'filedCanNotBeEmptyTxt'.tr;
                  }
                  return null;
                })
            : const SizedBox.shrink(),
      ],
    );
  }

  static Widget stepperBody({
    int activeStepNo = 1,
    required String email,
    int otpLength = 4,
    bool isOtpValid = true,
    TextEditingController? otpTextController,
    VoidCallback? onTapResendOtp,
    VoidCallback? onTapVerifyOtp,
    VoidCallback? onTapSavePass,
    VoidCallback? onFinishCountDown,
    TextEditingController? passController,
    TextEditingController? confirmPassController,
    TextEditingController? addressController,
    List<TextEditingController>? stepper4TextEditingController,
    VoidCallback? onTapStoreDocument,
    Key? formKeyPassword,
    required List<CountryInfo> countries,
    bool isCountrySelected = false,
    bool isOtpSent = false,
    ValueChanged<CountryInfo?>? onChangeCountryStep3,
    Map<String, RequiredDocumentType>? requiredDocumentTypes,
    Function(String, Documents)? onUploadDocument,
    required bool isPassVisible,
    VoidCallback? onTapPassVisibility,
    required bool isConfirmPassVisible,
    VoidCallback? onTapConfirmPassVisibility,
  }) {
    return (() => switch (activeStepNo) {
          2 => _stepperBody1(
              email: email,
              isOtpSent: isOtpSent,
              otpLength: otpLength,
              otpTextController: otpTextController,
              onTapResendOtp: onTapResendOtp,
              onTapVerifyOtp: onTapVerifyOtp,
              onFinishCountDown: onFinishCountDown,
              isOtpValid: isOtpValid),
          3 => _stepperBody2(
              onTapPassVisibility: onTapPassVisibility,
              onTapConfirmPassVisibility: onTapConfirmPassVisibility,
              // isCountrySelected: isCountrySelected,
              formKeyPass: formKeyPassword,
              passController: passController,
              confirmPassController: confirmPassController,
              isPassVisible: isPassVisible,
              isConfirmPassVisible: isConfirmPassVisible,
              onTapSavePass: onTapSavePass,
            ),
          _ => _stepperBody3(
              addressController: addressController,
              countries: countries,
              onChangeCountry: onChangeCountryStep3,
              textEditingController: stepper4TextEditingController,
              isCountrySelected: isCountrySelected,
              onTapSaveInfo: onTapStoreDocument,
              requiredDocumentTypes: requiredDocumentTypes,
              onUploadDocument: onUploadDocument,
            )
        })();
  }

  static Widget footer({
    VoidCallback? onTapTermsAndConditions,
    VoidCallback? onTapPrivacyPolicy,
    VoidCallback? onTapLogin,
    VoidCallback? onTapSignUp,
    required bool termsAndConditionsAgreed,
    ValueChanged<bool?>? onChangeTermsAndConditionsAgreed,
  }) {
    return Column(
      children: [
        Row(
          children: [
            AppButtons.checkBox(
                value: termsAndConditionsAgreed,
                onChanged: onChangeTermsAndConditionsAgreed),
            Expanded(
                child: _footerRichText(
              onTapTermsAndConditions: onTapTermsAndConditions,
              onTapPrivacyPolicy: onTapPrivacyPolicy,
            )),
          ],
        ),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
        AppButtons.btnWithBg(text: 'signUpTxt'.tr, onTap: onTapSignUp),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
        AppTexts.richTextWithTap(
            normalText: 'alreadyHaveAccountTxt'.tr,
            tappableText: 'loginTxt'.tr,
            onTap: onTapLogin),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
      ],
    );
  }
}

// STEPPER BODIES
Widget _stepperBody1({
  required String email,
  TextEditingController? otpTextController,
  int otpLength = 4,
  VoidCallback? onTapResendOtp,
  VoidCallback? onTapVerifyOtp,
  bool isOtpValid = true,
  bool isOtpSent = true,
  VoidCallback? onFinishCountDown,
}) {
  return Column(
    children: [
      AppTexts.extraLargeText(
          text: 'verificationTxt'.tr,
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.mFontSize30),
      SizedBox(
        height: Dimensions.getHeight(23),
      ),
      AppTexts.mediumText(
          text: '${'emailSendMessageTxt'.tr} ${AppMasks.maskEmail(email)}',
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center),
      SizedBox(
        height: Dimensions.getHeight(23),
      ),
      AppOTPInputFields.customOtpInputField1(
          controller: otpTextController, length: otpLength),
      SizedBox(
        height: !isOtpValid ? Dimensions.getHeight(12) : 0,
      ),
      !isOtpValid
          ? Align(
              alignment: Alignment.topLeft,
              child: AppTexts.smallText(
                text: 'validCodeConfirmationTxt'.tr,
                color: AppColors.red,
              ),
            )
          : const SizedBox.shrink(),
      SizedBox(
        height: Dimensions.getHeight(23),
      ),
      AppButtons.btnWithBg(text: 'verifyOtpTxt'.tr, onTap: onTapVerifyOtp),
      SizedBox(
        height: Dimensions.getHeight(23),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTexts.smallText(
            text: '${'didNotGetOtpTxt'.tr} ',
            color: AppColors.extraLightFontColor,
          ),
          isOtpSent
              ? AppButtons.textButton(
                  onTap: onTapResendOtp,
                  text: 'resendCodeTxt'.tr,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTexts.smallText(text: '${'resendCodeAgainTxt'.tr} '),
                    OtpCountdownTimer(onFinish: () {
                      onFinishCountDown?.call();
                    }),
                  ],
                )
        ],
      ),
    ],
  );
}

Widget _stepperBody2({
  TextEditingController? passController,
  TextEditingController? confirmPassController,
  required bool isPassVisible,
  required bool isConfirmPassVisible,
  VoidCallback? onTapPassVisibility,
  VoidCallback? onTapConfirmPassVisibility,
  // TextEditingController? addressController,
  VoidCallback? onTapSavePass,
  // ValueChanged<CountryInfo?>? onChangeCountry,
  // required List<CountryInfo> countries,
  Key? formKeyPass,
  // bool isCountrySelected = false,
}) {
  return Form(
    key: formKeyPass,
    child: Column(
      children: [
        AppTexts.extraLargeText(
            text: 'setPasswordTxt'.tr,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.mFontSize30),
        SizedBox(
          height: Dimensions.getHeight(23),
        ),
        AppTextFields.textFieldWithTitle(
            controller: passController,
            prefixIconSvgPath: AppSvgIcons.lock,
            obscureText: !isPassVisible,
            suffixIconSvgPath:
                !isPassVisible ? AppSvgIcons.eyeClosed : AppSvgIcons.eyeOpened,
            onTapSuffixIcon: onTapPassVisibility,
            title: 'passwordTxt'.tr,
            hintText: 'passwordHintTxt'.tr,
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
            }),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
        AppTextFields.textFieldWithTitle(
          controller: confirmPassController,
          prefixIconSvgPath: AppSvgIcons.lock,
          obscureText: !isConfirmPassVisible,
          suffixIconSvgPath: !isConfirmPassVisible
              ? AppSvgIcons.eyeClosed
              : AppSvgIcons.eyeOpened,
          onTapSuffixIcon: onTapConfirmPassVisibility,
          title: 'confirmPasswordTxt'.tr,
          hintText: 'confirmPasswordHintTxt'.tr,
          validator: (confirmPass) {
            if (confirmPass == null || confirmPass.isEmpty) {
              return 'filedCanNotBeEmptyTxt'.tr;
            } else if (confirmPass != passController?.text) {
              return 'passMismatchedTxt'.tr;
            }
            return null;
          },
        ),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
/*        AppPickersButtons.countryPicker(
            title: 'countryTxt'.tr,
            countries: countries,
            onChanged: onChangeCountry,
            isCountrySelected: isCountrySelected),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
        AppTextFields.textFieldWithTitle(
            controller: addressController,
            title: 'addressTxt'.tr,
            hintText: 'addressHintTxt'.tr,
            validator: (address) {
              if (address == null || address.isEmpty) {
                return 'filedCanNotBeEmptyTxt'.tr;
              }
              return null;
            }),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),*/
        AppButtons.btnWithBg(
            text: 'saveAndContinueTxt'.tr,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              onTapSavePass?.call();
            }),
        SizedBox(
          height: Dimensions.getHeight(23),
        ),
      ],
    ),
  );
}

Widget _stepperBody3({
  required List<CountryInfo> countries,
  Map<String, RequiredDocumentType>? requiredDocumentTypes,
  List<TextEditingController>? textEditingController,
  VoidCallback? onTapSaveInfo,
  Function(String, Documents)? onUploadDocument,
  TextEditingController? addressController,
  ValueChanged<CountryInfo?>? onChangeCountry,
  bool isCountrySelected = false,
}) {
  return (() {
    if (requiredDocumentTypes == null) {
      return const Text(
          'Something went wrong, please close & reopen the application');
    } else {
      return GetBuilder<SignUpController>(builder: (controller) {
        return Column(
          children: [
            AppPickersButtons.countryPicker(
                title: 'whereAreYouFromTxt'.tr,
                countries: countries,
                onChanged: onChangeCountry,
                isRequired: true,
                isCountrySelected: isCountrySelected),
            SizedBox(
              height: Dimensions.getHeight(16),
            ),
            AppTextFields.textFieldWithTitle(
                controller: addressController,
                title: 'currentLocationTxt'.tr,
                hintText: 'addressHintTxt'.tr,
                isRequired: true),
            SizedBox(
              height: Dimensions.getHeight(16),
            ),
            // Generating the widget structure based on the number of document types
            ...requiredDocumentTypes.entries.map((entry) {
              String key = entry.key; // In case the key is needed
              RequiredDocumentType documentType = entry.value;

              int index = requiredDocumentTypes.keys.toList().indexOf(key);

              final textEditingController =
                  controller.stepper4TextEditingControllers[index];
              var documentInfo = controller.stepper4Documents[index];
              return Column(
                children: [
                  // Dynamic Title for each DocumentType
                  AppTexts.mediumText(
                    text: '${documentType.title} ${'informationTxt'.tr}',
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: Dimensions.getHeight(10),
                  ),

                  // Country Picker
                  AppPickersButtons.countryPicker(
                    title: 'countryTxt'.tr,
                    onChanged: (country) {
                      documentInfo.countryId = country?.id;
                    },
                    countries: countries,
                  ),

                  // ID Number Field (Dynamic based on refNumberLabel)
                  AppTextFields.textFieldWithTitle(
                    title: documentType.refNumberLabel ?? '',
                    controller: textEditingController,
                    onChanged: (value) {
                      documentInfo.refNumber = value;
                    },
                  ),

                  // Expire Date Field
                  AppPickersButtons.datePicker2030(
                    title: 'expireDateTxt'.tr,
                    selectedDate: documentInfo.expireDate ?? '',
                    onTap: (selectedDate) {
                      documentInfo.expireDate = selectedDate;
                      controller.update();
                    },
                  ),

                  _cameraBtn(
                    pickedImagePath: documentInfo.url,
                    onTap: () => AppBottomSheets.imageSourceChooserWithFile(
                        showFilePicker: true,
                        onTapCam: (imgSrc) {
                          AppPickers.imagePicker(imgSrc: imgSrc)
                              .then((imgPath) {
                            if (imgPath != null) {
                              Get.context!.showLoaderOverlay;
                              controller
                                  .uploadDocument(file: File(imgPath))
                                  .then((response) {
                                Get.context!.hideLoaderOverlay;
                                if (response.isSuccess) {
                                  documentInfo.url = response.message;
                                  controller.update();
                                } else {
                                  AppToasts.shortToast(response.message);
                                }
                              });
                            }
                          });
                        },
                        onTapGallery: (imgSrc) {
                          AppPickers.imagePicker(imgSrc: imgSrc)
                              .then((imgPath) {
                            if (imgPath != null) {
                              Get.context!.showLoaderOverlay;
                              controller
                                  .uploadDocument(file: File(imgPath))
                                  .then((response) {
                                Get.context!.hideLoaderOverlay;
                                if (response.isSuccess) {
                                  documentInfo.url = response.message;
                                  controller.update();
                                } else {
                                  AppToasts.shortToast(response.message);
                                }
                              });
                            }
                          });
                        },
                        onTapFile: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );

                          if (result != null) {
                            onUploadDocument?.call(
                                result.files.single.path!, documentInfo);
                          }
                        }),
                  ),

                  // Adding space between the dynamic forms
                  SizedBox(
                    height: Dimensions.getHeight(20),
                  ),
                ],
              );
            }),

            AppButtons.btnWithBg(
                text: 'saveAndContinueTxt'.tr,
                onTap: () {
                  bool isValid = true;
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (requiredDocumentTypes.isNotEmpty) {
                    // Iterate through the Map<String, RequiredDocumentType>
                    requiredDocumentTypes.entries.forEach((entry) {
                      String key = entry.key;
                      RequiredDocumentType documentType = entry.value;

                      // Fetch the related document info
                      Documents document = controller.stepper4Documents
                          .firstWhere((doc) => doc.type == key);

                      // Perform validation checks
                      if (document.countryId == null) {
                        AppToasts.shortToast(
                            'Please Select Country of ${documentType.title ?? ''}');
                        isValid = false;
                      } else if (document.refNumber?.isEmpty ?? true) {
                        AppToasts.shortToast(
                            'Please Enter ${documentType.title ?? ''} Number');
                        isValid = false;
                      } else if ((document.refNumber?.length ?? 0) < 4) {
                        AppToasts.shortToast(
                            'Please Enter ${documentType.title ?? ''} Number At Least 4 Characters Long');
                        isValid = false;
                      } else if (document.expireDate?.isEmpty ?? true) {
                        AppToasts.shortToast(
                            'Please Enter ${documentType.title ?? ''} Expiry Date');
                        isValid = false;
                      } else if (document.url?.isEmpty ?? true) {
                        AppToasts.shortToast(
                            'Please Enter ${documentType.title ?? ''} Document');
                        isValid = false;
                      } else {
                        // Converting the document to JSON and adding it to the formatted list
                        controller.documentsJsonList.add(document.toJson());
                      }
                    });

                    if (isValid) {
                      onTapSaveInfo?.call();
                    }
                  }
                }),
            SizedBox(
              height: Dimensions.getHeight(32),
            ),
          ],
        );
      });
    }
  }());
}

Widget _profileTypeToggle(
    {required MProfileType selectedProfileType,
    ValueChanged<MProfileType>? onTapIndividual,
    ValueChanged<MProfileType>? onTapBusiness}) {
  return Container(
    padding: EdgeInsets.all(Dimensions.getWidth(5)),
    decoration: BoxDecoration(
      color: HexColor.fromHex('#F8E5E6'),
      borderRadius: BorderRadius.circular(Dimensions.getWidth(100)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            onTapIndividual?.call(MProfileType.individual);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.getWidth(20),
              vertical: Dimensions.getHeight(10),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.getWidth(100)),
              color: selectedProfileType == MProfileType.individual
                  ? AppColors.primaryColor
                  : Colors.transparent,
            ),
            child: AppTexts.mediumText(
                text: 'individualTxt'.tr,
                color: selectedProfileType == MProfileType.individual
                    ? AppColors.white
                    : AppColors.baseFontColor),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTapBusiness?.call(MProfileType.business);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.getWidth(20),
              vertical: Dimensions.getHeight(10),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.getWidth(100)),
              color: selectedProfileType == MProfileType.business
                  ? AppColors.primaryColor
                  : Colors.transparent,
            ),
            child: AppTexts.mediumText(
                text: 'businessTxt'.tr,
                color: selectedProfileType == MProfileType.business
                    ? AppColors.white
                    : AppColors.baseFontColor),
          ),
        ),
      ],
    ),
  );
}

Widget _footerRichText({
  VoidCallback? onTapTermsAndConditions,
  VoidCallback? onTapPrivacyPolicy,
}) {
  return RichText(
    text: TextSpan(
      text: '${'termsAgreementTxt'.tr} ',
      style: TextStyle(
          color: AppColors.extraLightFontColor,
          fontSize: Dimensions.mFontSize12,
          fontFamily: AppFonts.mulish),
      children: [
        TextSpan(
          text: 'actionTermsConditionTxt'.tr,
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w400),
          recognizer: TapGestureRecognizer()..onTap = onTapTermsAndConditions,
        ),
        TextSpan(
          text: ', ${'andTxt'.tr} ',
        ),
        TextSpan(
          text: 'privacyPolicyTxt'.tr,
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w400),
          recognizer: TapGestureRecognizer()..onTap = onTapPrivacyPolicy,
        ),
      ],
    ),
  );
}

Widget _cameraBtn({
  VoidCallback? onTap,
  String? pickedImagePath,
}) {
  final extension = getFileExtension(pickedImagePath ?? '');
  final isImage = extension.toLowerCase() == 'jpg' ||
      extension == 'png' ||
      extension == 'jpeg';
  final isPdf = extension.toLowerCase() == 'pdf';

  return GestureDetector(
    onTap: onTap,
    child: DottedBorder(
        color: AppColors.mediumLightGrey,
        dashPattern: const [3, 2],
        radius: Radius.circular(Dimensions.getWidth(8)),
        child: Container(
          height: Dimensions.getHeight(78),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.getWidth(14),
              vertical: Dimensions.getHeight(24)),
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: pickedImagePath != null &&
                      pickedImagePath.isNotEmpty &&
                      isImage
                  ? DecorationImage(
                      image: NetworkImage(pickedImagePath),
                      fit: BoxFit.fill,
                    )
                  : null),
          child: pickedImagePath == null || pickedImagePath.isEmpty
              ? AppIconWidgets.svgAssetIcon(iconPath: AppSvgIcons.camera)
              : isPdf
                  ? AppIconWidgets.svgAssetIcon(iconPath: AppSvgIcons.pdfFile)
                  : null,
        )),
  );
}
