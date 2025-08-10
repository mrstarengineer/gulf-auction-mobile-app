import 'dart:convert';
import 'package:get/get.dart';
import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/preference/controller/preference_controller.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/toasts/app_toasts.dart';
import 'package:http/http.dart' as http;

class ApiResponseHandler {
  final http.Response _response;
  final Function(http.Response) _successCallback;

  ApiResponseHandler(this._response, {Function(http.Response)? successCallback})
      : _successCallback = successCallback ?? _handleSuccess;

  Future<ApiResponseModel> handleResponse() async {
    late ApiResponseModel apiResponseModel;

    if (!await NetworkChecker.hasInternet) {
      apiResponseModel = _handleNetworkError();
    } else {
      switch (_response.statusCode) {
        case 200:
        case 201:
          apiResponseModel = _successCallback(_response);
          break;
        case 401:
          apiResponseModel = _handleUnauthenticatedError();
          break;
        case 400:
        case 403:
        case 404:
        case 422:
          apiResponseModel = _handleClientError(_response);
          break;
        case 500:
          apiResponseModel = _handleServerError();
          break;
        default:
          apiResponseModel = _handleUnknownError();
          break;
      }
    }

    return apiResponseModel;
  }

  static ApiResponseModel _handleSuccess(http.Response response) {
    var responseJson = json.decode(response.body);
    var msg = responseJson['message'];
    return ApiResponseModel(isSuccess: true, message: msg);
  }

  static ApiResponseModel _handleClientError(http.Response response) {
    late String errorMsg;
    switch (response.statusCode) {
      case 400:
        errorMsg = Strings.error400;
        break;
      case 403:
        errorMsg = Strings.error403;
        break;
      case 404:
        errorMsg = Strings.error404;
        break;
      case 422:
        errorMsg = Strings.error422;
        break;
      default:
        errorMsg = Strings.unknownError;
        break;
    }

  if (response.body.isNotEmpty) {
      var responseJson = json.decode(response.body);
  if (responseJson['errors'] != null) {
      // Check if there are errors and concatenate them
    var errors = responseJson['errors'] as Map<String, dynamic>;
    var errorMessages = errors.values.expand((value) => value).toList();
    if (errorMessages.isNotEmpty) {
      errorMsg = errorMessages.join(', ');
    }
    
  } else if(responseJson['message'] != null) {
  // Check if there's a general message
            errorMsg = responseJson['message'];
  }
      
    }
  

    return ApiResponseModel(isSuccess: false, message: errorMsg);
  }

  ApiResponseModel _handleUnauthenticatedError() {
    Get.find<PreferenceController>().clearData();
    AppToasts.shortToast(Strings.sessionExpired);
    Get.toNamed(AppRoutes.signIn);
    return ApiResponseModel(isSuccess: false, message: Strings.sessionExpired);
  }

  ApiResponseModel _handleServerError() {
    return ApiResponseModel(isSuccess: false, message: Strings.error500);
  }

  ApiResponseModel _handleNetworkError() {
    return ApiResponseModel(isSuccess: false, message: 'noInternetTxt'.tr);
  }

  ApiResponseModel _handleUnknownError() {
    return ApiResponseModel(isSuccess: false, message: 'unknownErrorTxt'.tr);
  }
}
