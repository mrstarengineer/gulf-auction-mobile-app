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
    super.initState();
    _carouselController = CarouselSliderController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pusherController.onConnectToPusher(context);
      _auctionBidLiveController.joinAuction(auctionId: _selectedAuctionId);
    });
  }

  @override
  void dispose() {
    _pusherController.resetOnDispose(context);
    _auctionBidLiveController.onClose();
    _pusherController.onClose();
    super.dispose();
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
      child: Scaffold(
        appBar: AppBars.appBarWithAction(
          isConfirmationRequired: true,
          action: Obx(() => AppButtons.iconButton(
                onTap: () => _pusherController.isNotificationOn =
                    !_pusherController.isNotificationOn,
                icon: _pusherController.isNotificationOn
                    ? Icons.notifications_on_rounded
                    : Icons.notifications_off_rounded,
              )),
          title:
              _auctionBidLiveController.auctionView.auctionDetail?.title ?? '',
          onTapBack: () {
            AppDialogs.closingConfirmation(context, title: 'Leave Auction?',
                onTapBtn2: () {
              Get.back();
              Get.back();
            });
          },
        ),
        body: Obx(() {
          if (_auctionBidLiveController.auctionView.bidInfo == null) {
            return const SizedBox.shrink();
          }

          if (_pusherController.pusherEvent.auctionFinished ?? false) {
            return AuctionBidLiveWidgets.auctionEndedBody(
              title:
                  _auctionBidLiveController.auctionView.auctionDetail?.title ??
                      '',
            );
          }

          return Column(
            children: [
              Obx(
                () => AuctionBidLiveWidgets.header(
                  photoTap: (selectedIndex) {
                    Get.to(() => FilesGalleryPreviewPage(
                        vehicleList: _auctionBidLiveController
                                .auctionView.vehicleDetail?.vehicleImages ??
                            [],
                        selectedIndex: selectedIndex));
                  },
                  images: _auctionBidLiveController
                          .auctionView.vehicleDetail?.vehicleImages ??
                      [],
                  carouselController: _carouselController,
                  currentIndexCarousalSlider:
                      _auctionBidLiveController.currentIndexCarousalSlider,
                  onPageChanged: _auctionBidLiveController
                      .updateCurrentIndexCarousalSlider,
                ),
              ),
              SizedBox(
                height: Dimensions.getHeight(12),
              ),
              Expanded(
                child: Obx(
                  () => AuctionBidLiveWidgets.body(
                    eligibleForBidding: _auctionBidLiveController
                            .auctionView.vehicleDetail?.eligibleForBidding ??
                        true,
                    currentBidAmount:
                        _auctionBidLiveController.storedBidAmount.toString(),
                    nextBidAmount: _auctionBidLiveController.myBidAmount,
                    auctionType: _auctionBidLiveController.auctionView.bidDetail?.bidType??'',
                    upcomingVehicles: _auctionBidLiveController.auctionView
                        .upcomingVehicles?.upcomingVehicleDetailList?.values,
                    bidBgColor: _auctionBidLiveController.mColor,
                    isAuctionStarted:
                        _auctionBidLiveController.isAuctionStarted,
                    auctionMessage: _auctionBidLiveController.auctionMessage,
                    soldOutMessage: _auctionBidLiveController.soldOutMessage,
                    participants:
                        _pusherController.pusherEvent.totalParticipants,
                    carName:
                        '${_auctionBidLiveController.auctionView.vehicleDetail?.year ?? ''} ${_auctionBidLiveController.auctionView.vehicleDetail?.make ?? ''} ${_auctionBidLiveController.auctionView.vehicleDetail?.model ?? ''}',
                    vin: _auctionBidLiveController
                        .auctionView.vehicleDetail?.vin,
                    sequence: _auctionBidLiveController
                        .auctionView.vehicleDetail?.serial,
                    driveTrain: _auctionBidLiveController
                        .auctionView.vehicleDetail?.drive,
                    odometer:
                        '${_auctionBidLiveController.auctionView.vehicleDetail?.odometer ?? 0} ${_auctionBidLiveController.auctionView.vehicleDetail?.odometerType}',
                    bodyStyle: _auctionBidLiveController
                        .auctionView.vehicleDetail?.bodyStyle,
                    color: _auctionBidLiveController
                        .auctionView.vehicleDetail?.color,
                    primaryDamage: _auctionBidLiveController
                        .auctionView.vehicleDetail?.primaryDamage,
                    engineType: _auctionBidLiveController
                        .auctionView.vehicleDetail?.engineType,
                    documentType: _auctionBidLiveController
                        .auctionView.vehicleDetail?.documentType,
                    onTapBidIncrement: () =>
                        _auctionBidLiveController.calculateBidIncrement(
                            bidIncrementValue: _auctionBidLiveController
                                    .auctionView.bidInfo?.bidIncrement ??
                                0),
                    onTapBidDecrement: () =>
                        _auctionBidLiveController.calculateBidDecrement(
                            bidIncrementValue: _auctionBidLiveController
                                    .auctionView.bidInfo?.bidIncrement ??
                                0),
                    isBidBtnEnabled: _auctionBidLiveController.bidButtonEnable,
                    onTapBid: () async {
                      context.showLoaderOverlay;
                      final response = await _auctionBidLiveController
                          .newBidAPI(context, isBidForYou: false);
                      context.hideLoaderOverlay;
                      if (!response.isSuccess) {
                        AppToasts.shortToast(response.message);
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
