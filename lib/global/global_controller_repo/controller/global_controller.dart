import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global_controller_repo/repository/global_repository.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../network/network.dart';

class GlobalController extends GetxController {
  final GlobalRepository _repo;

  GlobalController({required GlobalRepository repo}) : _repo = repo;

  @override
  void onInit() {
    fetchActiveCountries();
    super.onInit();
  }

  final _isLoadingInitial = false.obs;

  get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  // MODELS

  final Rxn<UserInfo> _userInfo = Rxn<UserInfo>();

  UserInfo? get userInfo => _userInfo.value;

  set userInfo(value) => _userInfo.value = value;

  final RxList<CountryInfo> activeCountries = <CountryInfo>[].obs;

  ///API CALLS

  Future<ApiResponseModel> fetchMe({bool isFromLogin = false}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchMe();

      final apiResponseHandler =
          ApiResponseHandler(response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        userInfo = UserInfo.fromJson(responseBody['data']);

        // Save User ID for Pusher;
        Get.find<PreferenceController>()
            .setInt(PrefsKeys.userId, value: userInfo?.id ?? 0);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

        return apiResponseModel;
      });

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> fetchActiveCountries() async {
    try {
      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchActiveCountries();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          List activeCountriesData = responseBody['data'];

          activeCountries.addAll(activeCountriesData
              .map((data) => CountryInfo.fromJson(data))
              .toList());

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> vehicleIsWatch(
      {int? vehicleId, bool isWatched = false}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.vehicleIsWatch(
          vehicleId: vehicleId, isWatched: isWatched);

      final apiResponseHandler =
          ApiResponseHandler(response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        apiResponseModel =
            ApiResponseModel(isSuccess: true, message: responseBody['message']);

        return apiResponseModel;
      });

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  // Open WhatsApp
  void openWhatsApp({required String number}) async {
    Uri url = Uri.parse("https://wa.me/$number");
    log('whatsapp url: $url');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
