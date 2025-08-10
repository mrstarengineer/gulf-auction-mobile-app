import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/watched_vehicles/watched_vehicles.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../../../network/network.dart';

class WatchedVehiclesController extends GetxController {
  final WatchedVehiclesRepository _repo;

  WatchedVehiclesController({required WatchedVehiclesRepository repo}) : _repo = repo;


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
  final Rxn<VehicleInfo> _watchedVehicles = Rxn<VehicleInfo>();

  VehicleInfo? get watchedVehicles => _watchedVehicles.value;

  set watchedVehicles(value) => _watchedVehicles.value = value;

  // API CALLS

  Future<ApiResponseModel> fetchWatchedVehicle ({String pageNo = '1', String limit = '10', bool loadingInitial = false, bool loadingPagination = false, bool loadingAuctionVehicle = false}) async{
    try {
      if(loadingPagination) isLoadingPagination = true;
      if(loadingInitial) isLoadingInitial = true;

      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchWatchedVehicles(limit: limit, pageNo: pageNo);

      log('response: ${response.body}');

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {

        var responseBody = json.decode(response.body);

        if(pageNo == '1'){
          currentPageNo = '1';

          watchedVehicles = VehicleInfo.fromJson(responseBody);
        } else {
          List<dynamic> dataList = responseBody['data'];

          for (var dataMap in dataList) {
            watchedVehicles?.data?.add(VehicleData.fromJson(dataMap));
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

  final _currentPageNo = '1'.obs;

  String get currentPageNo => _currentPageNo.value;

  set currentPageNo (value) => _currentPageNo.value = value;

  Future<void> fetchMoreWatchedVehicle() async {
    if (isLoadingPagination) return;
    if (int.parse(currentPageNo) == watchedVehicles?.meta?.lastPage) return;

    int nextPage = int.parse(currentPageNo) + 1;
    currentPageNo = nextPage.toString();

    await fetchWatchedVehicle(pageNo: currentPageNo, loadingPagination: true);
  }

}