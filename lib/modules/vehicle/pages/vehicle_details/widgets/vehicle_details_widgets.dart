import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class VehicleDetailsWidgets {
  VehicleDetailsWidgets._();

  static Widget header({
    required List<VehicleImages> images,
    required CarouselSliderController carouselController,
    ValueChanged<int>? onPageChanged,
    required int currentIndexCarousalSlider,
    required ValueChanged<int>? photoTap,
  }) {
    return images.isEmpty
        ? const SizedBox.shrink()
        : AppCarousalSliders.carousalSliderWithDotIndicator(
            photoTap: photoTap,
            images: images,
            carouselController: carouselController,
            currentIndexCarousalSlider: currentIndexCarousalSlider,
            onPageChanged: onPageChanged);
  }

  static Widget body({
    MVehicleDetailsSelectedOptions selectedOption =
        MVehicleDetailsSelectedOptions.bidInfo,
    ValueChanged<MVehicleDetailsSelectedOptions>? onTapOption,
    String? eligibilityStatus,
    String? startingBid,
    String? bidStatus,
    String? currentPreBid,
    String? yourBid,
    String? title,
    String? location,
    String? vinSaleDate,
    String? timeLeft,
    String? engineType,
    String? odometer,
    String? itemNo,
    String? lotNo,
    String? vinNo,
    String? primaryDamage,
    String? bodyType,
    String? color,
    String? driver,
    String? transmission,
    String? fuelType,
    String? highlights,
    MVehicleType vehicleType = MVehicleType.buyNow,
  }) {
    return Column(
      children: [
        // OPTIONS
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              vehicleType == MVehicleType.auction
                  ? _infoButton(
                      onTap: () => onTapOption
                          ?.call(MVehicleDetailsSelectedOptions.bidInfo),
                      title: 'Bid Information',
                      isSelected: selectedOption ==
                          MVehicleDetailsSelectedOptions.bidInfo)
                  : const SizedBox.shrink(),
              _infoButton(
                  onTap: () => onTapOption
                      ?.call(MVehicleDetailsSelectedOptions.vehicleInfo),
                  title: 'Vehicle Information',
                  isSelected: selectedOption ==
                      MVehicleDetailsSelectedOptions.vehicleInfo),
              _infoButton(
                  onTap: () => onTapOption
                      ?.call(MVehicleDetailsSelectedOptions.salesInfo),
                  title: 'Sales Information',
                  isSelected: selectedOption ==
                      MVehicleDetailsSelectedOptions.salesInfo),
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
              child: vehicleType == MVehicleType.auction &&
                      selectedOption == MVehicleDetailsSelectedOptions.bidInfo
                  ? _bidInfoBody(
                      eligibilityStatus: eligibilityStatus,
                      startingBid: startingBid,
                      bidStatus: bidStatus,
                      currentPreBid: currentPreBid,
                      yourBid: yourBid,
                      vehicleType: vehicleType,
                    )
                  : selectedOption == MVehicleDetailsSelectedOptions.vehicleInfo
                      ? _vehicleInfoBody(
                          engineType: engineType,
                          odometer: odometer,
                          itemNo: itemNo,
                          lotNo: lotNo,
                          vinNo: vinNo,
                primaryDamage: primaryDamage,
                          bodyType: bodyType,
                color: color,
                          driver: driver,
                          transmission: transmission,
                          fuelType: fuelType,
                          highlights: highlights,
                        )
                      : _salesInfoBody(
                          title: title,
                          location: location,
                          vinSaleDate: vinSaleDate,
                          timeLeft: timeLeft,
                        ),
            ),
          ),
        )
      ],
    );
  }

  static Widget errorBody({required String errorText}) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(Dimensions.getWidth(10)),
      child: AppTexts.smallText(
          text: errorText,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center),
    ));
  }

  static Widget footerBtn({
    int? bidAmount,
    int? auctionType,
    int? auctionStatus,
    int? sellingPrice,
    VoidCallback? onTapPreBid,
    VoidCallback? onTapBuyNow,
    VoidCallback? onTapAddBidAmount,
    VoidCallback? onTapMinusBidAmount,
    VoidCallback? onTapJoinAuction,
    MVehicleType vehicleType = MVehicleType.auction,
  }) {
    if (vehicleType == MVehicleType.buyNow) {
      // BUY NOW
      return Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.getWidth(25),
              vertical: Dimensions.getHeight(10)),
          decoration: BoxDecoration(
              color: AppColors.white, boxShadow: AppShadow.cardShadow),
          child: Row(children: [
            SizedBox(
              width: Dimensions.getWidth(122),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getWidth(20),
                    vertical: Dimensions.getHeight(10)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.getWidth(100)),
                    border: Border.all(color: AppColors.borderColor)),
                child: AppTexts.smallText(text: '${sellingPrice ?? '0000'}'),
              ),
            ),
            SizedBox(
              width: Dimensions.getWidth(5),
            ),
            const Spacer(),
            AppButtons.btnWithBg(
                onTap: onTapBuyNow,
                width: Dimensions.getWidth(90),
                radius: Dimensions.getWidth(100),
                text: 'Buy Now'),
          ]));
    } else {
      if (auctionType == 1) {
        if (auctionStatus == 7) {
          // JOIN AUCTION
          return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.getWidth(25),
                  vertical: Dimensions.getHeight(10)),
              decoration: BoxDecoration(
                  color: AppColors.white, boxShadow: AppShadow.cardShadow),
              child: Row(children: [
                AppButtons.circleButtonStrokeOnly(
                    onTap: onTapMinusBidAmount,
                    padding: Dimensions.getHeight(8),
                    svgIconPath: AppSvgIcons.minus),
                SizedBox(
                  width: Dimensions.getWidth(5),
                ),
                SizedBox(
                  width: Dimensions.getWidth(122),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.getWidth(20),
                        vertical: Dimensions.getHeight(10)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.getWidth(100)),
                        border: Border.all(color: AppColors.borderColor)),
                    child: AppTexts.smallText(text: '${bidAmount ?? '0000'}'),
                  ),
                ),
                SizedBox(
                  width: Dimensions.getWidth(5),
                ),
                AppButtons.btnWithBg(
                    onTap: onTapJoinAuction,
                    width: Dimensions.getWidth(110),
                    radius: Dimensions.getWidth(100),
                    text: 'Join Auction'),
              ]));
        }
      } else {
        if (auctionStatus == 5) {
          // PRE BID
          return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.getWidth(25),
                  vertical: Dimensions.getHeight(10)),
              decoration: BoxDecoration(
                  color: AppColors.white, boxShadow: AppShadow.cardShadow),
              child: Row(children: [
                AppButtons.circleButtonStrokeOnly(
                    onTap: onTapMinusBidAmount,
                    padding: Dimensions.getHeight(8),
                    svgIconPath: AppSvgIcons.minus),
                SizedBox(
                  width: Dimensions.getWidth(5),
                ),
                SizedBox(
                  width: Dimensions.getWidth(122),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.getWidth(20),
                        vertical: Dimensions.getHeight(10)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.getWidth(100)),
                        border: Border.all(color: AppColors.borderColor)),
                    child: AppTexts.smallText(text: '${bidAmount ?? '0000'}'),
                  ),
                ),
                SizedBox(
                  width: Dimensions.getWidth(5),
                ),
                AppButtons.circleButtonStrokeOnly(
                    onTap: onTapAddBidAmount,
                    padding: Dimensions.getHeight(8),
                    svgIconPath: AppSvgIcons.plus),
                const Spacer(),
                AppButtons.btnWithBg(
                    onTap: onTapPreBid,
                    width: Dimensions.getWidth(90),
                    radius: Dimensions.getWidth(100),
                    text: 'Pre Bid'),
              ]));
        } else if (auctionStatus == 7) {
          // JOIN AUCTION
          return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.getWidth(25),
                  vertical: Dimensions.getHeight(10)),
              decoration: BoxDecoration(
                  color: AppColors.white, boxShadow: AppShadow.cardShadow),
              child: Row(children: [
                // AppButtons.circleButtonStrokeOnly(
                //     onTap: onTapMinusBidAmount,
                //     padding: Dimensions.getHeight(8),
                //     svgIconPath: AppSvgIcons.minus),
                SizedBox(
                  width: Dimensions.getWidth(5),
                ),
                SizedBox(
                  width: Dimensions.getWidth(122),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.getWidth(20),
                        vertical: Dimensions.getHeight(10)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.getWidth(100)),
                        border: Border.all(color: AppColors.borderColor)),
                    child: AppTexts.smallText(text: '${bidAmount ?? '0000'}'),
                  ),
                ),
                SizedBox(
                  width: Dimensions.getWidth(5),
                ),
                AppButtons.btnWithBg(
                    onTap: onTapJoinAuction,
                    width: Dimensions.getWidth(110),
                    radius: Dimensions.getWidth(100),
                    text: 'Join Auction'),
              ]));
        }
      }
      // IF NOTHING MATCHED
      return const SizedBox.shrink();
    }
  }
}

