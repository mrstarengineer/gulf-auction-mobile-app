import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/modules/auth/pages/sign_up/sign_up.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../../../global/global.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBars.appBarSignUp(
        title: 'Member Registration',
        isHome: false,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(16)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // HEADER
                Obx(
                  () => SignUpWidgets.header(
                      selectedProfileType: controller.selectedProfileType,
                      onTapBusiness: controller.updateSelectedProfileType,
                      onTapIndividual: controller.updateSelectedProfileType),
                ),
                SizedBox(
                  height: Dimensions.getHeight(19),
                ),

                // BODY
                Obx(
                  () => SignUpWidgets.body(
                    companyController: controller.companyController,
                    trnController: controller.trnController,
                    ibanController: controller.ibanController,
                    fNameController: controller.fNameController,
                    lNameController: controller.lNameController,
                    emailController: controller.emailController,
                    numberController: controller.numberController,
                    selectedProfileType: controller.selectedProfileType,
                    onCountryChanged: controller.updateSelectedCountryCode,
                  ),
                ),
                SizedBox(
                  height: Dimensions.getHeight(16),
                ),

                // FOOTER
                Obx(() => SignUpWidgets.footer(
                      termsAndConditionsAgreed:
                          controller.termsAndConditionsAgreed,
                      onChangeTermsAndConditionsAgreed:
                          controller.updateTermsAndConditionsAgreed,
                      onTapTermsAndConditions: () {
                        Get.toNamed(AppRoutes.websPreview,
                            arguments: Environment.baseApiUrlV1 +
                                ApiEndpoints.termsAndConditions);
                      },
                      onTapPrivacyPolicy: () {
                        Get.toNamed(AppRoutes.websPreview,
                            arguments: Environment.baseApiUrlV1 +
                                ApiEndpoints.privacyPolicy);
                      },
                      onTapLogin: () => Get.back(),
                      onTapSignUp: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState!.validate()) {
                          if (!controller.termsAndConditionsAgreed) {
                            AppToasts.shortToast('termsAgreementWarningTxt'.tr);
                          } else {
                            context.showLoaderOverlay;
                            controller.memberRegistration().then((response) {
                              context.hideLoaderOverlay;
                              if (response.isSuccess) {
                                controller.updateActiveStepNo(2);
                                AppToasts.longToast(response.message);
                                Get.toNamed(AppRoutes.signUp +
                                    AppRoutes.signUpStepper);
                              } else {
                                AppToasts.shortToast(response.message);
                              }
                            });
                          }
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
