import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/vehicle_details/vehicle_details.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../../file_preview/view/gallery_preview_page.dart';

class VehicleDetailsPage extends StatefulWidget {
  const VehicleDetailsPage({super.key});

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  late CarouselSliderController _carouselController;
  final _lotNo = Get.parameters['lotNo'] ?? '';

  final _globalController = Get.find<GlobalController>();
  final _vehicleDetailsController = Get.find<VehicleDetailsController>();
  final _defaultPreBidIncrementAmount = Get.find<PreferenceController>()
      .getInt(PrefsKeys.defaultBidIncrementValue);

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
  }

  _initialApiCalls() {
    _vehicleDetailsController.fetchLotDetails(
        lotNo: _lotNo,
        defaultPreBidIncrementAmount: _defaultPreBidIncrementAmount ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final lotInfo = _vehicleDetailsController.lotDetailsInfo;
      return Scaffold(
          appBar: AppBars.appBarWithAction(
            title: lotInfo?.title ?? '',
            action: lotInfo != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.getWidth(10)),
                    child: AppButtons.circleButtonStrokeOnly(
                      onTap: () {
                        context.showLoaderOverlay;
                        _globalController
                            .vehicleIsWatch(
                          vehicleId: lotInfo.id,
                          isWatched: !lotInfo.isWatched!,
                        )
                            .then((response) {
                          context.hideLoaderOverlay;
                          AppToasts.shortToast(response.message);
                          if (response.isSuccess) {
                            _initialApiCalls();
                          }
                        });
                      },
                      svgIconPath: lotInfo.isWatched ?? false
                          ? AppSvgIcons.heartFilled
                          : AppSvgIcons.heart,
                      // bgColor: AppColors.black.withOpacity(0.51),
                      padding: Dimensions.getWidth(5),
                      iconSize: Dimensions.getWidth(16),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          body: (() {
            if (_vehicleDetailsController.isLoading) {
              return AppLoaders.loaderWithText();
            } else if (lotInfo == null) {
              return VehicleDetailsWidgets.errorBody(
                  errorText: Strings.errorWhileFetchingData);
            } else {
              return SafeArea(
                child: Column(
                  children: [
                    VehicleDetailsWidgets.header(
                        photoTap: (selectedIndex) {
                          Get.to(() => FilesGalleryPreviewPage(
                              vehicleList: lotInfo.vehicleImages ?? [],
                              selectedIndex: selectedIndex));
                          // final extension = getFileExtension(url);
                          // if (extension == 'jpg' ||
                          //     extension == 'png' ||
                          //     extension == 'pdf') {
                          //
                          //   Get.toNamed(AppRoutes.filesPreview, arguments: url);
                          // } else {
                          //   AppToasts.shortToast(Strings.unsupportedFileFormat);
                          // }
                        },
                        images: lotInfo.vehicleImages ?? [],
                        carouselController: _carouselController,
                        currentIndexCarousalSlider: _vehicleDetailsController
                            .currentIndexCarousalSlider,
                        onPageChanged: _vehicleDetailsController
                            .updateCurrentIndexCarousalSlider),
                    Expanded(
                      child: VehicleDetailsWidgets.body(
                        vehicleType: lotInfo.categoryId == 2
                            ? MVehicleType.buyNow
                            : MVehicleType.auction,
                        selectedOption:
                            _vehicleDetailsController.selectedOption,
                        onTapOption:
                            _vehicleDetailsController.updateSelectedOption,
                        eligibilityStatus: (lotInfo.eligible ?? false)
                            ? 'Eligible'
                            : 'Not eligible',
                        startingBid: '${lotInfo.startBidAmount}',
                        bidStatus: lotInfo.bidStatusName,
                        currentPreBid: '${lotInfo.currentBidAmount}',
                        // yourBid: '0',
                        engineType: lotInfo.engineType,
                        odometer: lotInfo.odometer,
                        itemNo: '${lotInfo.itemNumber}',
                        lotNo: lotInfo.lotNumber,
                        vinNo: lotInfo.vinMask,
                        primaryDamage: lotInfo.primaryDamage,
                        color: lotInfo.color,
                        bodyType: lotInfo.bodyStyle,
                        driver: lotInfo.driveTrain,
                        transmission: lotInfo.transmission,
                        fuelType: lotInfo.fuelType,
                        highlights: lotInfo.highlight,
                        title: lotInfo.title,
                        location: lotInfo.saleName,
                        vinSaleDate: lotInfo.saleDate,
                        timeLeft: lotInfo.remainingTime,
                      ),
                    ),
                    VehicleDetailsWidgets.footerBtn(
                        auctionType: lotInfo.auctionType,
                        auctionStatus: lotInfo.auctionStatus,
                        sellingPrice: lotInfo.sellingPrice,
                        bidAmount: lotInfo.categoryId == 2
                            ? lotInfo.startBidAmount
                            : _vehicleDetailsController.preBidAmount,
                        vehicleType: lotInfo.categoryId == 2
                            ? MVehicleType.buyNow
                            : MVehicleType.auction,
                        onTapJoinAuction: () {
                          final isUserLoggedIn =
                              Get.find<PreferenceController>()
                                  .containsKey(PrefsKeys.accessToken);
                          if (isUserLoggedIn) {
                            Get.toNamed(AppRoutes.auctionBidLive, parameters: {
                              'selectedAuctionId': '${lotInfo.auctionId}'
                            });
                          } else {
                            Get.toNamed(AppRoutes.signIn,
                                parameters: {'isFromGuestUser': 'true'});
                          }
                        },
                        onTapAddBidAmount: () =>
                            _vehicleDetailsController.updatePreBidAmount(
                                startBidAmount: lotInfo.startBidAmount ?? 0,
                                currentBidAmount: lotInfo.currentBidAmount ?? 0,
                                defaultPreBidIncrementAmount:
                                    lotInfo.bidIncrement ?? 0,
                                isAdd: true),
                        onTapMinusBidAmount: () =>
                            _vehicleDetailsController.updatePreBidAmount(
                                startBidAmount: lotInfo.startBidAmount ?? 0,
                                currentBidAmount: lotInfo.currentBidAmount ?? 0,
                                defaultPreBidIncrementAmount:
                                    lotInfo.bidIncrement ?? 0,
                                isAdd: false),
                        onTapBuyNow: () {
                          final isUserLoggedIn =
                              Get.find<PreferenceController>()
                                  .containsKey(PrefsKeys.accessToken);
                          if (isUserLoggedIn) {
                            context.showLoaderOverlay;
                            _vehicleDetailsController
                                .buyNowVehicle(vehicleId: '${lotInfo.id}')
                                .then((response) {
                              context.hideLoaderOverlay;
                              if (response.isSuccess) {
                                Get.offAllNamed(AppRoutes.dashboard);
                              }
                              AppToasts.shortToast(response.message);
                            });
                          } else {
                            Get.toNamed(AppRoutes.signIn,
                                parameters: {'isFromGuestUser': 'true'});
                          }
                        },
                        onTapPreBid: () {
                          final isUserLoggedIn =
                              Get.find<PreferenceController>()
                                  .containsKey(PrefsKeys.accessToken);
                          if (isUserLoggedIn) {
                            context.showLoaderOverlay;
                            _vehicleDetailsController
                                .offlineBidByVehicle(vehicleId: '${lotInfo.id}')
                                .then((response) {
                              context.hideLoaderOverlay;
                              if (response.isSuccess) {
                                _initialApiCalls();
                              }
                              AppToasts.shortToast(response.message);
                            });
                          } else {
                            Get.toNamed(AppRoutes.signIn,
                                parameters: {'isFromGuestUser': 'true'});
                          }
                        })
                  ],
                ),
              );
            }
          }()));
    });
  }
}
