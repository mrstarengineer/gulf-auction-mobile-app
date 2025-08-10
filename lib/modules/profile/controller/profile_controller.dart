import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/modules/profile/profile.dart';

import '../../../network/network.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repo;

  ProfileController({required ProfileRepository repo}) : _repo = repo;

  late TextEditingController oldPassController;
  late TextEditingController newPassController;
  late TextEditingController confirmPassController;
  final Rx<bool> _isDeleteConfirmed = false.obs;

  @override
  void onInit() {
    oldPassController = TextEditingController();
    newPassController = TextEditingController();
    confirmPassController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    oldPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }

  bool get isDeleteConfirmed => _isDeleteConfirmed.value;

  set isDeleteConfirmed(value) {
    _isDeleteConfirmed.value = value;
    update();
  }

  set deleteConfirmed(value) {
    _isDeleteConfirmed.value = value;
  }

  Future<ApiResponseModel> uploadProfilePhoto({required String imgPath}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.uploadProfilePhoto(filePath: imgPath);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          var fileUrl = responseBody['profile_photo'];

          apiResponseModel =
              ApiResponseModel(isSuccess: true, message: fileUrl);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> updatePass() async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.updatePass(
        oldPass: oldPassController.text.trim(),
        newPas: newPassController.text.trim(),
        confirmPass: confirmPassController.text.trim(),
      );

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          var message = responseBody['message'];

          apiResponseModel =
              ApiResponseModel(isSuccess: true, message: message);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> accountDeletion() async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.deleteAccount();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          var message = responseBody['message'];

          apiResponseModel =
              ApiResponseModel(isSuccess: true, message: message);

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
