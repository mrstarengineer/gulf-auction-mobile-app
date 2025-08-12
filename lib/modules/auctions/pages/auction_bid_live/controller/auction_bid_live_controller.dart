// file: auction_bid_live_controller.dart

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_bid_live/auction_bid.dart';
import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/preference/preference.dart';

import '../../../../../helper/app_helper/app_helper.dart';
import '../../../../../models/auction/auction_view.dart';

class AuctionBidLiveController extends GetxController {
  final AuctionBidLiveRepository _repo;
  final PreferenceController _preferenceController;

  AuctionBidLiveController({
    required AuctionBidLiveRepository repo,
    required PreferenceController preferenceController,
  })  : _repo = repo,
        _preferenceController = preferenceController;

  final _auctionView = KAuctionView().obs;
  final _myBidAmount = 0.obs;
  final _reserveAmount = 0.obs;
  final _currentUserId = 0.obs;
  final _storedBidAmount = 0.obs;
  final _bidButtonEnable = true.obs;
  final _auctionMessage = ''.obs;
  final _mColor = AppColors.bidStartCLR.obs;
  final _mRadiusColor = AppColors.white.obs;
  var isBid = false;

  Timer? _countdownTimer;
  Timer? _upcomingVehiclesTimer;
  final _myDuration = const Duration(minutes: 0).obs;
  final _currentIndexCarousalSlider = 0.obs;

  // Getters for UI
  KAuctionView get auctionView => _auctionView.value;

  int get myBidAmount => _myBidAmount.value;

  int get reserveAmount => _reserveAmount.value;

  int get currentUserId => _currentUserId.value;

  int get storedBidAmount => _storedBidAmount.value;

  bool get bidButtonEnable => _bidButtonEnable.value;

  String get auctionMessage => _auctionMessage.value;

  Color get mColor => _mColor.value;

  Color get mRadiusColor => _mRadiusColor.value;

  Duration get myDuration => _myDuration.value;

  int get currentIndexCarousalSlider => _currentIndexCarousalSlider.value;

  // Setters for UI
  set myBidAmount(int value) => _myBidAmount.value = value;

  set storedBidAmount(int value) => _storedBidAmount.value = value;

  set bidButtonEnable(bool value) => _bidButtonEnable.value = value;

  set mColor(Color value) => _mColor.value = value;

  set mRadiusColor(Color value) => _mRadiusColor.value = value;

  set myDuration(Duration value) => _myDuration.value = value;

  set currentIndexCarousalSlider(int value) =>
      _currentIndexCarousalSlider.value = value;

  void updateCurrentIndexCarousalSlider(value) =>
      currentIndexCarousalSlider = value;

  void resetDuration(Duration value) => myDuration = value;

  @override
  void onClose() {
    _countdownTimer?.cancel();
    _upcomingVehiclesTimer?.cancel();
    super.onClose();
  }

  bool get isDecrementEnabled {
    final currentMinBid = auctionView.bidInfo?.minimumBidAmount ?? 0;
    if (myBidAmount - currentMinBid == auctionView.bidInfo?.bidIncrement) {
      return false;
    }
    return myBidAmount > currentMinBid;
  }

