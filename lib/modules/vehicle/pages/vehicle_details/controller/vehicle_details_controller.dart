import 'dart:convert';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/vehicle_details/vehicle_details.dart';
import 'package:gulf_car_auction/settings/enums/enums.dart';

import '../../../../../network/network.dart';

class VehicleDetailsController extends GetxController {
  VehicleDetailsRepository _repo;

  VehicleDetailsController(
      {required VehicleDetailsRepository repo})
      : _repo = repo;

  final _currentIndexCarousalSlider = 0.obs;

  int get currentIndexCarousalSlider => _currentIndexCarousalSlider.value;

  set currentIndexCarousalSlider (value) => _currentIndexCarousalSlider.value = value;

  updateCurrentIndexCarousalSlider (value) => currentIndexCarousalSlider = value;

  final _selectedOption = MVehicleDetailsSelectedOptions.bidInfo.obs;

  MVehicleDetailsSelectedOptions get selectedOption => _selectedOption.value;

  set selectedOption (value) => _selectedOption.value = value;

  updateSelectedOption (value) => selectedOption = value;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading (value) => _isLoading.value = value;

  // PRE BID AMOUNT SET
  final _preBidAmount = 0.obs;

  int get preBidAmount => _preBidAmount.value;

  set preBidAmount (value) => _preBidAmount.value = value;

  updatePreBidAmount({required int startBidAmount, required int currentBidAmount, bool isAdd = true, required int defaultPreBidIncrementAmount}) {
    if (isAdd) {
      // PLUS
      preBidAmount = preBidAmount + defaultPreBidIncrementAmount;
    } else {
      // MINUS
      if(currentBidAmount <= 0){
        if (!((preBidAmount - defaultPreBidIncrementAmount) <= startBidAmount)) {
          preBidAmount = preBidAmount - defaultPreBidIncrementAmount;
        }
      } else {
        if (!((preBidAmount - defaultPreBidIncrementAmount) <= currentBidAmount)) {
          preBidAmount = preBidAmount - defaultPreBidIncrementAmount;
        }
      }

    }
  }

  //   MODELS
  final Rxn<VehicleDetailsData> _lotDetailsInfo = Rxn<VehicleDetailsData>();

  VehicleDetailsData? get lotDetailsInfo => _lotDetailsInfo.value;

  set lotDetailsInfo(value) => _lotDetailsInfo.value = value;

    // API CALLS

  Future<ApiResponseModel> fetchLotDetails ({required String lotNo, required int defaultPreBidIncrementAmount}) async{
    try {
      isLoading= true;
      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchLotDetails(lotNo: lotNo);

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {

        var responseBody = json.decode(response.body);

        lotDetailsInfo = VehicleDetailsData.fromJson(responseBody['data']);

        lotDetailsInfo?.categoryId == 2 ? selectedOption = MVehicleDetailsSelectedOptions.vehicleInfo : MVehicleDetailsSelectedOptions.bidInfo;

        if(lotDetailsInfo?.currentBidAmount == null || (lotDetailsInfo?.currentBidAmount ?? 0) <= 0){
          preBidAmount = (lotDetailsInfo?.startBidAmount ?? 0) + defaultPreBidIncrementAmount;
        } else {
          preBidAmount = (lotDetailsInfo?.currentBidAmount ?? 0) + defaultPreBidIncrementAmount;
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
      isLoading = false;
    }
  }

  Future<ApiResponseModel> offlineBidByVehicle ({required String vehicleId}) async{
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.offlineBidByVehicle(vehicleId: vehicleId, body: {
        "type": "monster",
        // "start_amount" : ,
        "amount" : preBidAmount
      });

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {

        var responseBody = json.decode(response.body);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: responseBody['message']);

        return apiResponseModel;
      },
      );

      return apiResponseHandler.handleResponse();
    } catch (e){
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> buyNowVehicle ({required String vehicleId, }) async{
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.buyNowVehicle(vehicleId: vehicleId, body: {
        "price" : lotDetailsInfo?.sellingPrice
      });

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {

        var responseBody = json.decode(response.body);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: responseBody['message']);

        return apiResponseModel;
      },
      );

      return apiResponseHandler.handleResponse();
    } catch (e){
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }
}
