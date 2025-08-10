import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/bids/bids_view/bids_view.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../file_preview/view/gallery_preview_page.dart';

class BidsDetailsPage extends StatefulWidget {
  const BidsDetailsPage({super.key});

  @override
  State<BidsDetailsPage> createState() => _BidsDetailsPageState();
}

class _BidsDetailsPageState extends State<BidsDetailsPage> {
  late CarouselSliderController _carouselController;
  final _bidDetailsController = Get.find<BidsViewController>();

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
  }

  _initialApiCalls() {
    _bidDetailsController.fetchBidDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final lotInfo = _bidDetailsController.bidDetailsInfo;
      return Scaffold(
          appBar: AppBars.appBarWithAction(
            title:'Vehicle Detail',
            action: const SizedBox.shrink(),
          ),
          body: (() {
            if (_bidDetailsController.isLoading) {
              return AppLoaders.loaderWithText();
            } else if (lotInfo == null) {
              return BidDetailsWidgets.errorBody(
                  errorText: Strings.errorWhileFetchingData);
            } else {
              return Column(
                children: [
                  BidDetailsWidgets.header(
                      photoTap: (selectedIndex) {
                        // final extension = getFileExtension(url);
                        // if (extension == 'jpg' ||
                        //     extension == 'png' ||
                        //     extension == 'pdf') {
                        //   Get.toNamed(AppRoutes.filesPreview, arguments: url);
                        // } else {
                        //   AppToasts.shortToast(Strings.unsupportedFileFormat);
                        // }

                        Get.to(() =>(
                            vehicleList:  lotInfo.vehicleImages ?? [],
                            selectedIndex: selectedIndex));
                      },
                      images: lotInfo.vehicleImages ?? [],
                      carouselController: _carouselController,
                      currentIndexCarousalSlider:
                          _bidDetailsController.currentIndexCarousalSlider,
                      onPageChanged: _bidDetailsController
                          .updateCurrentIndexCarousalSlider),
                  Expanded(
                    child: BidDetailsWidgets.body(
                      cylinder: lotInfo.cylinder,
                      vinNo: lotInfo.vin,
                      model: lotInfo.model,
                      transmission: lotInfo.transmission,
                      color: lotInfo.color,
                      highlights: lotInfo.highlight,
                      engineType: lotInfo.engineType,
                      odometer: '${lotInfo.odometer}',
                      fuelType: lotInfo.fuelType,
                      lotNo: lotInfo.lotNumber,
                      primaryDamage: lotInfo.primaryDamage,
                      driver: lotInfo.driveTrain,
                      mileType: lotInfo.mileageType,
                      secondaryDamage: lotInfo.secondaryDamage,
                      documentType: lotInfo.documentType,
                      keys: lotInfo.keysName,
                      rejectedNote: lotInfo.rejectionNote,
                      pageType: _bidDetailsController.selectedBidType??MBidStatusOptions.vehiclesWon,
                    ),
                  ),
                ],
              );
            }
          }()));
    });
  }
}
