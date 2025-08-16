import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class SellMyCarWidgets {
  SellMyCarWidgets._();

  static Widget header({
    TextEditingController? searchTextController,
    ValueChanged<String>? onSearch,
  }) {
    Debouncer debounce = Debouncer(milliseconds: 500);
    return Padding(
      padding: EdgeInsets.all(Dimensions.getHeight(12)),
      child: AppTextFields.textFieldHintOnly(
          controller: searchTextController,
          hintText: 'Search by Make, Mode or VIN',
          prefixIconSvgPath: AppSvgIcons.search,
          onChanged: (value) {
            if (value != null) {
              debounce.run(() => onSearch?.call(value));
            }
          }),
    );
  }

  static Widget allCarsBody(BuildContext context,
      {bool isLoadingPagination = false,
      MyAllCarsInfo? allVehicles,
      ValueChanged<int>? onTapDelete,
      ValueChanged<int>? onTapEdit,
      required MSellMyCarOptions pageType,
      Function(int, String?, int?)? onTap}) {
    return _allVehiclesListView(
      context,
      onTapDelete: onTapDelete,
      onTapEdit: onTapEdit,
      onTap: onTap,
      isLoadingPagination: isLoadingPagination,
      allVehicles: allVehicles,
      pageType: pageType,
    );
  }

  static Widget carDetailsHeader(
      {required List<VehicleImages> images,
      required ValueChanged<int>? photoTap,
      required CarouselSliderController carouselController,
      ValueChanged<int>? onPageChanged,
      required int currentIndexCarousalSlider}) {
    return images.isEmpty
        ? const SizedBox.shrink()
        : AppCarousalSliders.carousalSliderWithDotIndicator(
            images: images,
            photoTap: photoTap,
            carouselController: carouselController,
            currentIndexCarousalSlider: currentIndexCarousalSlider,
            onPageChanged: onPageChanged);
  }

  static Widget carDetailsBody({
    MyCarDetailsSelectedOptions selectedOption =
        MyCarDetailsSelectedOptions.vehicleInfo,
    ValueChanged<MyCarDetailsSelectedOptions>? onTapOption,
    VoidCallback? onTapAcceptCounter,
    required ValueChanged<String>? onTapVccDoc,
    VoidCallback? onTapCounter,
    required MyCarInfo vehicleInfo,
    dynamic pageType,
  }) {
    return Column(
      children: [
        // OPTIONS
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _infoButton(
                  onTap: () => onTapOption
                      ?.call(MyCarDetailsSelectedOptions.vehicleInfo),
                  title: 'Vehicle Details',
                  isSelected: selectedOption ==
                      MyCarDetailsSelectedOptions.vehicleInfo),
              if (pageType != MSellMyCarOptions.pendingVehicle)
                _infoButton(
                    onTap: () => onTapOption
                        ?.call(MyCarDetailsSelectedOptions.auctionInfo),
                    title: 'Auction Info',
                    isSelected: selectedOption ==
                        MyCarDetailsSelectedOptions.auctionInfo),
              ((vehicleInfo.counterOffers != null &&
                              vehicleInfo.counterOffers!.isNotEmpty) &&
                          vehicleInfo.status != 25) &&
                      pageType == MSellMyCarOptions.pendingVehicle
                  ? _infoButton(
                      onTap: () => onTapOption
                          ?.call(MyCarDetailsSelectedOptions.counterOffer),
                      title: 'Counter Offer',
                      isSelected: selectedOption ==
                          MyCarDetailsSelectedOptions.counterOffer)
                  : const SizedBox.shrink(),
            ],
          ),
        ),

        //   BODY
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.getWidth(18)),
              child: selectedOption == MyCarDetailsSelectedOptions.vehicleInfo
                  ? _vehicleDetailsBody(
                      vehicleInfo: vehicleInfo,
                      onTapVccDoc: onTapVccDoc,
                      pageType: pageType,
                    )
                  : selectedOption == MyCarDetailsSelectedOptions.auctionInfo
                      ? _auctionInfoBody(
                          auction: vehicleInfo.auction,
                        )
                      : _counterOfferBody(
                          onTapAccept: onTapAcceptCounter,
                          onTapCounter: onTapCounter,
                          counterOffers: vehicleInfo.counterOffers ?? [],
                        ),
            ),
          ),
        )
      ],
    );
  }
}

