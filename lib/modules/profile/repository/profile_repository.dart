import 'dart:io';

import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> uploadProfilePhoto({required String filePath}) async {
    return await _apiClient.uploadPhoto(ApiEndpoints.uploadProfilePhoto,
        file: File(filePath));
  }

  Future<http.Response> updatePass(
      {String? oldPass, String? newPas, String? confirmPass}) async {
    return await _apiClient.postRequest(ApiEndpoints.changePass, body: {
      'old_password': oldPass,
      'password': newPas,
      'password_confirmation': confirmPass,
    });
  }

  Future<http.Response> deleteAccount() async {
    return await _apiClient.postRequest(ApiEndpoints.accountDeletion, body: {});
  }
}
