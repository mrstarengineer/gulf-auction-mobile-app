import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/extensions/extensions.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/auth/pages/sign_in/sign_in.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/utils/utils.dart';
import 'package:upgrader/upgrader.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = Get.find<SignInController>();
  final isFromGuestUser =
      bool.parse(Get.parameters['isFromGuestUser'] ?? 'false');

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
            AppDialogs.closingConfirmation(context,
                onTapBtn2: () => SystemNavigator.pop());
          },
          child: SafeArea(
            child: Stack(
              children: [
                // BG PARTICLE - TOP
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: SignInWidgets.bgParticle1(),
                ),

                // BG PARTICLE - BOTTOM
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SignInWidgets.bgParticle2(),
                ),

                // BODY & FOOTER
                SizedBox(
                  width: context.screenWidth,
                  height: context.screenHeight,
                  child: Obx(() => SingleChildScrollView(
                        child: Column(
                          children: [
                            //Body
                            SignInWidgets.body(
                              formKey: formKey,
                              emailController: controller.emailController,
                              passController: controller.passController,
                              isPassVisible: controller.isPassVisible,
                              onTapPassVisibility: controller.toggleIsPassVisible,
                              onTapForgetPass: () {
                                controller.emailController.clear();
                                AppBottomSheets.forgetPasswordSheet(
                                  formKey: controller.forgetPasswordFormKey,
                                  emailController: controller.emailController,
                                  onTapResetPassword: () async {
                                    if ((controller
                                            .forgetPasswordFormKey.currentState
                                            ?.validate() ??
                                        false)) {
                                      context.showLoaderOverlay;
                                      controller.resetPassword().then((response) {
                                        if (response.isSuccess) {
                                          Get.back();
                                          if (context.mounted) {
                                            context.hideLoaderOverlay;
                                          }
                                          AppToasts.longToast(response.message);
                                        } else {
                                          if (context.mounted) {
                                            context.hideLoaderOverlay;
                                          }
                                          AppToasts.shortToast(response.message);
                                        }
                                      });
                                    }
                                  },
                                );
                              },
                            ),

                            //Footer
                            SignInWidgets.footer(
                                onTapLogin: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (formKey.currentState!.validate()) {
                                    context.showLoaderOverlay;
                                    controller.signIn().then((response) {
                                      context.hideLoaderOverlay;
                                      if (response.isSuccess) {
                                        if (!isFromGuestUser) {
                                          Get.offAllNamed(AppRoutes.dashboard);
                                        } else {
                                          Get.back();
                                        }
                                      } else {
                                        AppToasts.shortToast(response.message);
                                      }
                                    });
                                  }
                                },
                                onTapReg: () => Get.toNamed(AppRoutes.signUp),
                                onTapGuest: () =>
                                    Get.offAllNamed(AppRoutes.dashboard)),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