Widget _vehicleDetailsBody({
  required MyCarInfo vehicleInfo,
  required MSellMyCarOptions pageType,
  required ValueChanged<String>? onTapVccDoc,
}) {
  return Column(
    children: [
      _infoField(
        titleLeft: 'Vin',
        valueLeft: vehicleInfo.vin ?? 'N/A',
        titleRight: 'Cylinder',
        valueRight: vehicleInfo.cylinder ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Year',
        valueLeft: vehicleInfo.year ?? 'N/A',
        titleRight: 'Draive Train',
        valueRight: vehicleInfo.driveTrain ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Make',
        valueLeft: vehicleInfo.make ?? 'N/A',
        titleRight: 'Engine Type',
        valueRight: vehicleInfo.driveTrain ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Model',
        valueLeft: vehicleInfo.model ?? 'N/A',
        titleRight: 'Category',
        valueRight: vehicleInfo.categoryName ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Color',
        valueLeft: vehicleInfo.color ?? 'N/A',
        titleRight: 'Transmission',
        valueRight: vehicleInfo.transmission ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Lot Number',
        valueLeft: vehicleInfo.lotNumber ?? 'N/A',
        titleRight: 'Highlight',
        valueRight: vehicleInfo.highlight ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Odometer',
        valueLeft:
            '${vehicleInfo.odometer ?? 'N/A'} ${vehicleInfo.odometerType ?? ''}',
        titleRight: 'Primary Damage',
        valueRight: vehicleInfo.primaryDamage ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Mileage Type',
        valueLeft: '${vehicleInfo.mileageType ?? 'N/A'}',
        titleRight: 'Secondary Damage',
        valueRight: vehicleInfo.secondaryDamage ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Plan',
        valueLeft: vehicleInfo.plan ?? 'N/A',
        titleRight: 'Passing Test',
        valueRight: vehicleInfo.passingTestName ?? 'N/A',
      ),
      if (pageType != MSellMyCarOptions.soldVehicle &&
          pageType != MSellMyCarOptions.unsoldVehicle &&
          pageType != MSellMyCarOptions.returnVehicle)
        _infoField(
          titleLeft: 'Keys',
          valueLeft: vehicleInfo.keysName ?? 'N/A',
          titleRight: 'Runs',
          valueRight: '${vehicleInfo.runs ?? 'N/A'}',
        ),
      if (pageType == MSellMyCarOptions.pendingVehicle)
        _infoVccField(
          titleLeft: '${vehicleInfo.documentType??''} Document',
          valueLeft: '${vehicleInfo.vccDocument ?? ''}',
          titleRight: 'Reserve Price',
          valueRight: '${vehicleInfo.reserveAmount ?? 'N/A'}',
          onTapVccDoc: onTapVccDoc,
        ),
      if (pageType != MSellMyCarOptions.soldVehicle && pageType != MSellMyCarOptions.pendingVehicle)
        _infoField(
          titleLeft: 'Sale Type',
          valueLeft: vehicleInfo.saleTypeName ?? 'N/A',
          titleRight: 'Reserve Price',
          valueRight: '${vehicleInfo.reserveAmount ?? 'N/A'}',
        ),
      if (pageType == MSellMyCarOptions.soldVehicle)
        _infoField(
          titleLeft: 'Keys',
          titleRight: 'Selling Price',
          valueRight: '${vehicleInfo.sellingPrice ?? 'N/A'}',
        ),
      if (pageType == MSellMyCarOptions.unsoldVehicle)
        _infoField(
          titleLeft: 'Keys',
          valueLeft: vehicleInfo.keysName ?? 'N/A',
          titleRight: 'Start Bid Amount',
          valueRight: '${vehicleInfo.startBidAmount ?? 'N/A'}',
        ),
      if (pageType == MSellMyCarOptions.sellingApprovalVehicle ||
          pageType == MSellMyCarOptions.returnVehicle)
        _infoFullField(
          titleLeft: 'Start Bid Amount',
          valueLeft: '${vehicleInfo.startBidAmount ?? 'N/A'}',
        ),
    ],
  );
}

