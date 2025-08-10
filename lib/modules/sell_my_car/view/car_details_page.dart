import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/sell_my_car/sell_my_car.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../routes/routes.dart';
import '../../../settings/settings.dart';
import '../../file_preview/view/gallery_preview_page.dart';

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({super.key});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  late CarouselSliderController _carouselController;

  final _sellMyCarController = Get.find<SellMyCarController>();
  final vehicleId = int.parse(Get.parameters['vehicleId'] ?? '0');
  final vehicleTitle = Get.parameters['vehicleTitle'] ?? 'null';
  final _pageType = Get.arguments;

  @override
  void initState() {
    _carouselController = CarouselSliderController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
    super.initState();
  }

  _initialApiCalls() {
    _sellMyCarController.fetchSingleVehicle(vehicleId: vehicleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(
          title: vehicleTitle == 'null' ? 'Vehicle Details' : vehicleTitle),
      body: Obx(() {
        final vehicleInfo = _sellMyCarController.singleVehicleInfo;
        if (_sellMyCarController.isLoadingInitial) {
          return AppLoaders.loaderWithText();
        } else if (vehicleInfo == null) {
          return AppAlertMessages.errorAlert();
        } else {
          return Column(
            children: [
              SellMyCarWidgets.carDetailsHeader(
                  photoTap: (selectedIndex) {
                    // final extension = getFileExtension(url);
                    // if (extension == 'jpg' ||
                    //     extension == 'png' ||
                    //     extension == 'pdf') {
                    //   Get.toNamed(AppRoutes.filesPreview, arguments: url);
                    // } else {
                    //   AppToasts.shortToast(Strings.unsupportedFileFormat);
                    // }

                    Get.to(() => FilesGalleryPreviewPage(
                        vehicleList: vehicleInfo.vehicleImages ?? [],
                        selectedIndex: selectedIndex));
                  },
                  images: vehicleInfo.vehicleImages ?? [],
                  carouselController: _carouselController,
                  currentIndexCarousalSlider:
                      _sellMyCarController.currentIndexCarousalSlider,
                  onPageChanged:
                      _sellMyCarController.updateCurrentIndexCarousalSlider),
              Expanded(
                child: SellMyCarWidgets.carDetailsBody(
                  selectedOption: _sellMyCarController.selectedOption,
                  onTapOption: _sellMyCarController.updateSelectedOption,
                  // counterOffers: vehicleInfo.counterOffers,
                  onTapAcceptCounter: () {
                    AppDialogs.acceptConfirmation(context, onTapBtn1: () {
                      Get.back();
                      context.showLoaderOverlay;
                      _sellMyCarController
                          .acceptOffer(vehicleId: vehicleInfo.id)
                          .then((response) {
                        if (context.mounted) {
                          context.hideLoaderOverlay;
                          AppToasts.shortToast(response.message);
                        }
                      });
                    });
                  },
                  onTapCounter: () {
                    AppBottomSheets.counterOfferSheet(
                      formKey: _sellMyCarController.counterOfferFormKey,
                      onTapCounter: () async {
                        if ((_sellMyCarController
                                .counterOfferFormKey.currentState
                                ?.validate() ??
                            false)) {
                          context.showLoaderOverlay;
                          _sellMyCarController
                              .counterOffer(vehicleId: vehicleInfo.id)
                              .then((response) {
                            if (response.isSuccess) {
                              _sellMyCarController
                                  .fetchSingleVehicle(
                                      vehicleId: vehicleId, showLoader: false)
                                  .then((vehicleResponse) {
                                _sellMyCarController
                                    .counterOfferAmountController
                                    .clear();
                                _sellMyCarController.counterOfferNoteController
                                    .clear();
                                Get.back();
                                if (context.mounted) {
                                  context.hideLoaderOverlay;
                                }
                                if (!vehicleResponse.isSuccess) {
                                  AppToasts.shortToast(vehicleResponse.message);
                                }
                              });
                            } else {
                              if (context.mounted) {
                                context.hideLoaderOverlay;
                              }
                              AppToasts.shortToast(response.message);
                            }
                          });
                        }
                      },
                      amountPriceController:
                          _sellMyCarController.counterOfferAmountController,
                      noteController:
                          _sellMyCarController.counterOfferNoteController,
                    );
                  },
                  onTapVccDoc: (url) {
                    final extension = getFileExtension(url);
                    if (extension == 'jpg' ||
                        extension == 'jpeg' ||
                        extension == 'png' ||
                        extension == 'pdf') {
                      Get.toNamed(AppRoutes.filesPreview, arguments: url);
                    } else {
                      AppToasts.shortToast(Strings.unsupportedFileFormat);
                    }
                  },
                  pageType: _pageType,
                  vehicleInfo: vehicleInfo,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
