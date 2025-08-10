import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_bid_live/auction_bid.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/toasts/app_toasts.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../../models/models.dart';
import '../../../../../network/api/api.dart';
import '../../../../../network/handler/handler.dart';

class PusherController extends GetxController {
  final PusherChannelsFlutter _pusherChannels;
  final PreferenceController _preferenceController;
  final PusherRepository _repo;

  PusherController(
      {required PusherChannelsFlutter pusherChannels,
      required AudioPlayer audioPlayer,
      required PreferenceController preferenceController,
      required PusherRepository repo})
      : _pusherChannels = pusherChannels,
        _repo = repo,
        _preferenceController = preferenceController;

  final selectedAuctionId =
      int.parse(Get.parameters['selectedAuctionId'] ?? '0');

  var _canDisconnect = true;
  final _pusherEvent = PusherEventData().obs;
  final _myBidAmount = 0.obs;
  final _reserveAmount = 0.obs;
  final _currentUserId = 0.obs;
  final _storedBidAmount = 0.obs;
  final _isNotificationOn = true.obs;
  final _start = 0.obs;
  final _isBidderInfoShow = false.obs;
  final _bidButtonEnable = true.obs;
  var _isBid = false;
  AudioPlayer audioCache = AudioPlayer();
  var breakDialogOpen = false;
  final _auctionMessage = ''.obs;

  Timer? _timer;
  final _remainingTime = const Duration().obs;

  get remainingTime => _remainingTime.value;

  get isBid => _isBid;

  set isBid(value) {
    _isBid = value;
  }

  get bidButtonEnable => _bidButtonEnable.value;

  get auctionMessage => _auctionMessage.value;

  set auctionMessage(value) {
    _auctionMessage.value = value;
  }

  set bidButtonEnable(value) {
    _bidButtonEnable.value = value;
  }

  get isBidderInfoShow => _isBidderInfoShow.value;

  set isBidderInfoShow(value) {
    _isBidderInfoShow.value = value;
  }

  get start => _start.value;

  set start(value) {
    _start.value = value;
    update();
  }

  get isNotificationOn => _isNotificationOn.value;

  get reserveAmount => _reserveAmount.value;

  set reserveAmount(value) {
    _reserveAmount.value = value;
  }

  set currentUserId(value) {
    _currentUserId.value = value;
  }

  get currentUserId => _currentUserId.value;

  set isNotificationOn(value) {
    _isNotificationOn.value = value;
    update();
  }

  set resetIsNotificationOn(value) {
    _isNotificationOn.value = value;
  }

  get myBidAmount => _myBidAmount.value;

  set myBidAmount(value) {
    _myBidAmount.value = value;
  }

  get storedBidAmount => _storedBidAmount.value;

  set storedBidAmount(value) {
    _storedBidAmount.value = value;
  }

  PusherEventData get pusherEvent => _pusherEvent.value;

  set pusherEvent(value) {
    _pusherEvent.value = value;
    update();
  }

  get canDisconnect => _canDisconnect;

  set canDisconnect(value) {
    _canDisconnect = value;
  }

  void calculateBidIncrement({required int bidIncrementValue}) {
    myBidAmount = myBidAmount + bidIncrementValue;
    update();
  }

  void calculateBidDecrement({required int bidIncrementValue}) {
    if (pusherEvent.bidInfo!.minimumBidAmount! < myBidAmount) {
      myBidAmount = myBidAmount - bidIncrementValue;
      update();
    }
  }

  void resetPusherInfo() {
    _pusherEvent.value = PusherEventData();
    _isBidderInfoShow.value = false;
  }

  void resetOnDispose(BuildContext context) {
    _isBid = false;
    _isNotificationOn.value = true;
    onDisConnectAndUnsubscribeFromPusher(context);
    if (breakDialogOpen) {
      breakDialogOpen = false;
      _timer?.cancel();
    }
  }

  void onDisConnectAndUnsubscribeFromPusher(BuildContext context) async {
    if (canDisconnect == true) {
      try {
        await _pusherChannels.unsubscribe(
            channelName: '${Environment.pusherChannelName}.$selectedAuctionId');

        await _pusherChannels.disconnect();
        log(_pusherChannels.connectionState);
      } catch (error) {
        ePrintWrapped(error.toString());
      } finally {
        context.hideLoaderOverlay;
      }
    }
  }

  void onConnectToPusher(BuildContext context) async {
    try {
      await _pusherChannels.init(
        apiKey: Environment.pusherKey,
        cluster: Environment.pusherCluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: (event) => onEvent(context, event: event),
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onAuthorizer: (channelName, socketId, options) => onAuthorizer(
            context: context,
            channelName: channelName,
            socketId: socketId,
            options: options),
      );
      await _pusherChannels.subscribe(
          channelName: '${Environment.pusherChannelName}.$selectedAuctionId');
      await _pusherChannels.connect();
    } catch (error) {
      ePrintWrapped(error.toString());
    } finally {
      context.hideLoaderOverlay;
    }
  }