Widget _auctionInfoBody({
  required Auction? auction,
}) {
  if (auction == null) {
    return const SizedBox.shrink();
  }
  return Column(
    children: [
      _infoField(
        titleLeft: 'Auction At',
        valueLeft: auction.auctionAt ?? 'N/A',
        titleRight: 'Location',
        valueRight: auction.locationName ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Auction Type',
        valueLeft: auction.auctionTypeName ?? 'N/A',
        titleRight: 'Status',
        valueRight: auction.statusName ?? 'N/A',
      ),
      _infoField(
        titleLeft: 'Auction Yard',
        valueLeft: auction.auctionYardName ?? 'N/A',
        titleRight: 'Total Vehicles',
        valueRight: '${auction.totalVehicles ?? 'N/A'}',
      ),
    ],
  );
}

Widget _counterOfferBody({
  required List<CounterOffers> counterOffers,
  VoidCallback? onTapAccept,
  VoidCallback? onTapCounter,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: Dimensions.getHeight(12),
    children: [
      // TITLE
      counterOffers.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Dimensions.getWidth(12),
              children: [
                SizedBox(
                    width: Get.width * 0.3,
                    height: Dimensions.getHeight(40),
                    child: AppButtons.btnWithBg(
                        text: 'Accept',
                        bgColor: Colors.green,
                        onTap: onTapAccept)),
                SizedBox(
                    width: Get.width * 0.3,
                    height: Dimensions.getHeight(40),
                    child: AppButtons.btnWithBg(
                        text: 'Counter', onTap: onTapCounter)),
              ],
            )
          : const SizedBox.shrink(),

      //
      ...counterOffers.map((info) {
        return Container(
          padding: EdgeInsets.all(Dimensions.getHeight(6)),
          margin: EdgeInsets.only(bottom: Dimensions.getHeight(12)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.getHeight(6)),
            color: Colors.grey.shade50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoField(
                titleLeft: 'OFFER BY',
                valueLeft: info.adminName ?? 'N/A',
                titleRight: 'Amount',
                valueRight: '${info.counterAmount ?? 'N/A'}',
              ),
              _infoFullField(titleLeft: 'Note', valueLeft: info.note ?? 'N/A'),
              _infoFullField(
                titleLeft: 'Offer Date',
                valueLeft: info.createdAt ?? 'N/A',
                isLast: true,
              ),
            ],
          ),
        );
      })
    ],
  );
}

Widget _infoFullField(
    {required String titleLeft, String? valueLeft, bool isLast = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: Dimensions.getHeight(10)),
    width: double.maxFinite,
    decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: AppColors.lightGrey))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppTexts.mediumText(
            text: titleLeft.toUpperCase(), color: AppColors.grey),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.mediumText(
            text: valueLeft == null || valueLeft == 'null' || valueLeft.isEmpty
                ? 'N/A'
                : valueLeft,
            overflow: TextOverflow.visible),
      ],
    ),
  );
}

Widget _infoButton(
    {required String title, bool isSelected = true, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(Dimensions.getWidth(10)),
      margin: EdgeInsets.all(Dimensions.getWidth(8)),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.mediumLightGrey : Colors.transparent,
          border: Border.all(
              color:
                  isSelected ? Colors.transparent : AppColors.mediumLightGrey),
          borderRadius: BorderRadius.circular(Dimensions.getWidth(100))),
      child: AppTexts.mediumText(
          text: title,
          color: isSelected ? AppColors.baseFontColor : AppColors.grey),
    ),
  );
}

