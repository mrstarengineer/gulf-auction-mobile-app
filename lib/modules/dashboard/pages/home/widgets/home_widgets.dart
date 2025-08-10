import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';

import '../../../../../preference/preference.dart';

class HomeWidgets {
  HomeWidgets._();

  static Widget appBar({
    VoidCallback? onTapSearch,
    VoidCallback? onTapShowAllVehicle,
    VoidCallback? onTapNotification,
    VoidCallback? onTapJoinNow,
    VoidCallback? onTapLogin,
    int? unreadNotificationCount,
    required List<UpcomingAuctionInfo> upcomingAuctions,
    bool isSearchFieldVisible = false,
  }) {
    final isUserLoggedIn =
        Get.find<PreferenceController>().containsKey(PrefsKeys.accessToken);
    return Container(
      color: AppColors.white,
      height: upcomingAuctions.isEmpty && isSearchFieldVisible
          ? Dimensions.getHeight(155)
          : upcomingAuctions.isEmpty && !isSearchFieldVisible
              ? Dimensions.getHeight(80)
              : upcomingAuctions.isNotEmpty && !isSearchFieldVisible
                  ? Dimensions.getHeight(120)
                  : Dimensions.getHeight(195),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
            child: Row(
              children: [
                AppIconWidgets.pngAssetIcon(
                  iconPath: AppPngIcons.gulfLogo2,
                  width: Dimensions.getWidth(115),
                ),
                const Spacer(),
                AppButtons.circleButtonBg(
                  onTap: onTapSearch,
                  svgIconPath: AppSvgIcons.search,
                  bgColor: AppColors.red,
                ),
                SizedBox(
                  width: Dimensions.getWidth(9),
                ),
                isUserLoggedIn
                    ? AppButtons.circleButtonBg(
                        text: unreadNotificationCount,
                        onTap: onTapNotification,
                        svgIconPath: AppSvgIcons.notification,
                        bgColor: AppColors.red,
                      )
                    : AppButtons.btnWithBg(
                        text: 'Login',
                        height: 48,
                        width: 70,
                        onTap: onTapLogin,
                        bgColor: AppColors.red),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.getHeight(isSearchFieldVisible ? 20 : 0),
          ),

          // Search Field
          Visibility(
              visible: isSearchFieldVisible,
              child: GestureDetector(
                onTap: onTapShowAllVehicle,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getWidth(20),
                      vertical: Dimensions.getHeight(12)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    color: AppColors.fillColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.getWidth(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      AppIconWidgets.svgAssetIcon(
                        iconPath: AppSvgIcons.search,
                        color: AppColors.white,
                      ),
                      SizedBox(
                        width: Dimensions.getWidth(8),
                      ),
                      AppTexts.smallText(
                        text: 'Search by Make, Model or VIN',
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: Dimensions.getHeight(upcomingAuctions.isEmpty ? 0 : 20),
          ),

          // Marque Text
          upcomingAuctions.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  padding: EdgeInsets.all(Dimensions.getWidth(8)),
                  margin:
                      EdgeInsets.symmetric(horizontal: Dimensions.getWidth(12)),
                  decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      AppTexts.autoScrollText(
                        text: AppConversions.upcomingAuctionHighlightText(
                            upcomingAuctions),
                        color: AppColors.white,
                      ),
                      _joinNowButton(onTap: onTapJoinNow)
                    ],
                  ),
                ),
          SizedBox(
            height: Dimensions.getHeight(15),
          )
        ],
      ),
    );
  }

  static Widget header({
    required List<UpcomingAuctionInfo> upcomingAuctions,
    String? globalMessage,
    bool isLoadingInitial = false,
    required ValueChanged<int?>? onTapBanner,
  }) {
    return upcomingAuctions.isNotEmpty
        ? SizedBox(
            height: Dimensions.getHeight(
                globalMessage == null || globalMessage.isEmpty ? 160 : 180),
            child: Column(
              children: [
                if (globalMessage != null && globalMessage.isNotEmpty)
                  AppTexts.autoScrollText(text: globalMessage),
                if (globalMessage != null && globalMessage.isNotEmpty)
                  SizedBox(
                    height: Dimensions.getWidth(10),
                  ),
                if (upcomingAuctions.isNotEmpty)
                  Expanded(
                      child: isLoadingInitial
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              child: Row(
                                children: List.generate(
                                    3,
                                    (index) => AppSkeletons.shimmerContainer(
                                        margin: Dimensions.getHeight(10),
                                        width: Dimensions.getWidth(280),
                                        height: Dimensions.getWidth(140))),
                              ),
                            )
                          : buildAuctionSliderWithDots(
                              upcomingAuctions: upcomingAuctions,
                              onTapBanner: onTapBanner)),
              ],
            ),
          )
        : globalMessage != null && globalMessage.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(
                  bottom: Dimensions.getWidth(8),
                ),
                child: AppTexts.autoScrollText(
                  text: globalMessage,
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox.shrink();
  }

  static Widget buildAuctionSliderWithDots({
    required List<UpcomingAuctionInfo> upcomingAuctions,
    required ValueChanged<int?>? onTapBanner,
  }) {
    final pageController = PageController();
    final currentIndex = ValueNotifier(0);

    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: currentIndex,
            builder: (context, value, _) {
              return PageView.builder(
                controller: pageController,
                itemCount: upcomingAuctions.length,
                onPageChanged: (index) => currentIndex.value = index,
                itemBuilder: (context, index) {
                  final auctionInfo = upcomingAuctions[index];
                  return GestureDetector(
                    onTap: () {
                      onTapBanner?.call(auctionInfo.id);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.getWidth(8),
                        right: Dimensions.getWidth(8),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius:
                            BorderRadius.circular(Dimensions.getWidth(8)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.getWidth(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Dimensions.getHeight(12)),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.getWidth(12),
                                      vertical: Dimensions.getHeight(6),
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.getWidth(100)),
                                    ),
                                    child: AppTexts.smallText(
                                      text:  auctionInfo.status==7?'Running Auction':'Upcoming Auction',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.getHeight(10)),
                                  AppTexts.mediumText(
                                    text: auctionInfo.locationName ?? '',
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.oswald,
                                  ),
                                  SizedBox(height: Dimensions.getHeight(6)),
                                  AppTexts.largeText(
                                    text:
                                        auctionInfo.auctionAt?.split(' ')[0] ??
                                            '',
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.oswald,
                                  ),
                                  SizedBox(height: Dimensions.getHeight(2)),
                                  AppTexts.mediumText(
                                    text: auctionInfo.auctionTime ?? '',
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.oswald,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: _upcomingAuctionYardBanner(
                                imageUrl: auctionInfo.auctionYardBanner),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Dots indicator
        SizedBox(height: Dimensions.getWidth(6)),
        ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, index, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(upcomingAuctions.length, (dotIndex) {
                final isActive = dotIndex == index;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 10 : 6,
                  height: isActive ? 10 : 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.3),
                  ),
                );
              }),
            );
          },
        ),
        SizedBox(height: Dimensions.getHeight(4)),
      ],
    );
  }

  static Widget vehicles({
    MSelectedView selectedView = MSelectedView.grid,
    MSortOptions selectedSort = MSortOptions.priceLowToHigh,
    VehicleInfo? vehicles,
    bool isLoading = false,
    bool isLoadingAuctionVehicle = false,
    bool isLoadingInitial = false,
    VoidCallback? onTapFilter,
    VoidCallback? onTapSort,
    VoidCallback? onTapSwitchView,
    ValueChanged<VehicleData?>? onTapDetails,
    Function(bool, int?)? onTapFav,
    required String selectedType,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.getWidth(16),
        vertical: Dimensions.getHeight(8),
      ),
      child: Column(
        children: [
          _topAuctionVehicleHeader(
              selectedType: selectedType,
              onChanged: onChanged,
              selectedSort: selectedSort,
              selectedView: selectedView,
              onTapFilter: onTapFilter,
              onTapSort: onTapSort,
              onTapSwitchView: onTapSwitchView),
          SizedBox(
            height: Dimensions.getHeight(10),
          ),
          selectedView == MSelectedView.list
              ? _topAuctionVehicleBodyListView(
                  isLoadingInitial: isLoadingInitial,
                  isLoadingAuctionVehicle: isLoadingAuctionVehicle,
                  topAuctionVehicles: vehicles,
                  isLoading: isLoading,
                  onTapDetails: onTapDetails,
                  onTapFav: onTapFav)
              : _topAuctionVehicleBodyGridView(
                  isLoadingInitial: isLoadingInitial,
                  isLoadingAuctionVehicle: isLoadingAuctionVehicle,
                  isLoading: isLoading,
                  topAuctionVehicles: vehicles,
                  onTapDetails: onTapDetails,
                  onTapFav: onTapFav),
        ],
      ),
    );
  }
}

