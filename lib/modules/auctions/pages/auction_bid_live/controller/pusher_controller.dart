// file: pusher_controller.dart

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_bid_live/auction_bid.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/utils/toasts/app_toasts.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../../models/models.dart';

class PusherController extends GetxController {
  final PusherChannelsFlutter _pusherChannels;
  final PusherRepository _repo;
  final PreferenceController _preferenceController;
  final AudioPlayer _audioPlayer;

  PusherController({
    required PusherChannelsFlutter pusherChannels,
    required PusherRepository repo,
    required PreferenceController preferenceController,
    required AudioPlayer audioPlayer,
  })  : _pusherChannels = pusherChannels,
        _repo = repo,
        _preferenceController = preferenceController,
        _audioPlayer = audioPlayer;

  final selectedAuctionId =
      int.parse(Get.parameters['selectedAuctionId'] ?? '0');

  final _canDisconnect = true;
  var _breakDialogOpen = false;
  final _pusherEvent = KPusherEventData().obs;
  final _isNotificationOn = true.obs;
  final _remainingTime = const Duration().obs;

  // Getters for UI
  bool get isNotificationOn => _isNotificationOn.value;

  Duration get remainingTime => _remainingTime.value;

  KPusherEventData get pusherEvent => _pusherEvent.value;

  // Setters for UI
  set isNotificationOn(bool value) => _isNotificationOn.value = value;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    resetPusherInfo();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.onClose();
  }

  void resetPusherInfo() {
    _pusherEvent.value = KPusherEventData();
  }

  void resetOnDispose(BuildContext context) {
    onDisConnectAndUnsubscribeFromPusher(context);
    if (_breakDialogOpen) {
      _breakDialogOpen = false;
      _timer?.cancel();
    }
  }

  void onDisConnectAndUnsubscribeFromPusher(BuildContext context) async {
    if (_canDisconnect) {
      try {
        await _pusherChannels.unsubscribe(
            channelName: '${Environment.pusherChannelName}.$selectedAuctionId');
        await _pusherChannels.disconnect();
      } catch (error) {
        ePrintWrapped(error.toString());
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
    try {
      if (event.data.toString() != '{}') {
        final auctionController = Get.find<AuctionBidLiveController>();
        ePrintWrapped(event.toString());
        final eventData = KPusherEventData.fromJson(
            jsonDecode(event.data), _pusherEvent.value);
        _pusherEvent.value = eventData;

        // Pass the event data to the main controller for state update
        auctionController.updateStateFromPusherEvent(eventData: eventData);

        // Handle sound and dialogs
        _handlePusherEvents(eventData, context);
      }
    } catch (error) {
      ePrintWrapped(error.toString());
    } finally {
      context.hideLoaderOverlay;
    }
  }

  void _handlePusherEvents(KPusherEventData eventData, BuildContext context) {
    if (_isNotificationOn.value) {
      switch (eventData.event ?? '') {
        case 'READY_TO_BID':
          playSound('StartItem');
          // Add logic to check for 'watched' item sound here if needed.
          break;
        case 'NEW_BID':
          if (eventData.bidDetail?.userId ==
              _preferenceController.getInt(PrefsKeys.userId)) {
            playSound('MyBid');
          } else {
            playSound('OtherBid');
          }
          break;
        case 'BONUS_TIME':
          playSound('BonusTime');
          break;
        case 'BID_ENDED':
          if (eventData.msg == 'Sold') {
            playSound('Sold');
          } else {
            playSound('SoldOnApproval');
          }
          if (eventData.winnerUserId ==
              _preferenceController.getInt(PrefsKeys.userId)) {
            playSound('SoldWon');
          }
          if (eventData.auctionFinished == true) {
            playSound('EndAuc');
          }
          break;
        case 'AUCTION_BREAK':
          if (eventData.type == 'ended' && _breakDialogOpen) {
            _breakDialogOpen = false;
            _timer?.cancel();
            Get.back();
          } else if (eventData.type == 'started') {
            _breakDialogOpen = true;
            startTimer(breakEndedAt: eventData.breakEndTime ?? '');
            breakTimeDialog(context);
          }
          break;
        case 'CLOSER_VEHICLE':
          if (eventData.isGolden == 1) {
            playSound('near_to_reserve');
          } else if (eventData.isGolden == 2) {
            playSound('green_light');
          }
          break;
      }
    }
  }

  // Pusher callbacks and other methods...
  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Pusher Connection Changed: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("Pusher onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("pusher onSubscriptionSucceeded: $channelName data: $data");
    final me = _pusherChannels.getChannel(channelName)?.me;
    log("Pusher Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("Pusher onSubscriptionError: $message Exception: $e");
  }

  Future<Map<String, dynamic>> onAuthorizer({
    required BuildContext context,
    String? channelName,
    String? socketId,
    dynamic options,
  }) async {
    return await pusherAuthenticateCtl(
        context: context, socketId: socketId, channelName: channelName);
  }

  Future<Map<String, dynamic>> pusherAuthenticateCtl({
    required BuildContext context,
    String? socketId,
    String? channelName,
  }) async {
    dynamic response;
    context.showLoaderOverlay;
    try {
      response = await _repo.pusherAuthenticateRepo(
          socketId: socketId, channelName: channelName);
      if (response != null && response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        AppToasts.longToast('Internal error has been occurred');
      }
    } catch (error) {
      ePrintWrapped(error.toString());
    } finally {
      context.hideLoaderOverlay;
    }
    return {};
  }

  void playSound(String soundName) {
    _audioPlayer.play(AssetSource('sounds/$soundName.mp3'));
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
      if (_remainingTime.value.isNegative) {
        _timer?.cancel();
        _remainingTime.value = Duration.zero;
      }
    });
  }

  String formatDuration(Duration duration) {
    if (duration.isNegative || duration.inSeconds == 0) {
      return "Resume in a few minutes";
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

  void breakTimeDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
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
                    Text(formatDuration(remainingTime),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
