import 'dart:convert';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';

import '../../../../../network/network.dart';
import '../auctions_list.dart';

class AuctionsListController extends GetxController {
  final AuctionsListRepository _repo;

  AuctionsListController({required AuctionsListRepository repo}) : _repo = repo;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading (value) => _isLoading.value = value;

  // MODELS
  final Rxn<AuctionListInfo> _auctionListInfo = Rxn<AuctionListInfo>();

  AuctionListInfo? get auctionListInfo => _auctionListInfo.value;

  set auctionListInfo(value) => _auctionListInfo.value = value;

  // API CALLS
  Future<ApiResponseModel> fetchFilterVehicleOptions () async{
    try {
      isLoading = true;
      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchAuctionDashboard();

      final apiResponseHandler = ApiResponseHandler(response, successCallback: (response) {
        var responseBody = json.decode(response.body);


        auctionListInfo = AuctionListInfo.fromJson(responseBody);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

        return apiResponseModel;
      });

      return apiResponseHandler.handleResponse();
    } catch (e){
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoading = false;
    }
  }
}