  void onEvent(BuildContext context, {required PusherEvent event}) async {
    AuctionBidLiveController auctionController =
        Get.find<AuctionBidLiveController>();
    PusherEventData containerData = _pusherEvent.value;
    _pusherEvent.value = PusherEventData();

    ePrintWrapped(event.data.toString());

    try {
      if (event.data.toString() != '{}') {
        PusherEventData? data =
            PusherEventData.fromJson(jsonDecode(event.data), containerData);
        pusherEvent = data;
        isBidderInfoShow = false;

        switch (pusherEvent.event ?? '') {
          case 'READY_TO_BID':
            if (pusherEvent.bidInfo != null &&
                pusherEvent.bidInfo!.currentItem != null) {
              storedBidAmount = pusherEvent.bidDetail!.amount;
              _isBid = false;
              if (auctionController.auctionView.itemNumberStr ==
                  pusherEvent.bidInfo!.currentItem!) {
              } else {
                Get.find<AuctionBidLiveController>().nextItemLoad(
                  context,
                  currentItem: pusherEvent.bidInfo!.currentItem!,
                );
              }
              //bid amount
              if (pusherEvent.bidInfo != null) {
                myBidAmount = pusherEvent.bidInfo!.nextBidAmount;
              }

              //color
              isGreenColor(isGreenLight: storedBidAmount >= reserveAmount);
              // auctionController.mColor = AppColors.bidStartCLR;
              // auctionController.mRadiusColor = AppColors.white;
              //Sound Start
              if (isNotificationOn == true) {
                playSound('StartItem');
                if (auctionController.auctionView.watched != null &&
                    auctionController.auctionView.watched == true) {
                  playSound('WatchItemNext');
                }
              }
            }
            break;

          case 'NEW_BID':
            if (pusherEvent.bidInfo != null &&
                pusherEvent.bidInfo!.nextBidAmount! > myBidAmount) {
              myBidAmount = pusherEvent.bidInfo!.nextBidAmount;
            }

            storedBidAmount = pusherEvent.bidDetail!.amount;
            _currentUserId.value = pusherEvent.bidDetail?.userId ?? 0;
            //Sound Start
            if (pusherEvent.bidDetail!.userId ==
                _preferenceController.getInt(PrefsKeys.userId)) {
              if (isNotificationOn == true) {
                playSound('MyBid');
              }
              // if (myBidAmount > 0 && _isBid == true) {
              //   auctionController.mColor = AppColors.myBidCLR;
              //   auctionController.mRadiusColor = AppColors.myBidCLR;
              // }
            } else {
              if (isNotificationOn == true) {
                playSound('OtherBid');
              }
              // if (myBidAmount > 0 && _isBid == true) {
              //   auctionController.mColor = AppColors.outbidCLR;
              //   auctionController.mRadiusColor = AppColors.outbidCLR;
              // }
            }

            isGreenColor(isGreenLight: storedBidAmount >= reserveAmount);

            break;

          case 'BONUS_TIME':
            //Sound bonus
            if (isNotificationOn == true) {
              playSound('BonusTime');
            }
            break;
          case 'BID_ENDED':
            //sold
            if (isNotificationOn == true) {
              if (pusherEvent.msg == 'Sold') {
                playSound('Sold');
              } else {
                playSound('SoldOnApproval');
                log('sound500 SoldOnApproval');
              }

              if (pusherEvent.winnerUserId != null &&
                  pusherEvent.winnerUserId ==
                      _preferenceController.getInt(PrefsKeys.userId)) {
                playSound('SoldWon');
              } else {
                // playSound('SoldLost');
              }
              if (pusherEvent.auctionFinished != null &&
                  pusherEvent.auctionFinished == true) {
                playSound('EndAuc');
              }
            }
            break;

          case 'AUCTION_BREAK':
            //break
            if (pusherEvent.type == 'ended') {
              if (breakDialogOpen) {
                breakDialogOpen = false;
                _timer?.cancel();
                Get.back();
              }
            } else if (pusherEvent.type == 'started') {
              breakDialogOpen = true;
              startTimer(breakEndedAt: pusherEvent.breakEndTime ?? '');
              breakTimeDialog(context);
            }

            break;

          case 'CLOSER_VEHICLE':
            if (pusherEvent.isGolden == 1) {
              auctionController.mColor = AppColors.outbidCLR;
              _auctionMessage.value = 'NEAR TO RESERVE';
              if (isNotificationOn == true) {
                playSound('near_to_reserve');
              }
            } else if (pusherEvent.isGolden == 2) {
              isGreenColor(isGreenLight: true);
              playSound('green_light');
            }

            break;
          case 'CHANGE_RESERVE':
            _reserveAmount.value = pusherEvent.reserveAmount ?? 0;

            break;
        }

        await Future.delayed(const Duration(seconds: 2), () {
          isBidderInfoShow = true;
          auctionController.mRadiusColor = AppColors.white;
          update();
        });
      }
    } catch (error) {
      ePrintWrapped(error.toString());
    } finally {
      context.hideLoaderOverlay;
    }
  }

