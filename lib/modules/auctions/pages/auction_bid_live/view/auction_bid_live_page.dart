import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/extensions/extensions.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_bid_live/auction_bid.dart';
import 'package:gulf_car_auction/settings/dimensions/dimensions.dart';
import 'package:gulf_car_auction/utils/toasts/app_toasts.dart';

import '../../../../../routes/routes.dart';
import '../../../../../settings/settings.dart';
import '../../../../../utils/utils.dart';
import '../../../../file_preview/view/gallery_preview_page.dart';

class AuctionBidLivePage extends StatefulWidget {
  const AuctionBidLivePage({super.key});

  @override
  State<AuctionBidLivePage> createState() => _AuctionBidLivePageState();
}

class _AuctionBidLivePageState extends State<AuctionBidLivePage> {
  late CarouselSliderController _carouselController;
  final _auctionBidLiveController = Get.find<AuctionBidLiveController>();
  final _pusherController = Get.find<PusherController>();
  final _selectedAuctionId =
      int.parse(Get.parameters['selectedAuctionId'] ?? '0');

  @override
  void initState() {
    _carouselController = CarouselSliderController();
    // mPusherController.resetPusherInfo();
    _auctionBidLiveController.resetDuration = const Duration(minutes: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pusherController.onConnectToPusher(context);
      _auctionBidLiveController.joinAuction(auctionId: _selectedAuctionId);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pusherController.resetOnDispose(context);
    // _pusherController.resetAuctionInDispose();
  }

  @override
  void deactivate() {
    _pusherController.onDisConnectAndUnsubscribeFromPusher(context);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        AppDialogs.closingConfirmation(context, title: 'Leave Auction?',
            onTapBtn2: () {
          Get.back();
          Get.back();
        });
      },
      child: Obx(() {
        return Scaffold(
          appBar: AppBars.appBarWithAction(
            isConfirmationRequired: true,
            action: AppButtons.iconButton(
              onTap: () => _pusherController.isNotificationOn =
                  !_pusherController.isNotificationOn,
              icon: _pusherController.isNotificationOn
                  ? Icons.notifications_on_rounded
                  : Icons.notifications_off_rounded,
            ),
            title: _auctionBidLiveController
                    .containerAuctionView.auctionDetail?.title ??
                '',
            onTapBack: () {
              AppDialogs.closingConfirmation(context, title: 'Leave Auction?',
                  onTapBtn2: () {
                Get.back();
                Get.back();
              });
            },
          ),
          body: _auctionBidLiveController.containerAuctionView.bidInfo == null
              ? const SizedBox.shrink()
              : (_pusherController.pusherEvent.auctionFinished ?? false)
                  ? AuctionBidLiveWidgets.auctionEndedBody(
                      title: _auctionBidLiveController
                              .containerAuctionView.auctionDetail?.title ??
                          '',
                    )
                  : Column(
                      children: [
                        AuctionBidLiveWidgets.header(
                            photoTap: (selectedIndex) {
                              Get.to(() => FilesGalleryPreviewPage(
                                  vehicleList: _auctionBidLiveController
                                          .auctionView.vehicleImages ??
                                      [],
                                  selectedIndex: selectedIndex));

                              // final extension = getFileExtension(url);
                              // if (extension == 'jpg' ||
                              //     extension == 'png' ||
                              //     extension == 'pdf') {
                              //   Get.toNamed(AppRoutes.filesPreview,
                              //       arguments: url);
                              // } else {
                              //   AppToasts.shortToast(
                              //       Strings.unsupportedFileFormat);
                              // }
                            },
                            images: _auctionBidLiveController
                                    .auctionView.vehicleImages ??
                                [],
                            carouselController: _carouselController,
                            currentIndexCarousalSlider:
                                _auctionBidLiveController
                                    .currentIndexCarousalSlider,
                            onPageChanged: _auctionBidLiveController
                                .updateCurrentIndexCarousalSlider),
                        SizedBox(
                          height: Dimensions.getHeight(12),
                        ),
                        Expanded(
                            child: AuctionBidLiveWidgets.body(
                                eligibleForBidding: _auctionBidLiveController
                                        .auctionView.eligibleForBidding ??
                                    true,
                                isBidInfoShow:
                                    _pusherController.pusherEvent.event != null ||
                                        _pusherController.isBidderInfoShow,
                                minimumBidAmount: _auctionBidLiveController
                                    .auctionView.currentBidAmount,
                                currentBidAmount:
                                    '${_pusherController.pusherEvent.bidDetail?.amount ?? _pusherController.storedBidAmount}',
                                nextBidAmount: (_pusherController.myBidAmount == 0
                                    ? _auctionBidLiveController
                                        .containerAuctionView
                                        .bidInfo
                                        ?.nextBidAmount
                                    : _pusherController.myBidAmount ?? 0),
                                upcomingVehicle: _auctionBidLiveController
                                    .containerAuctionView
                                    .upcomingVehicles
                                    ?.upcomingVehicleDetailList
                                    ?.values,
                                bidBgColor: _auctionBidLiveController.mColor,
                                auctionMessage:
                                    _pusherController.auctionMessage,
                                participants: _pusherController
                                    .pusherEvent.totalParticipants,
                                carName:
                                    '${_auctionBidLiveController.auctionView.year ?? ''} ${_auctionBidLiveController.auctionView.make ?? ''} ${_auctionBidLiveController.auctionView.model ?? ''}',
                                vin: _auctionBidLiveController.auctionView.vin,
                                sequence: _auctionBidLiveController
                                    .auctionView.serial,
                                driveTrain:
                                    _auctionBidLiveController.auctionView.drive,
                                odometer: '${_auctionBidLiveController
                                    .auctionView.odometer??0} ${_auctionBidLiveController
                                    .auctionView.odometerType}',
                                bodyStyle: _auctionBidLiveController.auctionView.bodyStyle,
                                color: _auctionBidLiveController.auctionView.color,
                                primaryDamage: _auctionBidLiveController.auctionView.primaryDamage,
                                engineType: _auctionBidLiveController.auctionView.engineType,
                                documentType: _auctionBidLiveController.auctionView.documentType,
                                // secondaryDamage: _auctionBidLiveController.auctionView.secondaryDamage,
                                // cylinder: _auctionBidLiveController.auctionView.cylinder,
                                onTapBidIncrement: () => _pusherController.calculateBidIncrement(bidIncrementValue: _auctionBidLiveController.containerAuctionView.bidInfo?.bidIncrement ?? 0),
                                onTapBidDecrement: () => _pusherController.calculateBidDecrement(bidIncrementValue: _auctionBidLiveController.containerAuctionView.bidInfo?.bidIncrement ?? 0),
                                isBidBtnEnabled: _pusherController.bidButtonEnable,
                                onTapBid: () {
                                  context.showLoaderOverlay;
                                  _pusherController
                                      .newBidAPI(context, isBidForYou: false)
                                      .then((response) {
                                    context.hideLoaderOverlay;
                                    if (!response.isSuccess) {
                                      AppToasts.shortToast(response.message);
                                    }
                                  });
                                })),
                      ],
                    ),
        );
      }),
    );
  }
}
