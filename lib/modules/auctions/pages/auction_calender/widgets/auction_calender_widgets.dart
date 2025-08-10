import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AuctionCalenderWidgets {
  AuctionCalenderWidgets._();

  static Widget auctionListBody({
    List<dynamic>? calenderAuctionList,
    ValueChanged<int>? onTapViewCars,
    ValueChanged<String?>? onTapCatalogue,
  }) {
    return _calenderCars(
      calenderAuctionList: calenderAuctionList,
      onTapViewCars: onTapViewCars,
      onTapCatalogue: onTapCatalogue,
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

Widget _calenderCars({
  List<dynamic>? calenderAuctionList,
  ValueChanged<int>? onTapViewCars,
  ValueChanged<String?>? onTapCatalogue,
}) {
  return Column(
    children: [
      _header(title: 'Auctions'),
      SizedBox(
        height: Dimensions.getHeight(14),
      ),
      calenderAuctionList == null || calenderAuctionList.isEmpty
          ? AppTexts.smallText(
              text: 'There are not auctions available at this time')
          : Wrap(
              spacing: Dimensions.getWidth(10),
              runSpacing:
                  Dimensions.getHeight(10), // Vertical spacing between rows
              children: List.generate(calenderAuctionList.length, (index) {
                final auctionInfo = calenderAuctionList[index];
                return GestureDetector(
                  onTap: () {
                    onTapViewCars?.call(auctionInfo['id']);
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTexts.mediumText(
                                  text: auctionInfo['auction_yard_name'] ?? '',
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
                                          text: auctionInfo['auction_time'] ??
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
                                          text: auctionInfo['location_name'] ??
                                              ''))
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                AppIconWidgets.svgAssetIcon(
                                    iconPath: AppSvgIcons.car,
                                    size: Dimensions.getHeight(12)),
                                SizedBox(
                                  width: Dimensions.getWidth(4),
                                ),
                                AppTexts.smallText(
                                    text: '${auctionInfo['total_vehicles'] ?? 0}'),

                              ],
                            ),
                            SizedBox(
                              height: Dimensions.getHeight(35),
                            ),
                            if (auctionInfo['catalog_url'] != null &&
                                auctionInfo['catalog_url'].isNotEmpty)
                              SizedBox(
                                height: Get.width * 0.06,
                                width: Get.width * 0.15,
                                child: AppButtons.textBtnWithStrokeOnly(
                                  onTap: () {
                                    onTapCatalogue
                                        ?.call(auctionInfo['catalog_url']);
                                  },
                                  text: 'Catalogue',
                                  fontSize: Dimensions.mFontSize9,
                                  padding: Dimensions.getHeight(2),
                                ),
                              ),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              }),
            )
    ],
  );
}
