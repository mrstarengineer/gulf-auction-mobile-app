import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/auction/auction.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class JoinAuctionPageWidgets {
  JoinAuctionPageWidgets._();

  static PreferredSizeWidget appBar({VoidCallback? onTapBack}) {
    return AppBar(
      leadingWidth: Dimensions.getHeight(65),
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
        child: AppButtons.circleButtonStrokeOnly(
            onTap: onTapBack,
            svgIconPath: AppSvgIcons.arrowLeft,
            iconSize: Dimensions.getHeight(18)),
      ),
    );
  }

  static Widget joinAuctionBody({
    List<Auctions>? auctionsLive,
    List<Auctions>? auctionsLater,
    ValueChanged<int?>? onTapJoin,
    ValueChanged<String?>? onTapCatalogue,
    ValueChanged<String?>? onChangedType,
    ValueChanged<int?>? onTapViewCars,
    String selectedAuctionType = 'Auction Live',
  }) {
    return selectedAuctionType == 'Auction Live'
        ? Column(
            children: [
              AppDropdowns.bgDropdown(
                title: 'Auction Live',
                items: ['Auction Live', 'Auction Later'],
                selectedItem: selectedAuctionType,
                onChanged: (value) {
                  onChangedType?.call(value);
                },
              ),
              SizedBox(
                height: Dimensions.getHeight(14),
              ),
              auctionsLive == null || auctionsLive.isEmpty
                  ? AppTexts.smallText(
                      text: 'There are not auctions available at this time')
                  : Wrap(
                      spacing: Dimensions.getWidth(10),
                      runSpacing: Dimensions.getHeight(
                          10), // Vertical spacing between rows
                      children: List.generate(auctionsLive.length, (index) {
                        final auctionInfo = auctionsLive[index];
                        return GestureDetector(
                          onTap: () {
                            onTapViewCars?.call(auctionInfo.id);
                          },
                          child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTexts.mediumText(
                                          text:
                                              auctionInfo.auctionYardName ?? '',
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
                                                  text:
                                                      auctionInfo.auctionTime ??
                                                          ''))
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
                                                  text: auctionInfo
                                                          .locationName ??
                                                      ''))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                _joinWithCarCount(
                                    isCatalogue: auctionInfo.catalogUrl !=
                                                null &&
                                            auctionInfo.catalogUrl!.isNotEmpty
                                        ? true
                                        : false,
                                    onTapCatalogue: () {
                                      if (auctionInfo.id != null) {
                                        onTapCatalogue?.call(
                                            auctionInfo.catalogUrl ?? '');
                                      }
                                    },
                                    onTapJoin: () {
                                      if (auctionInfo.id != null) {
                                        onTapJoin?.call(auctionInfo.id);
                                      }
                                    },
                                    vehicleCount: auctionInfo.totalVehicles)
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
            ],
          )
        : Column(
            children: [
              AppDropdowns.bgDropdown(
                title: 'Auction Later',
                items: ['Auction Live', 'Auction Later'],
                selectedItem: selectedAuctionType,
                onChanged: (value) {
                  onChangedType?.call(value);
                },
              ),
              SizedBox(
                height: Dimensions.getHeight(14),
              ),
              auctionsLater == null || auctionsLater.isEmpty
                  ? AppTexts.smallText(
                      text: 'There are not auctions available at this time')
                  : Wrap(
                      spacing: Dimensions.getWidth(10),
                      runSpacing: Dimensions.getHeight(
                          10), // Vertical spacing between rows
                      children: List.generate(auctionsLater.length, (index) {
                        final auctionInfo = auctionsLater[index];
                        return GestureDetector(
                          onTap: () {
                            onTapViewCars?.call(auctionInfo.id);
                          },
                          child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTexts.mediumText(
                                          text:
                                              auctionInfo.auctionYardName ?? '',
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
                                                  text:
                                                      auctionInfo.auctionTime ??
                                                          ''))
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
                                                  text: auctionInfo
                                                          .locationName ??
                                                      ''))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                _joinWithCarCount(
                                    isCatalogue: auctionInfo.catalogUrl !=
                                                null &&
                                            auctionInfo.catalogUrl!.isNotEmpty
                                        ? true
                                        : false,
                                    onTapCatalogue: () {
                                      if (auctionInfo.id != null) {
                                        onTapCatalogue?.call(
                                            auctionInfo.catalogUrl ?? '');
                                      }
                                    },
                                    onTapJoin: () {
                                      if (auctionInfo.id != null) {
                                        onTapJoin?.call(auctionInfo.id);
                                      }
                                    },
                                    vehicleCount: auctionInfo.totalVehicles)
                              ],
                            ),
                          ),
                        );
                      }),
                    )
            ],
          );
  }
}


Widget _joinWithCarCount({
  int? vehicleCount,
  VoidCallback? onTapJoin,
  VoidCallback? onTapCatalogue,
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
          if (isCatalogue)
            SizedBox(
              height: Get.width * 0.06,
              width: Get.width * 0.15,
              child: AppButtons.textBtnWithStrokeOnly(
                onTap: onTapCatalogue,
                text: 'Catalogue',
                fontSize: Dimensions.mFontSize9,
                padding: Dimensions.getHeight(2),
              ),
            ),
          SizedBox(
            width: Dimensions.getWidth(8),
          ),
          SizedBox(
            width: Get.width * 0.15,
            height: Get.width * 0.06,
            child: AppButtons.textBtnWithStrokeOnly(
              onTap: onTapJoin,
              text: 'Join',
              fontSize: Dimensions.mFontSize9,
              padding: Dimensions.getHeight(2),
            ),
          ),
        ],
      )
    ],
  );
}