Widget _topAuctionVehicleHeader({
  MSelectedView selectedView = MSelectedView.grid,
  MSortOptions selectedSort = MSortOptions.none,
  VoidCallback? onTapFilter,
  VoidCallback? onTapSort,
  VoidCallback? onTapSwitchView,
  required String selectedType,
  required void Function(String?) onChanged,
}) {
  return Row(
    children: [
      Expanded(
        child: AppDropdowns.simpleDropdown<String>(
          title: 'All',
          items: ['Listed Vehicle', 'Upcoming Auction', 'All'],
          selectedItem: selectedType,
          onChanged: onChanged,
        ),
      ),
      SizedBox(
        width: Dimensions.getWidth(7),
      ),
      // Expanded(
      //     child: AppTexts.mediumText(text: 'All', fontWeight: FontWeight.w500)),
      AppButtons.circleButtonStrokeOnly(
          onTap: onTapFilter,
          svgIconPath: AppSvgIcons.filter,
          padding: Dimensions.getWidth(10),
          iconSize: Dimensions.getWidth(16)),
      SizedBox(
        width: Dimensions.getWidth(7),
      ),
      AppButtons.circleButtonStrokeOnly(
          onTap: onTapSort,
          svgIconPath: selectedSort == MSortOptions.priceLowToHigh
              ? AppSvgIcons.sortBottomToTop
              : selectedSort == MSortOptions.priceHighToLow
                  ? AppSvgIcons.sortTopToBottom
                  : AppSvgIcons.sort,
          padding: Dimensions.getWidth(10),
          iconSize: Dimensions.getWidth(16)),
      SizedBox(
        width: Dimensions.getWidth(7),
      ),
      AppButtons.circleButtonStrokeOnly(
          onTap: onTapSwitchView,
          svgIconPath: selectedView == MSelectedView.list
              ? AppSvgIcons.grid
              : AppSvgIcons.list,
          padding: Dimensions.getWidth(10),
          iconSize: Dimensions.getWidth(16)),
    ],
  );
}