  // API CALLS
  Future<ApiResponseModel> joinAuction({int? auctionId}) async {
    //reset
    _auctionView.value = KAuctionView();
    resetDuration(const Duration(minutes: 0));
    update();

    try {
      var response = await _repo.joinAuction(auctionId: auctionId);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);
          _auctionView.value = KAuctionView.fromJson(responseBody);

          // Update initial state from API
          if (auctionView.auctionDetail != null) {
            _reserveAmount.value =
                auctionView.vehicleDetail?.reserveAmount ?? 0;
            _storedBidAmount.value = auctionView.bidDetail?.amount ??
                auctionView.vehicleDetail?.startBidAmount ??
                0;
            _currentUserId.value = auctionView.bidDetail?.userId ?? 0;

            // Set initial myBidAmount if available
            if (auctionView.bidInfo != null) {
              if (auctionView.bidInfo!.nextBidAmount ==
                  auctionView.vehicleDetail?.startBidAmount) {
                myBidAmount = (auctionView.bidInfo!.nextBidAmount ?? 0) +
                    (auctionView.bidInfo!.bidIncrement ?? 0);
              } else {
                myBidAmount = auctionView.bidInfo!.nextBidAmount ?? 0;
              }
            }

            // Start countdown timer
            if (auctionView.auctionDetail!.timeLeftSec != null &&
                auctionView.auctionDetail!.timeLeftSec! > 0) {
              myDuration =
                  Duration(seconds: auctionView.auctionDetail!.timeLeftSec!);
              startCountdownTimer();
            }

            // Start upcoming vehicles polling
            startUpcomingVehiclesPolling(auctionId!);

            _updateAuctionStatus(isGolden: auctionView.vehicleDetail?.isGolden);
          }
          return ApiResponseModel(isSuccess: true, message: '');
        },
      );
      return apiResponseHandler.handleResponse();
    } catch (error) {
      log(error.toString());
      return ApiResponseModel(
          isSuccess: false, message: 'Internal error has been occurred');
    }
  }

  Future<void> fetchUpcomingVehicles(int auctionId) async {
    try {
      var response = await _repo.upcomingVehicles(auctionId: auctionId);
      final apiResponseHandler =
          ApiResponseHandler(response, successCallback: (response) {
        var responseBody = json.decode(response.body);
        if (responseBody is Map<String, dynamic> && responseBody.isNotEmpty) {
          _auctionView.value.upcomingVehicles =
              KUpcomingVehicles.fromJson(responseBody['data']);
          update();
        }
        return ApiResponseModel(isSuccess: true, message: '');
      });
      apiResponseHandler.handleResponse();
    } catch (error) {
      log(error.toString());
    }
  }

  Future<ApiResponseModel> newBidAPI(BuildContext context,
      {bool? isBidForYou}) async {
    if (bidButtonEnable == true) {
      bidButtonEnable = false;
      if (myBidAmount > 0) {
        try {
          var response = await _repo.newBidAPIRepo(
            id: auctionView.auctionDetail?.id ?? 0,
            itemNumber: auctionView.vehicleDetail?.itemNumber,
            amount: isBidForYou == false
                ? myBidAmount
                : auctionView.bidInfo?.minimumBidAmount ?? 0,
          );

          final apiResponseHandler = ApiResponseHandler(
            response,
            successCallback: (response) {
              isBid = true;
              return ApiResponseModel(isSuccess: true, message: '');
            },
          );
          return apiResponseHandler.handleResponse();
        } catch (error) {
          ePrintWrapped(error.toString());
          return ApiResponseModel(
              isSuccess: false, message: 'Internal error has been occurred');
        } finally {
          bidButtonEnable = true;
          update();
        }
      } else {
        bidButtonEnable = true;
        return ApiResponseModel(
            isSuccess: false, message: 'Invalid bid amount');
      }
    } else {
      return ApiResponseModel(isSuccess: false, message: 'Bid is disabled');
    }
  }

  // Timers and helpers
  void startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => _setCountDown());
  }

  void _setCountDown() {
    final seconds = myDuration.inSeconds - 1;
    if (seconds < 0) {
      _countdownTimer?.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
  }

  void startUpcomingVehiclesPolling(int auctionId) {
    _upcomingVehiclesTimer?.cancel();
    _upcomingVehiclesTimer =
        Timer.periodic(const Duration(seconds: 40), (timer) {
      fetchUpcomingVehicles(auctionId);
    });
  }

  // Bid logic
  void calculateBidIncrement({required int bidIncrementValue}) {
    myBidAmount = myBidAmount + bidIncrementValue;
  }

  void calculateBidDecrement({required int bidIncrementValue}) {
    if (isDecrementEnabled) {
      myBidAmount = myBidAmount - bidIncrementValue;
    }
  }

  void nextItemLoad({required String currentItem}) {
    try {
      KVehicleDetail? nextVehicle =
          auctionView.upcomingVehicles?.upcomingVehicleDetailList?[currentItem];
      if (nextVehicle != null) {
        _auctionView.value.vehicleDetail = nextVehicle;
        _auctionView.value.upcomingVehicles!.upcomingVehicleDetailList!
            .remove(currentItem);

        // Update new vehicle details
        _reserveAmount.value = nextVehicle.reserveAmount ?? 0;
        _storedBidAmount.value = nextVehicle.startBidAmount ?? 0;
        _currentUserId.value = 0;

        _updateAuctionStatus(isGolden: nextVehicle.isGolden);
      }
    } catch (error) {
      log(error.toString());
    }
  }

  // Centralized Bid Status Logic
  void _updateAuctionStatus(
      {int? isGolden,
      bool isReserveChange = false,
      bool isClosedVehicle = false}) {
    final myId = _preferenceController.getInt(PrefsKeys.userId);

    // Default status
    _auctionMessage.value = 'VEHICLE ON APPROVAL';
    mColor = AppColors.bidStartCLR;
    mRadiusColor = AppColors.white;

    if (isGolden == 1) {
      if (isClosedVehicle) {
        auctionView.vehicleDetail?.isGolden = 1;
      }

      _auctionMessage.value = 'NEAR TO RESERVE';
    } else if (isGolden == 2 ||
        (_reserveAmount.value > 0 &&
            _storedBidAmount.value >= _reserveAmount.value)) {
      if (isGolden == 2) {
        if (isClosedVehicle) {
          auctionView.vehicleDetail?.isGolden = 2;
        }
        if (isReserveChange) {
          _auctionMessage.value = 'VEHICLE ON GREEN LIGHT';
          return;
        }
      }
      if (_currentUserId.value == myId) {
        mColor = AppColors.myBidCLR;
        _auctionMessage.value = 'YOU ARE WINNING';
      } else {
        _auctionMessage.value = 'VEHICLE ON GREEN LIGHT';
      }
    } else {
      auctionView.vehicleDetail?.isGolden = 0;
    }
  }

  // Called from PusherController to update state
  void updateStateFromPusherEvent(
      {required KPusherEventData eventData, BuildContext? context}) {
    // General Pusher event data updates
    if (eventData.reserveAmount != null) {
      _reserveAmount.value = eventData.reserveAmount!;
      _auctionView.value.vehicleDetail?.reserveAmount = eventData.reserveAmount;
    }

    if (eventData.bidDetail?.amount != null) {
      _storedBidAmount.value = eventData.bidDetail?.amount;
    }

    _currentUserId.value = eventData.bidDetail?.userId ?? 0;

    if (eventData.bidInfo != null) {
      _auctionView.value.bidInfo = eventData.bidInfo;
    }

    switch (eventData.event) {
      case 'READY_TO_BID':
        if (eventData.bidInfo != null) {
          _myBidAmount.value = eventData.bidInfo!.nextBidAmount ?? 0;
        }
        if (eventData.bidInfo?.currentItem != null &&
            eventData.bidInfo?.currentItem !=
                auctionView.vehicleDetail?.itemNumberStr) {
          nextItemLoad(currentItem: eventData.bidInfo!.currentItem!);
        }
        _updateAuctionStatus(isGolden: auctionView.vehicleDetail?.isGolden);
        break;

      case 'NEW_BID':
        if (eventData.bidInfo != null) {
          _myBidAmount.value = eventData.bidInfo!.nextBidAmount ?? myBidAmount;
        }
        _updateAuctionStatus(isGolden: auctionView.vehicleDetail?.isGolden);
        break;

      case 'CLOSER_VEHICLE':
        _updateAuctionStatus(
            isGolden: eventData.isGolden, isClosedVehicle: true);
        break;

      case 'CHANGE_RESERVE':
        _updateAuctionStatus(
            isGolden: auctionView.vehicleDetail?.isGolden,
            isReserveChange: true);
        break;

      default:
        // For other events like BONUS_TIME, BID_ENDED, AUCTION_BREAK, etc.,
        // we can handle specific logic here.
        break;
    }

    // We now have a consistent, single source of truth for UI changes.
    // Let's call `update()` for any `GetBuilder` or let `Obx` handle it.
  }
}
