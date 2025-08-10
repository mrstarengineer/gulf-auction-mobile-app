import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/auction/auction.dart';
import 'package:gulf_car_auction/models/models.dart' as model;
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class AuctionBidLiveWidgets {
  AuctionBidLiveWidgets._();

  static Widget header({
    required List<model.VehicleImages> images,
    required CarouselSliderController carouselController,
    ValueChanged<int>? onPageChanged,
    required int currentIndexCarousalSlider,
    required ValueChanged<int>? photoTap,
  }) {
    return images.isEmpty
        ? const SizedBox.shrink()
        : AppCarousalSliders.carousalSliderWithDotIndicator(
            images: images,
            photoTap: photoTap,
            carouselController: carouselController,
            currentIndexCarousalSlider: currentIndexCarousalSlider,
            onPageChanged: onPageChanged);
  }

  static Widget auctionEndedBody({String? title}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTexts.mediumText(
              text: 'Auction Ended !!', fontWeight: FontWeight.bold),
          SizedBox(
            height: Dimensions.getHeight(8),
          ),
          AppTexts.mediumText(text: title ?? '', fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  static Widget body({
    bool isBidInfoShow = false,
    bool eligibleForBidding = false,
    bool isBidBtnEnabled = true,
    VoidCallback? onTapBid,
    VoidCallback? onTapBidIncrement,
    VoidCallback? onTapBidDecrement,
    String? currentBidAmount,
    int? minimumBidAmount,
    int? nextBidAmount,
    String? participants,
    String? auctionMessage,
    String? carName,
    String? vin,
    String? sequence,
    String? driveTrain,
    String? odometer,
    String? bodyStyle,
    String? color,
    String? primaryDamage,
    String? engineType,
    String? documentType,
    // String? secondaryDamage,
    // String? cylinder,
    Color? bidBgColor,
    required dynamic upcomingVehicle,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _bidInfoBody(
                    vin: vin,
                    sequence: sequence,
                    driveTrain: driveTrain,
                    odometer: odometer,
                    bodyStyle: bodyStyle,
                    color: color,
                    primaryDamage: primaryDamage,
                    engineType: engineType,
                    documentType: documentType,
                    // secondaryDamage: secondaryDamage,
                    // cylinder: cylinder,
                  ),
                ),
                SizedBox(
                  width: Dimensions.getWidth(12),
                ),
                Expanded(
                  child: Column(
                    children: [
                      participants == null
                          ? const SizedBox.shrink()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppIconWidgets.svgAssetIcon(
                                    iconPath: AppSvgIcons.user,
                                    color: AppColors.baseColor,
                                    size: Dimensions.getHeight(14)),
                                SizedBox(
                                  width: Dimensions.getWidth(4),
                                ),
                                AppTexts.smallText(
                                    text: '$participants Participants'),
                              ],
                            ),
                      SizedBox(
                        height:
                            Dimensions.getHeight(participants == null ? 0 : 12),
                      ),
                      AppTexts.smallText(
                          text: carName ?? '',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: Dimensions.getHeight(12),
                      ),
                      _bidButton(
                        eligibleForBidding: eligibleForBidding,
                        isBidInfoShow: isBidInfoShow,
                        auctionMessage: auctionMessage,
                        minimumBidAmount: '${minimumBidAmount ?? 0}',
                        currentBidAmount: currentBidAmount,
                        nextBidAmount: nextBidAmount ?? 0,
                        onTapPlus: onTapBidIncrement,
                        onTapMinus: onTapBidDecrement,
                        bidBgColor: bidBgColor,
                        onTapBid: () {
                          if (isBidBtnEnabled) {
                            onTapBid?.call();
                          } else {
                            AppToasts.shortToast(
                                'Processing your bid, wait a moment!');
                          }
                        },
                        isBidBtnEnabled: isBidBtnEnabled,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
            AppTexts.smallText(
                text: 'Upcoming Lots (${upcomingVehicle?.length ?? 0})'),
            SizedBox(
              height: Dimensions.getHeight(6),
            ),
            _upcomingVehicles(upcomingVehicle: upcomingVehicle),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _upcomingVehicles({required dynamic upcomingVehicle}) {
  return Wrap(
    spacing: Dimensions.getWidth(10),
    runSpacing: Dimensions.getHeight(10), // Vertical spacing between rows
    children: List.generate(upcomingVehicle?.length ?? 0, (index) {
      VehicleDetail record = upcomingVehicle.elementAt(index);
      return AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 375),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Container(
              width: double.maxFinite,
              // Half width of screen with margin adjustment
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.getWidth(10))),
                boxShadow: AppShadow.cardShadow,
              ),
              child: Row(
                children: [
                  _topAuctionVehicleCarPreview(
                    thumbnailUrl: record.thumbnailUrl,
                    isListView: true,
                  ),
                  Expanded(
                    child: _topAuctionVehicleDetails(
                        title:
                            '${record.year ?? ''} ${record.make ?? ''} ${record.model ?? ''}',
                        lotNo: record.lotNumber,
                        serial: record.serial,
                        odometer: record.odometer,
                        startBidAmount: record.startBidAmount),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }),
  );
}

Widget _topAuctionVehicleDetails({
  String? title,
  String? lotNo,
  String? serial,
  int? odometer,
  int? startBidAmount,
}) {
  return Padding(
    padding: EdgeInsets.all(Dimensions.getWidth(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.smallText(text: title ?? '', fontWeight: FontWeight.bold),
        SizedBox(height: Dimensions.getHeight(6)),
        lotNo == null || lotNo.isEmpty
            ? const SizedBox.shrink()
            : AppTexts.extraSmallText(text: 'Lot: $lotNo'),
        SizedBox(height: Dimensions.getHeight(6)),
        serial == null || serial.isEmpty
            ? const SizedBox.shrink()
            : AppTexts.extraSmallText(text: 'Sequence: $serial'),
        SizedBox(height: Dimensions.getHeight(6)),
        odometer == null
            ? const SizedBox.shrink()
            : AppTexts.extraSmallText(text: 'Odometer: $odometer'),
        SizedBox(height: Dimensions.getHeight(6)),
        startBidAmount == null
            ? const SizedBox.shrink()
            : AppTexts.extraSmallText(
                text: 'Start bid amount: $startBidAmount'),
      ],
    ),
  );
}

Widget _topAuctionVehicleCarPreview({
  String? thumbnailUrl,
  bool isListView = false,
  String? tag,
}) {
  return Stack(
    children: [
      CachedNetworkImage(
        imageUrl: thumbnailUrl ?? '',
        imageBuilder: (context, imageProvider) => Container(
          width: isListView ? Dimensions.getHeight(132) : null,
          height: Dimensions.getHeight(111),
          decoration: BoxDecoration(
            borderRadius: isListView
                ? BorderRadius.horizontal(
                    left: Radius.circular(Dimensions.getWidth(10)))
                : BorderRadius.vertical(
                    top: Radius.circular(Dimensions.getWidth(10))),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => AppSkeletons.shimmerContainer(
          width: isListView ? Dimensions.getHeight(132) : null,
          height: Dimensions.getHeight(111),
        ),
        errorWidget: (context, url, error) => Container(
          width: isListView ? Dimensions.getHeight(132) : null,
          height: Dimensions.getHeight(111),
          decoration: BoxDecoration(
            borderRadius: isListView
                ? BorderRadius.horizontal(
                    left: Radius.circular(Dimensions.getWidth(10)))
                : BorderRadius.vertical(
                    top: Radius.circular(Dimensions.getWidth(10))),
            image: DecorationImage(
              image: AssetImage(AppPngIcons.placeholder),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      // TAG
      tag == null || tag.isEmpty
          ? const SizedBox.shrink()
          : Positioned(
              top: 5,
              left: 5,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getWidth(8),
                    vertical: Dimensions.getHeight(4)),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(Dimensions.getWidth(8)),
                    border:
                        Border.all(color: AppColors.primaryColor, width: 0.5)),
                child: AppTexts.extraSmallText(text: tag),
              ),
            ),
    ],
  );
}

Widget _bidButton(
    {bool isBidInfoShow = false,
    bool eligibleForBidding = false,
    bool isBidBtnEnabled = true,
    Color? bidBgColor,
    String? minimumBidAmount,
    String? auctionMessage,
    String? currentBidAmount,
    required int nextBidAmount,
    VoidCallback? onTapBid,
    VoidCallback? onTapPlus,
    VoidCallback? onTapMinus}) {
  return Container(
    alignment: Alignment.center,
    width: double.maxFinite,
    padding: EdgeInsets.all(Dimensions.getHeight(12)),
    decoration: BoxDecoration(
        color: bidBgColor,
        borderRadius: BorderRadius.circular(Dimensions.getHeight(6))),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppPngIcons.dirham,
              height: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            AppTexts.largeText(
                text: (!isBidInfoShow || currentBidAmount == '0')
                    ? '${nextBidAmount ?? '0'}'
                    : currentBidAmount ?? '0',
                color: AppColors.baseFontColor,
                fontWeight: FontWeight.bold),
          ],
        ),
        if (auctionMessage != null && auctionMessage.isNotEmpty)
          SizedBox(
            height: Dimensions.getHeight(8),
          ),
        if (auctionMessage != null && auctionMessage.isNotEmpty)
          AppTexts.extraSmallText(
              text: auctionMessage,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold),
        // SizedBox(
        //   height: Dimensions.getHeight(8),
        // ),
        // AppTexts.extraSmallText(
        //     text: 'All Bid is in AED', color: AppColors.primaryColor),
        SizedBox(
          height: Dimensions.getHeight(12),
        ),

        // BID
        (() {
          if (eligibleForBidding) {
            if (isBidInfoShow) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: AppButtons.btnWithBg(
                              onTap: onTapPlus,
                              text: '+',
                              padding: Dimensions.getHeight(4),
                              bgColor: AppColors.baseColor.withOpacity(0.5),
                              textColor: AppColors.white)),
                      SizedBox(
                        width: Dimensions.getWidth(12),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.getHeight(4),
                              horizontal: Dimensions.getWidth(8)),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.getHeight(4))),
                          child: AppTexts.smallText(
                              text: '$nextBidAmount',
                              color: AppColors.baseFontColor),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.getWidth(12),
                      ),
                      Expanded(
                          flex: 1,
                          child: AppButtons.btnWithBg(
                              onTap: onTapMinus,
                              text: '-',
                              padding: Dimensions.getHeight(4),
                              bgColor: AppColors.baseColor.withOpacity(0.5),
                              textColor: AppColors.white))
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.getHeight(12),
                  ),
                  AppButtons.btnWithBg(
                    onTap: onTapBid,
                    text: 'BID',
                    bgColor: isBidBtnEnabled
                        ? AppColors.primaryColor
                        : AppColors.baseColor.withOpacity(0.5),
                    textColor: isBidBtnEnabled
                        ? AppColors.white
                        : AppColors.baseFontColor,
                  )
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return AppTexts.smallText(
              text: 'You are not eligible for bidding!',
              color: AppColors.primaryColor,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              fontWeight: FontWeight.bold,
            );
          }
        }())
      ],
    ),
  );
}

