import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/sell_my_car/repository/sell_my_car_repository.dart';
import 'package:gulf_car_auction/network/api/api_response_model.dart';
import 'package:gulf_car_auction/network/handler/handler.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class SellMyCarController extends GetxController {
  final SellMyCarRepository _repo;

  SellMyCarController({required SellMyCarRepository repo}) : _repo = repo;

  late TextEditingController searchTextController;
  late TextEditingController counterOfferAmountController;
  late TextEditingController counterOfferNoteController;
  final GlobalKey<FormState> counterOfferFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    searchTextController = TextEditingController();
    counterOfferAmountController = TextEditingController();
    counterOfferNoteController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    counterOfferAmountController.dispose();
    counterOfferNoteController.dispose();
    super.onClose();
  }

  final _selectedOption = MyCarDetailsSelectedOptions.vehicleInfo.obs;

  MyCarDetailsSelectedOptions get selectedOption => _selectedOption.value;

  set selectedOption(value) => _selectedOption.value = value;

  updateSelectedOption(value) => selectedOption = value;

  final _currentIndexCarousalSlider = 0.obs;

  int get currentIndexCarousalSlider => _currentIndexCarousalSlider.value;

  set currentIndexCarousalSlider(value) =>
      _currentIndexCarousalSlider.value = value;

  updateCurrentIndexCarousalSlider(value) => currentIndexCarousalSlider = value;

  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  final _isLoadingPagination = false.obs;

  bool get isLoadingPagination => _isLoadingPagination.value;

  set isLoadingPagination(value) => _isLoadingPagination.value = value;

  // MODELS

  final Rxn<MyAllCarsInfo> _bidVehicles = Rxn<MyAllCarsInfo>();

  MyAllCarsInfo? get bidVehicles => _bidVehicles.value;

  set bidVehicles(value) => _bidVehicles.value = value;

  final Rxn<MyCarInfo> _singleVehicleInfo = Rxn<MyCarInfo>();

  MyCarInfo? get singleVehicleInfo => _singleVehicleInfo.value;

  set singleVehicleInfo(value) => _singleVehicleInfo.value = value;

  final _vehiclesCurrentPageNo = '1'.obs;

  String get vehiclesCurrentPageNo => _vehiclesCurrentPageNo.value;

  set vehiclesCurrentPageNo(value) => _vehiclesCurrentPageNo.value = value;

  Future<ApiResponseModel> fetchVehicles(
      {required MSellMyCarOptions pageType,
      String pageNo = '1',
      String limit = '10',
      bool loadingInitial = false,
      bool loadingPagination = false}) async {
    try {
      if (loadingPagination) isLoadingPagination = true;
      if (loadingInitial) isLoadingInitial = true;

      late ApiResponseModel apiResponseModel;

      var searchParam =
          'vehicle_global_search=${searchTextController.text.trim()}';

      final response = await _repo.fetchVehicles(
          pageType: pageType,
          limit: limit,
          pageNo: pageNo,
          searchParams: searchParam);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          if (pageNo == '1') {
            vehiclesCurrentPageNo = '1';

            bidVehicles = MyAllCarsInfo.fromJson(responseBody);
          } else {
            List<dynamic> dataList = responseBody['data'];

            for (var dataMap in dataList) {
              bidVehicles?.data?.add(MyAllCarsData.fromJson(dataMap));
            }
          }

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingPagination = false;
      isLoadingInitial = false;
    }
  }

  Future<void> fetchMoreVehicles({
    required MSellMyCarOptions pageType,
  }) async {
    if (isLoadingPagination) return;
    if (int.parse(vehiclesCurrentPageNo) == bidVehicles?.meta?.lastPage) return;

    int nextPage = int.parse(vehiclesCurrentPageNo) + 1;
    vehiclesCurrentPageNo = nextPage.toString();

    await fetchVehicles(
        pageType: pageType,
        pageNo: vehiclesCurrentPageNo,
        loadingPagination: true);
  }

  Future<ApiResponseModel> fetchSingleVehicle(
      {bool showLoader = true, int? vehicleId}) async {
    try {
      if (showLoader) isLoadingInitial = true;
      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchSingleVehicle(
        vehicleId: vehicleId,
      );

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          singleVehicleInfo = MyCarInfo.fromJson(responseBody['data']);

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingInitial = false;
    }
  }

  Future<ApiResponseModel> deleteVehicle({int? vehicleId}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.deleteVehicle(
        vehicleId: vehicleId,
      );

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

  Future<ApiResponseModel> counterOffer({int? vehicleId}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.counterOffer(
          vehicleId: vehicleId,
          counterAmount: int.parse(counterOfferAmountController.text),
          note: counterOfferNoteController.text,
          status: 0);

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

  Future<ApiResponseModel> acceptOffer({int? vehicleId}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response =
          await _repo.acceptOffer(vehicleId: vehicleId, status: 25);

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
