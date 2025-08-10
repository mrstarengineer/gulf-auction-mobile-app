import 'dart:io';

import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class SignUpRepository {
  final ApiClient _apiClient;

  SignUpRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> memberRegistration(
      {required Map<String, dynamic> body}) async {
    return await _apiClient.postRequest(ApiEndpoints.memberRegistration,
        body: body);
  }

  Future<http.Response> verifyOTP({required Map<String, dynamic> body}) async {
    return await _apiClient.postRequest(ApiEndpoints.verifyOTP, body: body);
  }

  Future<http.Response> createPassword(
      {required Map<String, dynamic> body}) async {
    return await _apiClient.postRequest(ApiEndpoints.createPassword,
        body: body);
  }

  Future<http.Response> fetchDocuments() async {
    return await _apiClient.getRequest(ApiEndpoints.documents);
  }

  Future<http.Response> uploadDocument({required File file}) async {
    return await _apiClient.uploadDocument(ApiEndpoints.uploadDocument,
        file: file);
  }

  Future<http.Response> storeDocuments(
      {required List<Map<String, dynamic>> documentsJson,
      required String address,
      required int countryId}) async {
    return await _apiClient.postRequest(ApiEndpoints.storeDocument, body: {
      "address": address,
      "country_id": countryId,
      'documents': documentsJson
    });
  }
}