Widget _bidInfoBody({
  String? vin,
  String? sequence,
  String? driveTrain,
  String? odometer,
  String? bodyStyle,
  String? color,
  String? primaryDamage,
  String? engineType,
  String? documentType,
  // String? secondaryDamage,
  // String? cylinder,
}) {
  return Column(
    children: [
      _infoField(title: 'VIN', value: vin),
      _infoField(title: 'Sequence', value: sequence),
      _infoField(title: 'DRIVE TRAIN', value: driveTrain),
      _infoField(title: 'ODOMETER', value: odometer),
      _infoField(title: 'BODY STYLE', value: bodyStyle),
      _infoField(title: 'COLOR', value: color),
      _infoField(title: 'PRIMARY DAMAGE', value: primaryDamage),
      _infoField(title: 'ENGINE TYPE', value: engineType),
      _infoField(title: 'DOCUMENT TYPE', value: documentType),
      // _infoField(title: 'SECONDARY DAMAGE', value: secondaryDamage),
      // _infoField(title: 'CYLINDER', value: cylinder),
    ],
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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTexts.extraSmallText(
            text: title.toUpperCase(), color: AppColors.grey),
        SizedBox(
          width: Dimensions.getWidth(6),
        ),
        Flexible(
            child: AppTexts.extraSmallText(
                text: value == null || value == 'null' || value.isEmpty
                    ? 'N/A'
                    : value,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.end)),
      ],
    ),
  );
}
