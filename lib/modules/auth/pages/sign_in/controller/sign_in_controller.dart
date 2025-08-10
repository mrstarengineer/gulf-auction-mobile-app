import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/modules/auth/pages/sign_in/sign_in.dart';
import 'package:gulf_car_auction/routes/routes.dart';

import '../../../../../network/network.dart';

class SignInController extends GetxController {
  final SignInRepository _repo;

  SignInController({required SignInRepository repo}) : _repo = repo;

  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Text Editing Controller
  late TextEditingController emailController;
  late TextEditingController passController;

  @override
  void onInit() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }

  final _isPassVisible = false.obs;

  bool get isPassVisible => _isPassVisible.value;

  set isPassVisible(value) => _isPassVisible.value = value;

  toggleIsPassVisible() => isPassVisible = !isPassVisible;

  ///API CALLS

  Future<ApiResponseModel> signIn() async {
    try {
      late ApiResponseModel apiResponseModel;
      final response = await _repo.signIn(body: {
        "email": emailController.text.trim(),
        "password": passController.text.trim()
      });

      log('response: ${response.body}');

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          // Save Access Token & Update API CLIENT
          _repo.saveUserToken(token: responseBody['access_token']);

          // Check is documents required
          bool? isDocumentsRequired =
              responseBody['user']['required_documents'];

          if (isDocumentsRequired != null && isDocumentsRequired) {
            Get.toNamed(AppRoutes.signUp + AppRoutes.signUpStepper,
                parameters: {'isDocumentsRequired': 'true'});
            apiResponseModel = ApiResponseModel(
                isSuccess: false, message: 'Documents Required');
          } else {
            apiResponseModel =
                ApiResponseModel(isSuccess: true, message: 'welcomeTxt'.tr);
          }

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> resetPassword() async {
    try {
      late ApiResponseModel apiResponseModel;

      final response =
          await _repo.resetPassword(email: emailController.text.trim());

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          apiResponseModel = ApiResponseModel(
              isSuccess: true, message: responseBody['message']);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }
}
