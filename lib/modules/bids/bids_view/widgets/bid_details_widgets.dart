import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class BidDetailsWidgets {
  BidDetailsWidgets._();

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
    String? engineType,
    String? odometer,
    String? fuelType,
    String? driver,
    String? vinNo,
    String? cylinder,
    String? model,
    String? transmission,
    String? color,
    String? highlights,
    String? lotNo,
    String? primaryDamage,
    String? mileType,
    String? secondaryDamage,
    String? documentType,
    String? keys,
    String? rejectedNote,
    required MBidStatusOptions pageType,
  }) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.getWidth(18)),
              child: _vehicleInfoBody(
                engineType: engineType,
                odometer: odometer,
                fuelType: fuelType,
                driver: driver,
                vinNo: vinNo,
                cylinder: cylinder,
                model: model,
                transmission: transmission,
                color: color,
                highlights: highlights,
                lotNo: lotNo,
                primaryDamage: primaryDamage,
                mileType: mileType,
                secondaryDamage: secondaryDamage,
                documentType: documentType,
                keys: keys,
                rejectedNote: rejectedNote,
                pageType: pageType,
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

  static Widget _vehicleInfoBody({
    String? engineType,
    String? odometer,
    String? fuelType,
    String? driver,
    String? vinNo,
    String? cylinder,
    String? model,
    String? transmission,
    String? color,
    String? highlights,
    String? lotNo,
    String? primaryDamage,
    String? mileType,
    String? secondaryDamage,
    String? documentType,
    String? keys,
    String? rejectedNote,
    required MBidStatusOptions pageType,
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
        _infoField(
          titleLeft: 'Vin Number',
          valueLeft: vinNo,
          titleRight: 'Cylinder',
          valueRight: cylinder,
        ),
        _infoField(
          titleLeft: 'Model',
          valueLeft: model,
          titleRight: 'Transmission',
          valueRight: transmission,
        ),
        _infoField(
          titleLeft: 'Color',
          valueLeft: color,
          titleRight: 'Highlight',
          valueRight: highlights,
        ),
        _infoField(
          titleLeft: 'Lot Number',
          valueLeft: lotNo,
          titleRight: 'Primary Damage',
          valueRight: primaryDamage,
        ),
        _infoField(
          titleLeft: 'Mileage Type',
          valueLeft: mileType,
          titleRight: 'Secondary Damage',
          valueRight: secondaryDamage,
        ),
        _infoField(
          titleLeft: 'Document Type',
          valueLeft: documentType,
          titleRight: 'Keys',
          valueRight: keys,
          isLast: pageType!=MBidStatusOptions.vehiclesLoss
        ),
        if(pageType==MBidStatusOptions.vehiclesLoss)
        _infoFullField(
          titleLeft: 'Note/Offer',
          valueLeft: rejectedNote,
          isLast: true,
        ),
      ],
    );
  }

  static Widget _infoFieldWithIcon(
      {String? value, required String svgIconPath}) {
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

  static Widget _infoField(
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

  static Widget _infoFullField(
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
              text:
                  valueLeft == null || valueLeft == 'null' || valueLeft.isEmpty
                      ? 'N/A'
                      : valueLeft,
              overflow: TextOverflow.visible),
        ],
      ),
    );
  }
}