Widget _infoField(
    {required String titleLeft,
    String? valueLeft,
    required String titleRight,
    String? valueRight,
    bool isLast = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: Dimensions.getHeight(10)),
    width: double.maxFinite,
    decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: AppColors.lightGrey))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppTexts.mediumText(
                  text: titleLeft.toUpperCase(), color: AppColors.grey),
              SizedBox(
                height: Dimensions.getHeight(5),
              ),
              AppTexts.mediumText(
                  text: valueLeft == null ||
                          valueLeft == 'null' ||
                          valueLeft.isEmpty
                      ? 'N/A'
                      : valueLeft,
                  overflow: TextOverflow.visible),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppTexts.mediumText(
                  text: titleRight.toUpperCase(), color: AppColors.grey),
              SizedBox(
                height: Dimensions.getHeight(5),
              ),
              AppTexts.mediumText(
                  text: valueRight == null ||
                          valueRight == 'null' ||
                          valueRight.isEmpty
                      ? 'N/A'
                      : valueRight,
                  overflow: TextOverflow.visible),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _infoVccField({
  required String titleLeft,
  String? valueLeft,
  required String titleRight,
  String? valueRight,
  required ValueChanged<String>? onTapVccDoc,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: Dimensions.getHeight(10)),
    width: double.maxFinite,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppTexts.mediumText(
                  text: titleLeft.toUpperCase(), color: AppColors.grey),
              SizedBox(
                height: Dimensions.getHeight(5),
              ),
              AppButtons.textButton(
                  fontSize: Dimensions.mFontSize14,
                  text: 'View Document',
                  onTap: () {
                    onTapVccDoc?.call(valueLeft ?? '');
                  }),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppTexts.mediumText(
                  text: titleRight.toUpperCase(), color: AppColors.grey),
              SizedBox(
                height: Dimensions.getHeight(5),
              ),
              AppTexts.mediumText(
                  text: valueRight == null ||
                          valueRight == 'null' ||
                          valueRight.isEmpty
                      ? 'N/A'
                      : valueRight,
                  overflow: TextOverflow.visible),
            ],
          ),
        ),
      ],
    ),
  );
}

/*
Widget _infoField({required String title, String? value, bool isLast = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: Dimensions.getHeight(10)),
    width: double.maxFinite,
    decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: AppColors.lightGrey))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.mediumText(text: title.toUpperCase(), color: AppColors.grey),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.mediumText(
            text: value == null || value == 'null' || value.isEmpty
                ? 'N/A'
                : value,
            overflow: TextOverflow.visible),
      ],
    ),
  );
}
*/

Widget _allVehiclesListView(
  BuildContext context, {
  bool isLoadingPagination = false,
  MyAllCarsInfo? allVehicles,
  ValueChanged<int>? onTapDelete,
  ValueChanged<int>? onTapEdit,
  Function(int, String?, int?)? onTap,
  required MSellMyCarOptions pageType,
}) {
  final List<VehicleDetailType> displayTypes =
      VehicleDisplayHelper.getDetailsForPageType(pageType);
  return Wrap(
    spacing: Dimensions.getWidth(10),
    runSpacing: Dimensions.getHeight(10),
    children: List.generate((allVehicles?.data?.length ?? 0) + 1, (index) {
      if (index < (allVehicles?.data?.length ?? 0)) {
        final vehicleInfo = allVehicles!.data![index];
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
                child: GestureDetector(
              onTap: () {
                if (vehicleInfo.id != null) {
                  onTap?.call(
                    vehicleInfo.id!,
                    vehicleInfo.title,
                    vehicleInfo.status,
                  );
                }
              },
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                    left: Dimensions.getHeight(12),
                    right: Dimensions.getHeight(12),
                    top: Dimensions.getHeight(6)),
                padding: EdgeInsets.all(Dimensions.getHeight(8)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.getWidth(10))),
                  boxShadow: AppShadow.cardShadow,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _vehicleCarPreview(
                      thumbnailUrl: vehicleInfo.thumbnailUrl,
                    ),
                    SizedBox(
                      width: Dimensions.getWidth(12),
                    ),
                    Expanded(
                      child: _vehicleCarDetails(
                        displayTypes: displayTypes,
                        vehicleInfo: vehicleInfo,
                      ),
                    ),
                    if (vehicleInfo.status == 0 || vehicleInfo.status == 50)
                      Column(
                        children: [
                          AppButtons.iconButtonWithBg(
                              onTap: () {
                                onTapEdit?.call(vehicleInfo.id!);
                              },
                              icon: Icons.edit),
                          SizedBox(
                            height: Dimensions.getHeight(8),
                          ),
                          AppButtons.iconButtonWithBg(
                              onTap: () {
                                AppDialogs.deleteConfirmation(context,
                                    onTapBtn2: () {
                                  if (vehicleInfo.id != null) {
                                    onTapDelete?.call(vehicleInfo.id!);
                                  }
                                });
                              },
                              icon: Icons.delete)
                        ],
                      )
                  ],
                ),
              ),
            )),
          ),
        );
      } else {
        return isLoadingPagination
            ? _vehicleSkeleton()
            : const SizedBox.shrink();
      }
    }),
  );
}

