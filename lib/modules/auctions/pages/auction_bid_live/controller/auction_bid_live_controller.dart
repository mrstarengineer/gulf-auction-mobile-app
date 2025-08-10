import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_bid_live/auction_bid.dart';
import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../../../models/models.dart';

class AuctionBidLiveController extends GetxController {
  final AuctionBidLiveRepository _repo;

  AuctionBidLiveController({required AuctionBidLiveRepository repo})
      : _repo = repo;

  final _currentIndexCarousalSlider = 0.obs;

  int get currentIndexCarousalSlider => _currentIndexCarousalSlider.value;

  set currentIndexCarousalSlider(value) =>
      _currentIndexCarousalSlider.value = value;

  updateCurrentIndexCarousalSlider(value) => currentIndexCarousalSlider = value;

  final _myDuration = const Duration(minutes: 0).obs;

  Duration get myDuration => _myDuration.value;

  set myDuration(value) {
    _myDuration.value = value;
    update();
  }

  set resetDuration(value) {
    _myDuration.value = value;
  }

  final _mColor = AppColors.bidStartCLR.obs;

  get mColor => _mColor.value;

  set mColor(value) {
    _mColor.value = value;
    update();
  }

  final _mRadiusColor = AppColors.white.obs;

  get mRadiusColor => _mRadiusColor.value;

  set mRadiusColor(value) {
    _mRadiusColor.value = value;
  }

  void nextItemLoad(BuildContext context, {required String currentItem}) {
    try {
      auctionView = containerAuctionView.upcomingVehicles!
          .upcomingVehicleDetailList![currentItem] as VehicleDetail;

      containerAuctionView.upcomingVehicles!.upcomingVehicleDetailList!
          .remove(currentItem);

      update();
    } catch (error) {
      log(error.toString());
    } finally {
      context.hideLoaderOverlay;
    }
  }

  // MODELS
  final _auctionView = VehicleDetail().obs;
  final _containerAuctionView = AuctionView().obs;

  VehicleDetail get auctionView => _auctionView.value;

  AuctionView get containerAuctionView => _containerAuctionView.value;

  set containerAuctionView(value) {
    _containerAuctionView.value = value;
  }

  set auctionView(value) {
    _auctionView.value = value;
  }

  // API CALLS

  Future<ApiResponseModel> joinAuction({int? auctionId}) async {
    PusherController pusherController = Get.find<PusherController>();
    //reset
    auctionView = VehicleDetail();
    containerAuctionView = AuctionView();
    update();

    try {
      late ApiResponseModel apiResponseModel;
      var response = await _repo.joinAuction(auctionId: auctionId);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          AuctionView mAuctionView = AuctionView.fromJson(responseBody);
          if (mAuctionView.auctionDetail != null) {
            if (mAuctionView.auctionDetail?.status == 7) {
              pusherController.isBidderInfoShow = true;
            }
            pusherController.reserveAmount =
                mAuctionView.vehicleDetail?.reserveAmount ?? 0;
            pusherController.storedBidAmount =
                mAuctionView.bidDetail?.amount ?? 0;
            pusherController.currentUserId =
                mAuctionView.bidDetail?.userId ?? 0;
            containerAuctionView = mAuctionView;
            auctionView = mAuctionView.vehicleDetail;

            if (mAuctionView.auctionDetail != null &&
                mAuctionView.auctionDetail!.timeLeftSec != null &&
                mAuctionView.auctionDetail!.timeLeftSec! > 0) {
              resetDuration =
                  Duration(seconds: mAuctionView.auctionDetail!.timeLeftSec!);
              calculateCountDown();
            }

            if (mAuctionView.vehicleDetail?.isGolden == 1 ||
                mAuctionView.vehicleDetail?.isGolden == 2) {
              if (mAuctionView.vehicleDetail?.isGolden == 1) {
                mColor = AppColors.outbidCLR;
                pusherController.auctionMessage = 'NEAR TO RESERVE';
              } else if (mAuctionView.vehicleDetail?.isGolden == 2) {
                pusherController.isGreenColor(isGreenLight: true);
              }
            } else {
              pusherController.isGreenColor(
                  isGreenLight: pusherController.storedBidAmount >=
                      pusherController.reserveAmount);
            }
          }

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (error) {
      log(error.toString());
      return ApiResponseModel(
          isSuccess: false, message: 'Internal error has been occurred');
    }
  }

  Timer? countdownTimer;

  void calculateCountDown() {
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    countdownTimer!.cancel();
  }

  void setCountDown() {
    final seconds = myDuration.inSeconds - 1;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    update();
  }
}
