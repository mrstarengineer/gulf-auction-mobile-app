import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';

import '../../../../utils/debonucer/debouncer.dart';

class BidsViewWidgets {
  BidsViewWidgets._();

  static Widget header(
      {TextEditingController? searchTextController,
      VoidCallback? onTapFilter,
      ValueChanged<String>? onSearch}) {
    Debouncer debounce = Debouncer(milliseconds: 500);
    return Padding(
      padding: EdgeInsets.all(Dimensions.getHeight(12)),
      child: Row(
        children: [
          Expanded(
            child: AppTextFields.textFieldHintOnly(
                controller: searchTextController,
                hintText: 'Search by Make, Model or VIN',
                prefixIconSvgPath: AppSvgIcons.search,
                onChanged: (value) {
                  if (value != null) {
                    debounce.run(() => onSearch?.call(value));
                  }
                }),
          ),
          SizedBox(
            width: Dimensions.getWidth(10),
          ),
          AppButtons.circleButtonStrokeOnly(
              onTap: onTapFilter,
              svgIconPath: AppSvgIcons.filter,
              padding: Dimensions.getWidth(10),
              iconSize: Dimensions.getHeight(16)),
        ],
      ),
    );
  }

  static Widget body({
    bool isLoadingPagination = false,
    BidVehiclesInfo? allVehicles,
    required Function(int id) onViewPressed,
    required MBidStatusOptions pageType,
  }) {
    return _allVehiclesListView(
      onViewPressed: onViewPressed,
      isLoadingPagination: isLoadingPagination,
      allVehicles: allVehicles,
      pageType: pageType,
    );
  }
}

Widget _allVehiclesListView({
  bool isLoadingPagination = false,
  BidVehiclesInfo? allVehicles,
  required MBidStatusOptions pageType,
  required Function(int id) onViewPressed,
}) {
  return Wrap(
    spacing: Dimensions.getWidth(10),
    runSpacing: Dimensions.getHeight(10), // Vertical spacing between rows
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
                if (pageType == MBidStatusOptions.vehiclesLoss) {
                  onViewPressed.call(vehicleInfo.vehicleId ?? 0);
                } else {
                  onViewPressed.call(vehicleInfo.id ?? 0);
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
                  children: [
                    _vehicleCarPreview(
                      thumbnailUrl: vehicleInfo.thumbnailUrl,
                    ),
                    SizedBox(
                      width: Dimensions.getWidth(12),
                    ),
                    Expanded(
                      child: _vehicleCarDetails(
                        vin: vehicleInfo.vin,
                        title: vehicleInfo.title,
                        pageType: pageType,
                        bidStatusName: vehicleInfo.bidStatusName,
                        myMaxBid:
                            pageType == MBidStatusOptions.vehiclesOnApproval
                                ? vehicleInfo.sellingPrice
                                : pageType == MBidStatusOptions.preBid
                                    ? vehicleInfo.myMaxBid
                                    : vehicleInfo.currentBidAmount,
                        currentBid: vehicleInfo.currentBidAmount,
                        auctionDate: pageType == MBidStatusOptions.vehiclesWon
                            ? vehicleInfo.saleDate
                            : vehicleInfo.auctionAt,
                      ),
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
          width: Dimensions.getHeight(100),
          height: Dimensions.getHeight(90),
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
          height: Dimensions.getHeight(121),
        ),
        errorWidget: (context, url, error) => Container(
          width: Dimensions.getHeight(132),
          height: Dimensions.getHeight(121),
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
  MBidStatusOptions? pageType,
  String? vin,
  String? bidStatusName,
  String? title,
  dynamic myMaxBid,
  dynamic currentBid,
  String? auctionDate,
}) {
  return Column(
    children: [
      Row(
        children: [
          AppTexts.smallText(text: 'Vin: ', fontWeight: FontWeight.bold),
          Expanded(
              child: AppTexts.smallText(
                  text: vin ?? '', fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(4),
      ),
      Row(
        children: [
          AppTexts.smallText(text: 'Title: ', fontWeight: FontWeight.bold),
          Expanded(
              child: AppTexts.smallText(
                  text: title ?? '', fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(4),
      ),
      Row(
        children: [
          AppTexts.smallText(text: 'My Max Bid: ', fontWeight: FontWeight.bold),
          Expanded(
              child: AppTexts.smallText(
                  text: '${myMaxBid ?? ''}', fontWeight: FontWeight.bold)),
        ],
      ),
      if (pageType == MBidStatusOptions.preBid)
        SizedBox(
          height: Dimensions.getHeight(4),
        ),
      if (pageType == MBidStatusOptions.preBid)
        Row(
          children: [
            AppTexts.smallText(
                text: 'Current Bid: ', fontWeight: FontWeight.bold),
            Expanded(
              child: AppTexts.smallText(
                  text: '${currentBid ?? ''}', fontWeight: FontWeight.bold),
            ),
          ],
        ),
      SizedBox(
        height: Dimensions.getHeight(4),
      ),
      Row(
        children: [
          AppTexts.smallText(
              text: 'Auction Date: ', fontWeight: FontWeight.bold),
          Expanded(
              child: AppTexts.smallText(
                  text: auctionDate ?? '', fontWeight: FontWeight.bold)),
        ],
      ),
      if (pageType == MBidStatusOptions.preBid)
        SizedBox(
          height: Dimensions.getHeight(4),
        ),
      if (pageType == MBidStatusOptions.preBid)
        Row(
          children: [
            AppTexts.smallText(text: 'Status: ', fontWeight: FontWeight.bold),
            Expanded(
                child: AppTexts.smallText(
                    text: bidStatusName ?? '', fontWeight: FontWeight.bold)),
          ],
        ),
    ],
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
          height: Dimensions.getHeight(111),
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