  void startTimer({required String breakEndedAt}) {
    _timer?.cancel();
    _remainingTime.value = Duration.zero;
    if (breakEndedAt.isEmpty) {
      return;
    }
    DateTime endTime = DateTime.parse(breakEndedAt);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime.value = endTime.difference(DateTime.now());
      update();
    });

    if (_remainingTime.value.isNegative) {
      _timer?.cancel();
    }
  }

  String formatDuration(Duration duration) {
    if (duration.isNegative || duration.inSeconds == 0) {
      return "Resume in few minutes";
    }

    String hours = duration.inHours > 0 ? '${duration.inHours} Hour ' : '';
    String minutes = duration.inMinutes.remainder(60) > 0
        ? '${duration.inMinutes.remainder(60)} Minute '
        : '';
    String seconds = duration.inSeconds.remainder(60) > 0
        ? '${duration.inSeconds.remainder(60)} Seconds'
        : '';

    return "Resume in $hours$minutes$seconds";
  }

  void onError(String message, int? code, dynamic e) {
    log("Pusher onError: $message code: $code exception: $e");
  }

  dynamic onAuthorizer(
      {required BuildContext context,
      String? channelName,
      String? socketId,
      dynamic options}) async {
    return await pusherAuthenticateCtl(
        context: context, socketId: socketId, channelName: channelName);
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Pusher Connection Changed: $currentState");
  }

  Future<Map<String, dynamic>> pusherAuthenticateCtl(
      {required BuildContext context,
      String? socketId,
      String? channelName}) async {
    dynamic response;
    context.showLoaderOverlay;
    try {
      response = await _repo.pusherAuthenticateRepo(
          socketId: socketId, channelName: channelName);

      if (response != null) {
        context.hideLoaderOverlay;
        return json.decode(response.body);
      } else {
        AppToasts.longToast('Internal error has been occurred');
      }
    } catch (error) {
      ePrintWrapped(error.toString());
    } finally {
      context.hideLoaderOverlay;
    }
    context.hideLoaderOverlay;
    return json.decode(response.body);
  }

  Future<ApiResponseModel> newBidAPI(BuildContext context,
      {bool? isBidForYou}) async {
    if (bidButtonEnable == true) {
      bidButtonEnable = false;
      AuctionBidLiveController auctionController =
          Get.find<AuctionBidLiveController>();
      if (myBidAmount > 0) {
        try {
          late ApiResponseModel apiResponseModel;
          var response = await _repo.newBidAPIRepo(
            id: auctionController.containerAuctionView.auctionDetail?.id ?? 0,
            itemNumber: auctionController.auctionView.itemNumber,
            amount: isBidForYou == false
                ? myBidAmount
                : pusherEvent.bidInfo!.minimumBidAmount!,
          );

          final apiResponseHandler = ApiResponseHandler(
            response,
            successCallback: (response) {
              _isBid = true;

              apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

              return apiResponseModel;
            },
          );
          bidButtonEnable = true;
          update();
          return apiResponseHandler.handleResponse();
        } catch (error) {
          ePrintWrapped(error.toString());
          bidButtonEnable = true;
          update();
          return ApiResponseModel(
              isSuccess: false, message: 'Internal error has been occurred');
        }
      } else {
        return ApiResponseModel(
            isSuccess: false, message: 'Invalid bid amount');
      }
    } else {
      return ApiResponseModel(isSuccess: false, message: 'Bid is disabled');
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("pusher onSubscriptionSucceeded: $channelName data: $data");
    final me = _pusherChannels.getChannel(channelName)?.me;
    log("Pusher Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("Pusher onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("Pusher onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("Pusher onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("Pusher onMemberRemoved: $channelName user: $member");
  }

  void playSound(String soundName) {
    audioCache.play(AssetSource('sounds/$soundName.mp3'));
    // audioCache.dispose();
  }

  void breakTimeDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Align(
              alignment: Alignment.center, // Centers the dialog
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width *
                      0.8, // Set max width to 80% of screen width
                  maxHeight: MediaQuery.of(context).size.height *
                      0.6, // Set max height to 60% of screen height
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GetBuilder<PusherController>(builder: (controller) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        pusherEvent.breakTitle ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppTexts.smallText(
                        text: formatDuration(controller.remainingTime),
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
              ),
            ),
          );
        });
  }

  void isGreenColor({required bool isGreenLight}) {
    AuctionBidLiveController auctionController =
        Get.find<AuctionBidLiveController>();
    if (isGreenLight) {
      if (currentUserId == _preferenceController.getInt(PrefsKeys.userId)) {
        auctionController.mColor = AppColors.myBidCLR;
        _auctionMessage.value = 'YOU ARE WINNING';
      } else {
        auctionController.mColor = AppColors.bidStartCLR;
        _auctionMessage.value = 'VEHICLE ON GREEN LIGHT';
      }
    } else {
      auctionController.mColor = AppColors.bidStartCLR;
      _auctionMessage.value = 'VEHICLE ON APPROVAL';
    }
  }
}