Widget _topAuctionVehicleBodyGridView({
  bool isLoading = false,
  bool isLoadingInitial = false,
  bool isLoadingAuctionVehicle = false,
  VehicleInfo? topAuctionVehicles,
  ValueChanged<VehicleData?>? onTapDetails,
  Function(bool, int?)? onTapFav,
}) {
  return isLoadingInitial || isLoadingAuctionVehicle
      ? DynamicHeightGridView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          builder: (ctx, index) =>
              _topAuctionVehicleSkeleton(selectedView: MSelectedView.grid),
        )
      : DynamicHeightGridView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: (topAuctionVehicles?.data?.length ?? 0) + 1,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          builder: (ctx, index) {
            if (index < (topAuctionVehicles?.data?.length ?? 0)) {
              final vehicleInfo = topAuctionVehicles!.data![index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        onTapDetails?.call(vehicleInfo);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.getWidth(10))),
                          boxShadow: AppShadow.cardShadow,
                        ),
                        child: Column(
                          children: [
                            _topAuctionVehicleCarPreview(
                                thumbnailUrl: vehicleInfo.thumbnailUrl,
                                isFav: vehicleInfo.isWatched ?? false,
                                isListView: false,
                                tag: (vehicleInfo.isUpcoming ?? false)
                                    ? 'COMING SOON'
                                    : 'SALE',
                                onTapFav: (isWatched) {
                                  onTapFav?.call(isWatched, vehicleInfo.id);
                                }),
                            _topAuctionVehicleDetails(
                                title: vehicleInfo.title,
                                engineType: vehicleInfo.engineType,
                                drive: vehicleInfo.drive,
                                fuelType: vehicleInfo.fuelType,
                                odometer: vehicleInfo.odometer,
                                nextBidAmount: vehicleInfo.categoryId == 2
                                    ? vehicleInfo.sellingPrice != null
                                        ? '${vehicleInfo.sellingPrice}'
                                        : '0'
                                    : vehicleInfo.startBidAmount != null
                                        ? '${vehicleInfo.startBidAmount}'
                                        : '0',
                                vehicleType: vehicleInfo.categoryId == 2
                                    ? MVehicleType.buyNow
                                    : MVehicleType.auction,
                                onTapBid: () {
                                  onTapDetails?.call(vehicleInfo);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return isLoading
                  ? _topAuctionVehicleSkeleton(selectedView: MSelectedView.grid)
                  : const SizedBox.shrink();
            }
          });
}

