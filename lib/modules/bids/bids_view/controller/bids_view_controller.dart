import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/bids/bids_view/bids_view.dart';
import 'package:gulf_car_auction/settings/enums/enums.dart';
import '../../../../../network/network.dart';

class BidsViewController extends GetxController {
  final BidsViewRepository _repo;

  BidsViewController({required BidsViewRepository repo}) : _repo = repo;

  late TextEditingController searchTextController;

  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  final _isLoadingPagination = false.obs;

  bool get isLoadingPagination => _isLoadingPagination.value;

  set isLoadingPagination(value) => _isLoadingPagination.value = value;

  //   MODELS
  final Rxn<BidListDetailsData> _bidDetailsInfo = Rxn<BidListDetailsData>();

  BidListDetailsData? get bidDetailsInfo => _bidDetailsInfo.value;

  set bidDetailsInfo(value) => _bidDetailsInfo.value = value;

  final Rxn<BidVehiclesInfo> _bidVehicles = Rxn<BidVehiclesInfo>();

  BidVehiclesInfo? get bidVehicles => _bidVehicles.value;

  set bidVehicles(value) => _bidVehicles.value = value;

  final _vehiclesCurrentPageNo = '1'.obs;

  String get vehiclesCurrentPageNo => _vehiclesCurrentPageNo.value;

  set vehiclesCurrentPageNo(value) => _vehiclesCurrentPageNo.value = value;

  @override
  void onInit() {
    super.onInit();
    searchTextController = TextEditingController();
    final initialSelection = dateFilterOptions.firstWhereOrNull(
      (option) => option.key == 'last_30_days',
    );
    selectedDateFilter = Rx<DateFilterOption?>(initialSelection);
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  Future<ApiResponseModel> fetchVehicles(
      {required MBidStatusOptions pageType,
      String pageNo = '1',
      String limit = '10',
      bool loadingInitial = false,
      bool loadingPagination = false}) async {
    var searchParam =
        'bid_global_search=${searchTextController.text.trim()}&date_range=${selectedDateFilter.value!.key}';

    try {
      if (loadingPagination) isLoadingPagination = true;
      if (loadingInitial) isLoadingInitial = true;

      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchVehicles(
        pageType: pageType,
        limit: limit,
        pageNo: pageNo,
        searchParam: searchParam,
      );

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          if (pageNo == '1') {
            vehiclesCurrentPageNo = '1';

            bidVehicles = BidVehiclesInfo.fromJson(responseBody);
          } else {
            List<dynamic> dataList = responseBody['data'];

            for (var dataMap in dataList) {
              bidVehicles?.data?.add(BidVehicleData.fromJson(dataMap));
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
    required MBidStatusOptions pageType,
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

  late Rx<DateFilterOption?> selectedDateFilter;
  MBidStatusOptions? selectedBidType;
  int selectedBidId = 0;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  final _currentIndexCarousalSlider = 0.obs;

  int get currentIndexCarousalSlider => _currentIndexCarousalSlider.value;

  set currentIndexCarousalSlider(value) =>
      _currentIndexCarousalSlider.value = value;

  updateCurrentIndexCarousalSlider(value) => currentIndexCarousalSlider = value;

  final List<DateFilterOption> dateFilterOptions = [
    DateFilterOption(displayString: 'Last 30 days', key: 'last_30_days'),
    DateFilterOption(displayString: 'Last 60 days', key: 'last_60_days'),
    DateFilterOption(displayString: 'Last 90 days', key: 'last_90_days'),
    DateFilterOption(displayString: 'Last 180 days', key: 'last_180_days'),
  ];

  Future<ApiResponseModel> fetchBidDetails() async {
    try {
      isLoading = true;
      late ApiResponseModel apiResponseModel;
      String apiEndPoint = '/';
      apiEndPoint = '/vehicles/$selectedBidId';

      final response = await _repo.fetchBidDetails(apiEndPoints: apiEndPoint);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          bidDetailsInfo = BidListDetailsData.fromJson(responseBody['data']);

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoading = false;
    }
  }
}