Widget _bidInfoBody({
  String? eligibilityStatus,
  String? startingBid,
  String? bidStatus,
  String? currentPreBid,
  String? yourBid,
  MVehicleType vehicleType = MVehicleType.buyNow,
}) {
  return Column(
    children: [
      _infoField(title: 'Eligibility Status', value: eligibilityStatus),
      _infoField(
          title: 'STARTING BID',
          value: startingBid == null ||
                  currentPreBid == 'null' ||
                  startingBid.isEmpty
              ? 'N/A'
              : 'AED $startingBid'),
      _infoField(title: 'BID STATUS', value: bidStatus),
      _infoField(
          title: 'Current pre bid',
          value: currentPreBid == null ||
                  currentPreBid == 'null' ||
                  currentPreBid.isEmpty
              ? 'N/A'
              : 'AED $currentPreBid'),
      // _infoField(title: 'Your BID', value: yourBid == null || yourBid == 'null' || yourBid.isEmpty ? 'N/A' : 'AED $yourBid'),
    ],
  );
}

Widget _vehicleInfoBody({
  String? engineType,
  String? odometer,
  String? itemNo,
  String? lotNo,
  String? vinNo,
  String? primaryDamage,
  String? bodyType,
  String? color,
  String? driver,
  String? transmission,
  String? fuelType,
  String? highlights,
}) {
  return Column(
    children: [
      SizedBox(
        height: Dimensions.getHeight(10),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoFieldWithIcon(
              svgIconPath: AppSvgIcons.engine, value: engineType),
          _infoFieldWithIcon(svgIconPath: AppSvgIcons.road, value: odometer),
          _infoFieldWithIcon(
              svgIconPath: AppSvgIcons.fuelType, value: fuelType),
          _infoFieldWithIcon(svgIconPath: AppSvgIcons.chassis, value: driver),
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(10),
      ),
      _infoField(title: 'Sequence Number', value: itemNo),
      _infoField(title: 'Lot Number', value: lotNo),
      _infoField(title: 'Vin Number', value: vinNo),
      _infoField(title: 'Body Type', value: bodyType),
      _infoField(title: 'Color', value: color),
      _infoField(title: 'Driver', value: driver),
      _infoField(title: 'Transmission', value: transmission),
      _infoField(title: 'Fuel Type', value: fuelType),
      _infoField(title: 'Highlights', value: highlights),
      _infoField(title: 'Primary Damage', value: primaryDamage),
    ],
  );
}

Widget _salesInfoBody({
  String? title,
  String? location,
  String? vinSaleDate,
  String? timeLeft,
}) {
  return Column(
    children: [
      _infoField(title: 'Title', value: title),
      _infoField(title: 'Location', value: location),
      _infoField(title: 'Auction Date', value: vinSaleDate),
      _infoField(title: 'Time Left', value: timeLeft),
    ],
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

Widget _infoFieldWithIcon({String? value, required String svgIconPath}) {
  return value == null || value == 'null' || value.isEmpty
      ? const SizedBox.shrink()
      : Flexible(
          child: Column(
            children: [
              AppIconWidgets.svgAssetIcon(
                  iconPath: svgIconPath, size: Dimensions.getWidth(22)),
              AppTexts.smallText(
                  text: value, color: AppColors.extraLightFontColor),
            ],
          ),
        );
}

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
