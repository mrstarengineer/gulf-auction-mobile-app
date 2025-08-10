import 'dart:convert';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/join_auction/join_auction.dart';

import '../../../../../network/network.dart';

class JoinAuctionController extends GetxController {
  final JoinAuctionRepository _repo;

  JoinAuctionController({required JoinAuctionRepository repo}) : _repo = repo;

  final _isLoading = false.obs;
  final _selectedAuctionType = 'Auction Live'.obs;

  bool get isLoading => _isLoading.value;

  String get selectedAuctionType => _selectedAuctionType.value;

  set isLoading(value) => _isLoading.value = value;

  set setSelectedAuctionType(value) => _selectedAuctionType.value = value;

  // MODELS
  final Rxn<AuctionListInfo> _auctionListInfo = Rxn<AuctionListInfo>();

  AuctionListInfo? get auctionListInfo => _auctionListInfo.value;

  set auctionListInfo(value) => _auctionListInfo.value = value;

  // API CALLS
  Future<ApiResponseModel> fetchAuctionsData({bool showLoader = false}) async {
    try {
      if (showLoader) {
        isLoading = true;
      } else {
        if (auctionListInfo == null) isLoading = true;
      }

      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchAuctionDashboard();

      final apiResponseHandler =
          ApiResponseHandler(response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        auctionListInfo = AuctionListInfo.fromJson(responseBody);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

        return apiResponseModel;
      });

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoading = false;
    }
  }
}
