import 'dart:convert';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/home/home.dart';
import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/network/handler/handler.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class HomeController extends GetxController {
  final HomeRepository _repo;

  HomeController({required HomeRepository repo}) : _repo = repo;

  final _selectedView = MSelectedView.grid.obs;

  MSelectedView get selectedView => _selectedView.value;

  set selectedView(value) => _selectedView.value = value;

  toggleView() {
    if (selectedView == MSelectedView.list) {
      selectedView = MSelectedView.grid;
    } else {
      selectedView = MSelectedView.list;
    }
  }

  final _selectedSort = MSortOptions.none.obs;

  MSortOptions get selectedSort => _selectedSort.value;

  set selectedSort(value) => _selectedSort.value = value;

  toggleSort() {
    if (selectedSort == MSortOptions.priceLowToHigh) {
      toggleSortingQueryParams();
      searchParamsAuctionVehicle +=
          '&order_by_column=start_bid_amount&order_by=DESC';
      selectedSort = MSortOptions.priceHighToLow;
    } else if (selectedSort == MSortOptions.priceHighToLow) {
      toggleSortingQueryParams();
      searchParamsAuctionVehicle +=
          '&order_by_column=start_bid_amount&order_by=ASC';
      selectedSort = MSortOptions.priceLowToHigh;
    } else if (selectedSort == MSortOptions.none) {
      toggleSortingQueryParams();
      searchParamsAuctionVehicle +=
          '&order_by_column=start_bid_amount&order_by=ASC';
      selectedSort = MSortOptions.priceLowToHigh;
    }
  }

  toggleSortingQueryParams() {
    List<String> keysToRemove = ['order_by_column', 'order_by'];
    List<String> searchParamsList = searchParamsAuctionVehicle.split('&');
    searchParamsList.removeWhere((param) {
      String key = param.split('=')[0]; // Extract the key part of the param
      return keysToRemove.contains(key); // Check if the key is in keysToRemove
    });
    searchParamsAuctionVehicle = searchParamsList.join('&');
  }

  final _isSearchFieldVisible = false.obs;

  bool get isSearchFieldVisible => _isSearchFieldVisible.value;

  set isSearchFieldVisible(value) => _isSearchFieldVisible.value = value;

  toggleIsSearchFieldVisible() => isSearchFieldVisible = !isSearchFieldVisible;

  final _isLoading = false.obs;
  final _selectedType = 'All'.obs;

  bool get isLoading => _isLoading.value;

  String get selectedType => _selectedType.value;

  set isLoading(value) => _isLoading.value = value;

  set selectedType(value) {
    _selectedType.value = value;
    fetchAuctionVehicles(loadingInitial: true);
  }

  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  final _isLoadingAuctionVehicle = false.obs;

  bool get isLoadingAuctionVehicle => _isLoadingAuctionVehicle.value;

  set isLoadingAuctionVehicle(value) => _isLoadingAuctionVehicle.value = value;

  // MODELS
  final Rxn<VehicleInfo> _topAuctionVehicles = Rxn<VehicleInfo>();

  VehicleInfo? get topAuctionVehicles => _topAuctionVehicles.value;

  set topAuctionVehicles(value) => _topAuctionVehicles.value = value;

  final Rxn<VehicleInfo> _buyNowVehicles = Rxn<VehicleInfo>();

  VehicleInfo? get buyNowVehicles => _buyNowVehicles.value;

  set buyNowVehicles(value) => _buyNowVehicles.value = value;

  final Rxn<MemberDashboardInfo> _memberDashboardInfo =
      Rxn<MemberDashboardInfo>();

  MemberDashboardInfo? get memberDashboardInfo => _memberDashboardInfo.value;

  set memberDashboardInfo(value) => _memberDashboardInfo.value = value;

  final Rxn<FilterVehicleData> _filterVehicleOptions = Rxn<FilterVehicleData>();

  FilterVehicleData? get filterVehicleOptions => _filterVehicleOptions.value;

  set filterVehicleOptions(value) => _filterVehicleOptions.value = value;

  final RxList<UpcomingAuctionInfo> upcomingAuctions =
      <UpcomingAuctionInfo>[].obs;

  //  API CALLS

  Future<ApiResponseModel> fetchMemberDashboard() async {
    try {
      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchMemberDashboard();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          memberDashboardInfo = MemberDashboardInfo.fromJson(responseBody);

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

  // AUCTION
  final _searchParamsAuctionVehicle = ''.obs;

  get searchParamsAuctionVehicle => _searchParamsAuctionVehicle.value;

  set searchParamsAuctionVehicle(value) =>
      _searchParamsAuctionVehicle.value = value;

  Future<ApiResponseModel> fetchAuctionVehicles(
      {String pageNo = '1',
      String limit = '6',
      bool loadingInitial = false,
      bool isLoadingMore = false,
      bool loadingAuctionVehicle = false,
      String? searchParams}) async {
    try {
      if (isLoadingMore) isLoading = true;
      if (loadingInitial) isLoadingInitial = true;
      if (loadingAuctionVehicle) isLoadingAuctionVehicle = true;

      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchAuctionVehicles(
          limit: limit,
          pageNo: pageNo,
          type: selectedType,
          searchParams: searchParams ?? searchParamsAuctionVehicle);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          if (pageNo == '1') {
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
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoading = false;
      isLoadingInitial = false;
      isLoadingAuctionVehicle = false;
    }
  }

  final _topAuctionVehiclesCurrentPageNo = '1'.obs;

  String get topAuctionVehiclesCurrentPageNo =>
      _topAuctionVehiclesCurrentPageNo.value;

  set topAuctionVehiclesCurrentPageNo(value) =>
      _topAuctionVehiclesCurrentPageNo.value = value;

  Future<void> fetchMoreAuctionVehicles() async {
    if (isLoading) return;
    if (int.parse(topAuctionVehiclesCurrentPageNo) ==
        topAuctionVehicles?.meta?.lastPage) return;

    int nextPage = int.parse(topAuctionVehiclesCurrentPageNo) + 1;
    topAuctionVehiclesCurrentPageNo = nextPage.toString();

    await fetchAuctionVehicles(
        pageNo: topAuctionVehiclesCurrentPageNo,
        isLoadingMore: true,
        searchParams: searchParamsAuctionVehicle);
  }

  Future<ApiResponseModel> fetchFilterVehicleOptions(
      {bool loadingInitial = false}) async {
    try {
      if (loadingInitial) isLoadingInitial = true;

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

  Future<ApiResponseModel> fetchUpcomingAuctions(
      {bool loadingInitial = false}) async {
    try {
      if (loadingInitial) isLoadingInitial = true;

      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchUpcomingAuctions();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          List upcomingAuctionsData = responseBody['data'];

          upcomingAuctions.assignAll(upcomingAuctionsData
              .map((data) => UpcomingAuctionInfo.fromJson(data))
              .toList());

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
}
