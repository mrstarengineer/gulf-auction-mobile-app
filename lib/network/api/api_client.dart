import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:gulf_car_auction/helper/app_helper/app_helper.dart';
import 'package:gulf_car_auction/network/handler/handler.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String appBaseUrl;
  late String accessToken;
  late Map<String, String> _mainHeaders;
  late PreferenceController preferenceController;

  ApiClient({
    required this.appBaseUrl,
    required this.preferenceController,
  }) {
    _updateHeaders();
  }

  void _updateHeaders() {
    final accessToken = preferenceController.getString(PrefsKeys.accessToken);
    _mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': accessToken.isNotEmpty ? 'Bearer $accessToken' : '',
    };
  }

  void refreshHeaders() {
    _updateHeaders();
  }

  void updateHeader({String? token}) {
    _mainHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token ?? accessToken}',
    };
  }

  Future<http.Response> getRequest(String uri,
      {String? baseApiUrl, Map<String, String>? headers}) async {
    log('uri : ${(baseApiUrl ?? appBaseUrl) + uri}');
    log('response: get uri : ${preferenceController.getString(PrefsKeys.accessToken)}');
    try {
      final response = await http
          .get(
            Uri.parse((baseApiUrl ?? appBaseUrl) + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(const Duration(seconds: 30));
      log('response: get uri : ${(baseApiUrl ?? appBaseUrl) + uri}');
      ePrintWrapped(response.body.toString());
      return response;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
  }

  Future<http.Response> postRequest(String url,
      {String? baseApiUrl,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    try {
      log('Request: post body : ${(baseApiUrl ?? appBaseUrl) + url}');
      ePrintWrapped(body.toString());
      final response = await http
          .post(Uri.parse((baseApiUrl ?? appBaseUrl) + url),
              headers: headers ?? _mainHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 30));
      log('response: post uri : ${(baseApiUrl ?? appBaseUrl) + url}');
      ePrintWrapped(response.body.toString());
      return response;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
  }

  Future<http.Response> putRequest(String url,
      {String? baseApiUrl,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    try {
      log('uri : ${(baseApiUrl ?? appBaseUrl) + url}');
      ePrintWrapped(body.toString());
      final response = await http
          .put(Uri.parse((baseApiUrl ?? appBaseUrl) + url),
              headers: headers ?? _mainHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
  }

  Future<http.Response> patchRequest(String url,
      {String? baseApiUrl,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    try {
      final response = await http
          .patch(Uri.parse((baseApiUrl ?? appBaseUrl) + url),
              headers: headers ?? _mainHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
  }

  Future<http.Response> deleteRequest(String url,
      {String? baseApiUrl,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    try {
      final response = await http
          .delete(Uri.parse((baseApiUrl ?? appBaseUrl) + url),
              headers: headers ?? _mainHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
  }

  Future<http.Response> uploadDocument(String url,
      {String? baseApiUrl, required File file}) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse((baseApiUrl ?? appBaseUrl) + url))
        ..headers.addAll(_mainHeaders)
        ..files.add(http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ));

      final streamedResponse =
          await request.send().timeout(const Duration(seconds: 180));
      final response = await http.Response.fromStream(streamedResponse);
      return response;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
  }

  Future<http.Response> uploadPhoto(String url,
      {String? baseApiUrl, required File file}) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse((baseApiUrl ?? appBaseUrl) + url))
        ..headers.addAll(_mainHeaders)
        ..files.add(http.MultipartFile(
          'photo',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ));

      final streamedResponse =
          await request.send().timeout(const Duration(seconds: 180));
      final response = await http.Response.fromStream(streamedResponse);
      return response;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
  }
}
