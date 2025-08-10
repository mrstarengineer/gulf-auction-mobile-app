import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../../../global/global.dart';

class AuctionsListWidgets {
  AuctionsListWidgets._();

  static Widget auctionsListBody({
    required bool isAuctionLive,
    List<Auctions>? auctions,
    ValueChanged<int?>? onTapJoin,
    ValueChanged<String?>? onTapCatalogue,
    ValueChanged<int?>? onTapViewCars,
  }) {
    return Column(
      children: [
        _header(
            title: isAuctionLive ? 'Auctions Live Right Now' : 'Auction Later'),
        SizedBox(
          height: Dimensions.getHeight(14),
        ),
        auctions == null || auctions.isEmpty
            ? AppTexts.smallText(
                text: 'There are not auctions available at this time')
            : Wrap(
                spacing: Dimensions.getWidth(10),
                runSpacing:
                    Dimensions.getHeight(10), // Vertical spacing between rows
                children: List.generate(auctions.length, (index) {
                  final auctionInfo = auctions[index];
                  return Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(Dimensions.getHeight(12)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.getWidth(10))),
                      boxShadow: AppShadow.cardShadow,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTexts.mediumText(
                                  text: auctionInfo.auctionYardName ?? '',
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                height: Dimensions.getHeight(10),
                              ),
                              Row(
                                children: [
                                  AppIconWidgets.svgAssetIcon(
                                      iconPath: AppSvgIcons.clock,
                                      size: Dimensions.getHeight(12)),
                                  SizedBox(
                                    width: Dimensions.getWidth(4),
                                  ),
                                  Flexible(
                                      child: AppTexts.smallText(
                                          text: auctionInfo.auctionTime ?? '',
                                          maxLine: 2))
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.getHeight(10),
                              ),
                              Row(
                                children: [
                                  AppIconWidgets.svgAssetIcon(
                                      iconPath: AppSvgIcons.location,
                                      size: Dimensions.getHeight(12)),
                                  SizedBox(
                                    width: Dimensions.getWidth(4),
                                  ),
                                  Flexible(
                                      child: AppTexts.smallText(
                                          text: auctionInfo.locationName ?? '',
                                          maxLine: 2))
                                ],
                              )
                            ],
                          ),
                        ),
                        _joinWithCarCount(
                            isCatalogue: auctionInfo.catalogUrl != null &&
                                    auctionInfo.catalogUrl!.isNotEmpty
                                ? true
                                : false,
                            isAuctionLive: isAuctionLive,
                            auctionId: auctionInfo.id,
                            onTapJoin: () {
                              if (auctionInfo.id != null) {
                                onTapJoin?.call(auctionInfo.id);
                              }
                            },
                            onTapCatalogue: () {
                              if (auctionInfo.id != null) {
                                onTapCatalogue
                                    ?.call(auctionInfo.catalogUrl ?? '');
                              }
                            },
                            onTapViewCars: onTapViewCars,
                            vehicleCount: auctionInfo.totalVehicles)
                      ],
                    ),
                  );
                }),
              )
      ],
    );
  }
}

Widget _header({required String title}) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.all(Dimensions.getHeight(12)),
    decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(Dimensions.getHeight(4))),
    child: AppTexts.smallText(text: title, color: AppColors.white),
  );
}

Widget _joinWithCarCount({
  ValueChanged<int?>? onTapViewCars,
  int? auctionId,
  int? vehicleCount,
  VoidCallback? onTapJoin,
  VoidCallback? onTapCatalogue,
  bool isAuctionLive = true,
  bool isCatalogue = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Row(
        children: [
          AppIconWidgets.svgAssetIcon(
              iconPath: AppSvgIcons.car, size: Dimensions.getHeight(12)),
          SizedBox(
            width: Dimensions.getWidth(4),
          ),
          AppTexts.smallText(text: '${vehicleCount ?? 0}')
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(35),
      ),
      Row(
        children: [
          SizedBox(
            height: Get.width * 0.1,
            width: Get.width * 0.2,
            child: AppButtons.textBtnWithStrokeOnly(
              onTap: () {
                onTapViewCars?.call(auctionId);
              },
              text: 'Details',
              fontSize: Dimensions.mFontSize12,
              padding: Dimensions.getHeight(2),
            ),
          ),
          if (isCatalogue)
            SizedBox(
              width: Dimensions.getWidth(8),
            ),
          if (isCatalogue)
            SizedBox(
              height: Get.width * 0.08,
              width: Get.width * 0.2,
              child: AppButtons.textBtnWithStrokeOnly(
                onTap: onTapCatalogue,
                text: 'Catalogue',
                fontSize: Dimensions.mFontSize12,
                padding: Dimensions.getHeight(2),
              ),
            ),
          if (isAuctionLive)
            SizedBox(
              width: Dimensions.getWidth(8),
            ),
          if (isAuctionLive)
            SizedBox(
              height: Get.width * 0.1,
              width: Get.width * 0.2,
              child: AppButtons.textBtnWithStrokeOnly(
                onTap: onTapJoin,
                text: 'Join',
                fontSize: Dimensions.mFontSize12,
                padding: Dimensions.getHeight(2),
              ),
            ),
        ],
      )
    ],
  );
}