Widget _topAuctionVehicleBodyListView({
  bool isLoading = false,
  bool isLoadingInitial = false,
  bool isLoadingAuctionVehicle = false,
  VehicleInfo? topAuctionVehicles,
  ValueChanged<VehicleData?>? onTapDetails,
  Function(bool, int?)? onTapFav,
}) {
  return isLoadingInitial || isLoadingAuctionVehicle
      ? Wrap(
          spacing: Dimensions.getWidth(10),
          runSpacing: Dimensions.getHeight(10),
          children: List.generate(
              4,
              (index) =>
                  _topAuctionVehicleSkeleton(selectedView: MSelectedView.list)),
        )
      : Wrap(
          spacing: Dimensions.getWidth(10),
          runSpacing: Dimensions.getHeight(10), // Vertical spacing between rows
          children: List.generate((topAuctionVehicles?.data?.length ?? 0) + 1,
              (index) {
            if (index < (topAuctionVehicles?.data?.length ?? 0)) {
              final vehicleInfo = topAuctionVehicles!.data![index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        onTapDetails?.call(vehicleInfo);
                      },
                      child: Container(
                        width: double.maxFinite,
                        // Half width of screen with margin adjustment
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.getWidth(10))),
                          boxShadow: AppShadow.cardShadow,
                        ),
                        child: Row(
                          children: [
                            _topAuctionVehicleCarPreview(
                                thumbnailUrl: vehicleInfo.thumbnailUrl,
                                isFav: vehicleInfo.isWatched ?? false,
                                isListView: true,
                                tag: (vehicleInfo.isUpcoming ?? false)
                                    ? 'COMING SOON'
                                    : 'SALE',
                                onTapFav: (isWatched) {
                                  onTapFav?.call(isWatched, vehicleInfo.id);
                                }),
                            Expanded(
                              child: _topAuctionVehicleDetails(
                                  title: vehicleInfo.title,
                                  engineType: vehicleInfo.engineType,
                                  drive: vehicleInfo.drive,
                                  fuelType: vehicleInfo.fuelType,
                                  odometer: vehicleInfo.odometer,
                                  nextBidAmount: vehicleInfo.categoryId == 2
                                      ? vehicleInfo.sellingPrice != null
                                          ? '${vehicleInfo.sellingPrice}'
                                          : '0'
                                      : vehicleInfo.startBidAmount != null
                                          ? '${vehicleInfo.startBidAmount}'
                                          : '0',
                                  vehicleType: vehicleInfo.categoryId == 2
                                      ? MVehicleType.buyNow
                                      : MVehicleType.auction,
                                  onTapBid: () {
                                    onTapDetails?.call(vehicleInfo);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return isLoading
                  ? _topAuctionVehicleSkeleton(selectedView: MSelectedView.list)
                  : const SizedBox.shrink();
            }
          }),
        );
}

Widget _upcomingAuctionYardBanner({String? imageUrl}) {
  return imageUrl == null || imageUrl.isEmpty
      ? const SizedBox.shrink()
      : Container(
          height: Dimensions.getHeight(110),
          width: Dimensions.getWidth(189),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ResizeImage(NetworkImage(imageUrl),
                      width: 500, height: 500),
                  fit: BoxFit.fill)),
        );
}

Widget _topAuctionVehicleCarPreview({
  String? thumbnailUrl,
  ValueChanged<bool>? onTapFav,
  bool isFav = false,
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

      // FAV ICON
      Positioned(
        top: 5,
        right: 5,
        child: AppButtons.circleButtonBg(
            onTap: () {
              onTapFav?.call(!isFav);
            },
            svgIconPath: isFav ? AppSvgIcons.heartFilled : AppSvgIcons.heart,
            bgColor: AppColors.black.withOpacity(0.51),
            padding: Dimensions.getWidth(5),
            iconSize: Dimensions.getWidth(13)),
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

Widget _topAuctionVehicleDetails(
    {String? title,
    String? engineType,
    String? odometer,
    String? fuelType,
    String? drive,
    String? nextBidAmount,
    VoidCallback? onTapBid,
    MVehicleType vehicleType = MVehicleType.auction}) {
  return Padding(
    padding: EdgeInsets.all(Dimensions.getWidth(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.smallText(text: title ?? '', fontWeight: FontWeight.bold),
        SizedBox(height: Dimensions.getHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            engineType == null
                ? const SizedBox.shrink()
                : Flexible(
                    child: Column(
                      children: [
                        AppIconWidgets.svgAssetIcon(
                            iconPath: AppSvgIcons.engine,
                            size: Dimensions.getWidth(16)),
                        AppTexts.extraSmallText(
                            text: engineType,
                            color: AppColors.extraLightFontColor),
                      ],
                    ),
                  ),
            odometer == null
                ? const SizedBox.shrink()
                : Flexible(
                    child: Column(
                      children: [
                        AppIconWidgets.svgAssetIcon(
                            iconPath: AppSvgIcons.road,
                            size: Dimensions.getWidth(16)),
                        AppTexts.extraSmallText(
                            text: odometer,
                            color: AppColors.extraLightFontColor),
                      ],
                    ),
                  ),
            fuelType == null
                ? const SizedBox.shrink()
                : Flexible(
                    child: Column(
                      children: [
                        AppIconWidgets.svgAssetIcon(
                            iconPath: AppSvgIcons.fuelType,
                            size: Dimensions.getWidth(16)),
                        AppTexts.extraSmallText(
                            text: fuelType,
                            color: AppColors.extraLightFontColor),
                      ],
                    ),
                  ),
            drive == null
                ? const SizedBox.shrink()
                : Flexible(
                    child: Column(
                      children: [
                        AppIconWidgets.svgAssetIcon(
                            iconPath: AppSvgIcons.chassis,
                            size: Dimensions.getWidth(16)),
                        AppTexts.extraSmallText(
                            text: drive, color: AppColors.extraLightFontColor),
                      ],
                    ),
                  ),
          ],
        ),
        SizedBox(height: Dimensions.getHeight(10)),
        Row(
          children: [
            nextBidAmount == null
                ? const SizedBox.shrink()
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTexts.mediumText(
                            text: nextBidAmount == '0'
                                ? 'AED **'
                                : 'AED $nextBidAmount',
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                        vehicleType == MVehicleType.auction
                            ? AppTexts.extraSmallText(
                                text: 'Starting Bid',
                                color: AppColors.extraLightFontColor)
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
            AppButtons.circleButtonStrokeOnly(
                onTap: onTapBid,
                svgIconPath: AppSvgIcons.arrowRight,
                iconSize: Dimensions.getWidth(15))
          ],
        )
      ],
    ),
  );
}

Widget _joinNowButton({VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.getWidth(12),
          vertical: Dimensions.getHeight(2)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Dimensions.getWidth(6))),
      child:
          AppTexts.smallText(text: 'Join Now', color: AppColors.redFontColor),
    ),
  );
}

Widget _topAuctionVehicleSkeleton(
    {MSelectedView selectedView = MSelectedView.grid}) {
  return Container(
    // padding: EdgeInsets.only(right: Dimensions.getWidth(10)),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.getWidth(10))),
      boxShadow: AppShadow.cardShadow,
    ),
    child: selectedView == MSelectedView.grid
        ? Column(
            children: [
              AppSkeletons.shimmerContainer(
                height: Dimensions.getHeight(111),
              ),
              SizedBox(
                width: Dimensions.getWidth(10),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.getWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeletons.shimmerContainer(
                        height: Dimensions.getHeight(15),
                        width: Get.width * 0.35),
                    SizedBox(
                      height: Dimensions.getHeight(20),
                    ),
                    AppSkeletons.shimmerContainer(
                        height: Dimensions.getHeight(25)),
                    SizedBox(
                      height: Dimensions.getHeight(20),
                    ),
                    AppSkeletons.shimmerContainer(
                        height: Dimensions.getHeight(15),
                        width: Get.width * 0.2),
                  ],
                ),
              )
            ],
          )
        : Row(
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
                        height: Dimensions.getHeight(15),
                        width: Get.width * 0.35),
                    SizedBox(
                      height: Dimensions.getHeight(20),
                    ),
                    AppSkeletons.shimmerContainer(
                        height: Dimensions.getHeight(25)),
                    SizedBox(
                      height: Dimensions.getHeight(20),
                    ),
                    AppSkeletons.shimmerContainer(
                        height: Dimensions.getHeight(15),
                        width: Get.width * 0.2),
                  ],
                ),
              ))
            ],
          ),
  );
}
