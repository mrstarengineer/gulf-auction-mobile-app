import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/all_vehicles/all_vehicles.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../../../network/network.dart';

class AllVehiclesController extends GetxController {
  final AllVehiclesRepository _repo;

  AllVehiclesController({required AllVehiclesRepository repo}) : _repo = repo;

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

  set selectedView (value) => _selectedView.value = value;

  toggleView() {
    if(selectedView == MSelectedView.list){
      selectedView = MSelectedView.grid;
    } else {
      selectedView = MSelectedView.list;
    }
  }

  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial (value) => _isLoadingInitial.value = value;

  final _isLoadingPagination = false.obs;

  bool get isLoadingPagination => _isLoadingPagination.value;

  set isLoadingPagination (value) => _isLoadingPagination.value = value;


  // MODELS
  final Rxn<VehicleInfo> _allVehicles = Rxn<VehicleInfo>();

  VehicleInfo? get allVehicles => _allVehicles.value;

  set allVehicles(value) => _allVehicles.value = value;

  final Rxn<FilterVehicleData> _filterVehicleOptions = Rxn<FilterVehicleData>();

  FilterVehicleData? get filterVehicleOptions => _filterVehicleOptions.value;

  set filterVehicleOptions(value) => _filterVehicleOptions.value = value;

  final Rxn<VehicleInfo> _topAuctionVehicles = Rxn<VehicleInfo>();

  VehicleInfo? get topAuctionVehicles => _topAuctionVehicles.value;

  set topAuctionVehicles(value) => _topAuctionVehicles.value = value;

  // API CALLS

  Future<ApiResponseModel> fetchFilterVehicleOptions () async{
    try {
      isLoadingInitial = true;
      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchFilterVehicleOptions();

      final apiResponseHandler = ApiResponseHandler(response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        filterVehicleOptions = FilterVehicleData.fromJson(responseBody);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

        return apiResponseModel;
      });

      return apiResponseHandler.handleResponse();
    } catch (e){
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingInitial = false;
    }
  }

  Future<ApiResponseModel> fetchAuctionVehicles ({String pageNo = '1', String limit = '10', int? auctionId, bool loadingInitial = false, bool loadingPagination = false, bool loadingAuctionVehicle = false, String? searchParams}) async{
    try {
      if(loadingPagination) isLoadingPagination = true;
      if(loadingInitial) isLoadingInitial = true;

      late ApiResponseModel apiResponseModel;

      var searchParam = 'auction_id=${auctionId ?? ''}&vehicle_global_search=${searchTextController.text.trim()}&${searchParams ?? ''}';

      final response = await _repo.fetchAuctionVehicles(limit: limit, pageNo: pageNo, searchParams: searchParam);

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {

        var responseBody = json.decode(response.body);

        if(pageNo == '1'){
          topAuctionVehiclesCurrentPageNo = '1';

          topAuctionVehicles = VehicleInfo.fromJson(responseBody);
        } else {
          List<dynamic> dataList = responseBody['data'];

          for (var dataMap in dataList) {
            topAuctionVehicles?.data?.add(VehicleData.fromJson(dataMap));
          }

        }

        apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

        return apiResponseModel;
      },
      );

      return apiResponseHandler.handleResponse();
    } catch (e){
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingPagination = false;
      isLoadingInitial = false;
    }
  }
  final _topAuctionVehiclesCurrentPageNo = '1'.obs;

  String get topAuctionVehiclesCurrentPageNo => _topAuctionVehiclesCurrentPageNo.value;

  set topAuctionVehiclesCurrentPageNo (value) => _topAuctionVehiclesCurrentPageNo.value = value;

  Future<void> fetchMoreAuctionVehicles({String? searchParams, int? auctionId}) async {
    if (isLoadingPagination) return;
    if (int.parse(topAuctionVehiclesCurrentPageNo) == topAuctionVehicles?.meta?.lastPage) return;

    int nextPage = int.parse(topAuctionVehiclesCurrentPageNo) + 1;
    topAuctionVehiclesCurrentPageNo = nextPage.toString();

    await fetchAuctionVehicles(pageNo: topAuctionVehiclesCurrentPageNo, loadingPagination: true, searchParams: searchParams, auctionId: auctionId);
  }

  Future<ApiResponseModel> searchVehicle ({String pageNo = '1', String limit = '6', String? searchParams, bool loadingInitial = false, bool loadingPagination = false}) async{
    try {
      if(loadingPagination) isLoadingPagination = true;
      if(loadingInitial) isLoadingInitial = true;

      var searchParam = 'vehicle_global_search=${searchTextController.text.trim()}&${searchParams ?? ''}';

      late ApiResponseModel apiResponseModel;
      final response = await _repo.searchVehicle(limit: limit, pageNo: pageNo, searchParams: searchParam);

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {

        var responseBody = json.decode(response.body);

        if(pageNo == '1'){
          allVehiclesCurrentPageNo = '1';

          allVehicles = VehicleInfo.fromJson(responseBody);

        } else {
          List<dynamic> dataList = responseBody['data'];

          for (var dataMap in dataList) {
            allVehicles?.data?.add(VehicleData.fromJson(dataMap));
          }

        }

        apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

        return apiResponseModel;
      },
      );

      return apiResponseHandler.handleResponse();
    } catch (e){
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingPagination = false;
      isLoadingInitial = false;
    }
  }

  final _allVehiclesCurrentPageNo = '1'.obs;

  String get allVehiclesCurrentPageNo => _allVehiclesCurrentPageNo.value;

  set allVehiclesCurrentPageNo (value) => _allVehiclesCurrentPageNo.value = value;

  Future<void> fetchMoreSearchVehicles({String? searchParams}) async {
    if (isLoadingPagination) return;
    if (int.parse(allVehiclesCurrentPageNo) == allVehicles?.meta?.lastPage) return;

    int nextPage = int.parse(allVehiclesCurrentPageNo) + 1;
    allVehiclesCurrentPageNo = nextPage.toString();

    await searchVehicle(pageNo: allVehiclesCurrentPageNo, loadingPagination: true, searchParams: searchParams);
  }
}