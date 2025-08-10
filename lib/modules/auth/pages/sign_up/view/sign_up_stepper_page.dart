import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/preference/controller/preference_controller.dart';
import 'package:gulf_car_auction/preference/keys/preference_keys.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';
import '../sign_up.dart';

class SignUpStepperPage extends StatelessWidget {
  const SignUpStepperPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();
    final globalController = Get.find<GlobalController>();
    final prefController = Get.find<PreferenceController>();
    final formKeyPassword = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBars.appBarSignUp(
          isHome: false,
          title: 'Member Registration',
          onTapBack: () {
            if (controller.activeStepNo > 3) {
              if (prefController.containsKey(PrefsKeys.accessToken)) {
                prefController.clearData();
              }
              Get.toNamed(AppRoutes.signIn);
            } else {
              controller.otpTextController.clear();
              controller.passController.clear();
              controller.confirmPassController.clear();
              controller.addressController.clear();
              controller.updateIsCountrySelectedStep3(true);
              controller.updateSelectedCountryIDStep3(0);
              Get.back();
            }
          }),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(16)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(
                () => SignUpWidgets.header(
                    showStepper: true,
                    activeStepNo: controller.activeStepNo,
                    totalStepsCount: 4,
                    selectedProfileType: controller.selectedProfileType,
                    onTapBusiness: controller.updateSelectedProfileType,
                    onTapIndividual: controller.updateSelectedProfileType),
              ),
              SizedBox(
                height: Dimensions.getHeight(36),
              ),
              Obx(
                () => SignUpWidgets.stepperBody(
                    onTapPassVisibility: controller.toggleIsPassVisible,
                    isPassVisible: controller.isPassVisible,
                    onTapConfirmPassVisibility:
                        controller.toggleIsConfirmPassVisible,
                    isConfirmPassVisible: controller.isConfirmPassVisible,
                    activeStepNo: controller.activeStepNo,
                    isOtpValid: controller.isOtpValid,
                    isOtpSent: controller.isOtpSent,
                    formKeyPassword: formKeyPassword,
                    countries: globalController.activeCountries,
                    isCountrySelected: controller.isCountrySelectedStep3,
                    email: controller.emailController.text,
                    passController: controller.passController,
                    confirmPassController: controller.confirmPassController,
                    addressController: controller.addressController,
                    otpTextController: controller.otpTextController,
                    stepper4TextEditingController:
                        controller.stepper4TextEditingControllers,
                    requiredDocumentTypes:
                        controller.documents?.requiredDocumentTypes,
                    onFinishCountDown: () {
                      controller.updateIsOtpSent(true);
                    },
                    onTapResendOtp: () {
                      context.showLoaderOverlay;
                      controller.memberRegistration().then((response) {
                        context.hideLoaderOverlay;
                        if (response.isSuccess) {
                          controller.updateIsOtpSent(false);
                        } else {
                          AppToasts.shortToast(response.message);
                        }
                      });
                    },
                    onChangeCountryStep3: (country) {
                      controller.updateSelectedCountryIDStep3(country?.id);
                    },
                    onTapVerifyOtp: () {
                      if (controller.otpTextController.text.length < 4) {
                        controller.otpNotValid();
                      } else {
                        controller.otpValid();

                        context.showLoaderOverlay;
                        controller.verifyOTP().then((response) {
                          context.hideLoaderOverlay;
                          if (response.isSuccess) {
                            controller.updateActiveStepNo(3);
                          } else {
                            AppToasts.shortToast(response.message);
                          }
                        });
                      }
                    },
                    onTapSavePass: () {
                      if (formKeyPassword.currentState!.validate()) {
                        context.showLoaderOverlay;
                        controller.createPassword().then((response) {
                          if (response.isSuccess) {
                            controller.updateActiveStepNo(4);
                            controller.fetchDocuments().then((response) {
                              context.hideLoaderOverlay;
                              if (!response.isSuccess) {
                                AppToasts.shortToast(response.message);
                              }
                            });
                          } else {
                            context.hideLoaderOverlay;
                            AppToasts.longToast(response.message);
                          }
                        });
                      }
                    },
                    onTapStoreDocument: () {
                      if (controller.selectedCountryIDStep3 == 0) {
                        AppToasts.shortToast(
                            'Where are you from selection is required');
                      } else if (controller.addressController.text.isEmpty) {
                        AppToasts.shortToast('Current location is required');
                      } else {
                        controller.updateIsCountrySelectedStep3(true);
                        context.showLoaderOverlay;
                        controller.storeDocument().then((response) {
                          context.hideLoaderOverlay;
                          if (response.isSuccess) {
                            Get.offAllNamed(AppRoutes.dashboard);
                          } else {
                            AppToasts.shortToast(response.message);
                          }
                        });
                      }
                    },
                    onUploadDocument: (imgPath, documentInfo) {
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
