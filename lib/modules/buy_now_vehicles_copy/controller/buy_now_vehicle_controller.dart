import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';

import '../../../../../network/network.dart';
import '../../../../../settings/settings.dart';
import '../../dashboard/pages/all_vehicles/repository/all_vehicle_repository.dart';

class BuyNowVehicleController extends GetxController {
  final AllVehicleRepository _repo;

  BuyNowVehicleController({required AllVehicleRepository repo})
      : _repo = repo;

  late TextEditingController searchTextController;

  @override
  void onInit() {
    searchTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  final _selectedView = MSelectedView.list.obs;

  MSelectedView get selectedView => _selectedView.value;

  set selectedView(value) => _selectedView.value = value;

  toggleView() {
    if (selectedView == MSelectedView.list) {
      selectedView = MSelectedView.grid;
    } else {
      selectedView = MSelectedView.list;
    }
  }

  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  final _isLoadingPagination = false.obs;

  bool get isLoadingPagination => _isLoadingPagination.value;

  set isLoadingPagination(value) => _isLoadingPagination.value = value;

  // MODELS
  final Rxn<FilterVehicleData> _filterVehicleOptions = Rxn<FilterVehicleData>();

  FilterVehicleData? get filterVehicleOptions => _filterVehicleOptions.value;

  set filterVehicleOptions(value) => _filterVehicleOptions.value = value;

  final Rxn<VehicleInfo> _buyNowVehicles = Rxn<VehicleInfo>();

  VehicleInfo? get buyNowVehicles => _buyNowVehicles.value;

  set buyNowVehicles(value) => _buyNowVehicles.value = value;

  // API CALLS

  Future<ApiResponseModel> fetchFilterVehicleOptions(
      {bool showLoader = false}) async {
    try {
      if (showLoader) {
        isLoadingInitial = true;
      } else {
        if (buyNowVehicles == null) isLoadingInitial = true;
      }

      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchFilterVehicleOptions();

      final apiResponseHandler =
          ApiResponseHandler(response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        filterVehicleOptions = FilterVehicleData.fromJson(responseBody);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

        return apiResponseModel;
      });

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingInitial = false;
    }
  }

  Future<ApiResponseModel> fetchBuyNowVehicles(
      {String pageNo = '1',
      String limit = '10',
      bool loadingInitial = false,
      bool loadingPagination = false,
      String? searchParams,
      bool showLoader = false}) async {
    try {
      if (loadingPagination) isLoadingPagination = true;
      if (showLoader) {
        if (loadingInitial) isLoadingInitial = true;
      } else {
        if (buyNowVehicles == null) if (loadingInitial) isLoadingInitial = true;
      }

      late ApiResponseModel apiResponseModel;

      var searchParam =
          'vehicle_global_search=${searchTextController.text.trim()}&${searchParams ?? ''}';

      final response = await _repo.fetchAllVehicles(
          limit: limit, pageNo: pageNo, searchParams: searchParam);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          if (pageNo == '1') {
            buyNowVehiclesCurrentPageNo = '1';

            buyNowVehicles = VehicleInfo.fromJson(responseBody);
          } else {
            List<dynamic> dataList = responseBody['data'];

            for (var dataMap in dataList) {
              buyNowVehicles?.data?.add(VehicleData.fromJson(dataMap));
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

  final _buyNowVehiclesCurrentPageNo = '1'.obs;

  String get buyNowVehiclesCurrentPageNo => _buyNowVehiclesCurrentPageNo.value;

  set buyNowVehiclesCurrentPageNo(value) =>
      _buyNowVehiclesCurrentPageNo.value = value;

  Future<void> fetchMoreBuyNowVehicles(
      {String? searchParams, int? auctionId}) async {
    if (isLoadingPagination) return;
    if (int.parse(buyNowVehiclesCurrentPageNo) ==
        buyNowVehicles?.meta?.lastPage) {
      return;
    }

    int nextPage = int.parse(buyNowVehiclesCurrentPageNo) + 1;
    buyNowVehiclesCurrentPageNo = nextPage.toString();

    await fetchBuyNowVehicles(
        pageNo: buyNowVehiclesCurrentPageNo,
        loadingPagination: true,
        searchParams: searchParams);
  }
}