Widget _vehicleCarPreview({
  String? thumbnailUrl,
  // String? tag,
}) {
  return Stack(
    children: [
      CachedNetworkImage(
        imageUrl: thumbnailUrl ?? '',
        imageBuilder: (context, imageProvider) => Container(
          width: Dimensions.getHeight(132),
          height: Dimensions.getHeight(85),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(Dimensions.getWidth(10))),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => AppSkeletons.shimmerContainer(
          width: Dimensions.getHeight(132),
          height: Dimensions.getHeight(85),
        ),
        errorWidget: (context, url, error) => Container(
          width: Dimensions.getHeight(132),
          height: Dimensions.getHeight(85),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(Dimensions.getWidth(10))),
            image: DecorationImage(
              image: AssetImage(AppPngIcons.placeholder),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _vehicleCarDetails({
  required MyAllCarsData vehicleInfo,
  required List<VehicleDetailType> displayTypes,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: displayTypes.map((type) {
      switch (type) {
        case VehicleDetailType.vin:
          return AppTexts.smallText(
            text: 'Vin: ${vehicleInfo.vin ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.title:
          return AppTexts.smallText(
            text: 'Title: ${vehicleInfo.title ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.reservedPrice:
          return AppTexts.smallText(
            text: 'Reserved Price: ${vehicleInfo.reserveAmount ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );

        case VehicleDetailType.counterOffer:
          return AppTexts.smallText(
            text: 'Counter Offer: ${vehicleInfo.counterAmount ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );

        case VehicleDetailType.docApproved:
          return AppTexts.smallText(
            text:
                'Document Status: ${vehicleInfo.docApproved == 0 ? 'Not Approved' : 'Approved'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.docReceived:
          return AppTexts.smallText(
            text:
                'Document Status: ${vehicleInfo.docReceived == 0 ? 'Not Received' : 'Received'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.runs:
          return AppTexts.smallText(
            text: 'RUNS: ${vehicleInfo.runs ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.price:
          return AppTexts.smallText(
            text: 'Price: ${vehicleInfo.reserveAmount ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.reservedAmount:
          return AppTexts.smallText(
            text: 'Reserve Amount: ${vehicleInfo.reserveAmount ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.auction:
          return AppTexts.smallText(
            text: 'Auction: ${vehicleInfo.auctionName ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.sequence:
          return AppTexts.smallText(
            text: 'Sequence: ${vehicleInfo.serial ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.soldDate:
          return AppTexts.smallText(
            text: 'Sold Date: ${vehicleInfo.soldDate ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.soldPrice:
          return AppTexts.smallText(
            text: 'Sold Price: ${vehicleInfo.sellingPrice ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.maxBid:
          return AppTexts.smallText(
            text: 'Max Bid: ${vehicleInfo.sellingPrice ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
        case VehicleDetailType.statusName:
          return AppTexts.smallText(
            text: 'Status: ${vehicleInfo.statusName ?? 'N/A'}',
            fontWeight: FontWeight.bold,
          );
      }
    }).toList(),
  );
}

Widget _vehicleSkeleton() {
  return Container(
    margin: EdgeInsets.only(
        left: Dimensions.getHeight(12), right: Dimensions.getHeight(12)),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.getWidth(10))),
      boxShadow: AppShadow.cardShadow,
    ),
    child: Row(
      children: [
        AppSkeletons.shimmerContainer(
          width: Dimensions.getHeight(132),
          height: Dimensions.getHeight(100),
        ),
        SizedBox(
          width: Dimensions.getWidth(10),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(Dimensions.getWidth(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSkeletons.shimmerContainer(
                  height: Dimensions.getHeight(13), width: Get.width * 0.35),
              SizedBox(
                height: Dimensions.getHeight(4),
              ),
              AppSkeletons.shimmerContainer(
                  height: Dimensions.getHeight(13), width: Get.width * 0.35),
              SizedBox(
                height: Dimensions.getHeight(4),
              ),
              AppSkeletons.shimmerContainer(
                  height: Dimensions.getHeight(13), width: Get.width * 0.35),
              SizedBox(
                height: Dimensions.getHeight(4),
              ),
              AppSkeletons.shimmerContainer(
                  height: Dimensions.getHeight(13), width: Get.width * 0.35),
            ],
          ),
        ))
      ],
    ),
  );
}
