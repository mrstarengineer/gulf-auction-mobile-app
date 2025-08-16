import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class AllVehicleWidgets {
  AllVehicleWidgets._();

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

  static Widget header({
    TextEditingController? searchTextController,
    VoidCallback? onTapFilter,
    VoidCallback? onTapSwitchView,
    ValueChanged<String>? onSearch,
    MSelectedView selectedView = MSelectedView.list,
  }) {
    Debouncer debounce = Debouncer(milliseconds: 500);
    return Padding(
      padding: EdgeInsets.all(Dimensions.getHeight(12)),
      child: Row(
        children: [
          Expanded(
              child: AppTextFields.textFieldHintOnly(
                  controller: searchTextController,
                  hintText: 'Search by Make,Model or Vin',
                  prefixIconSvgPath: AppSvgIcons.search,
                  onChanged: (value) {
                    if (value != null) {
                      debounce.run(() => onSearch?.call(value));
                    }
                  })),
          SizedBox(
            width: Dimensions.getWidth(10),
          ),
          AppButtons.circleButtonStrokeOnly(
              onTap: onTapFilter,
              svgIconPath: AppSvgIcons.filter,
              padding: Dimensions.getWidth(10),
              iconSize: Dimensions.getHeight(16)),
          SizedBox(
            width: Dimensions.getWidth(10),
          ),
          AppButtons.circleButtonStrokeOnly(
              onTap: onTapSwitchView,
              svgIconPath: selectedView == MSelectedView.list
                  ? AppSvgIcons.grid
                  : AppSvgIcons.list,
              padding: Dimensions.getWidth(10),
              iconSize: Dimensions.getWidth(16)),
        ],
      ),
    );
  }

  static Widget body({
    MSelectedView selectedView = MSelectedView.grid,
    VehicleInfo? vehicles,
    Function(bool, int?)? onTapFav,
    bool isLoadingPagination = false,
    ValueChanged<VehicleData?>? onTapDetails,
  }) {
    return selectedView == MSelectedView.list
        ? _topAuctionVehicleBodyListView(
            isLoadingInitial: isLoadingPagination,
            topAuctionVehicles: vehicles,
            isLoading: isLoadingPagination,
            onTapDetails: onTapDetails,
            onTapFav: onTapFav)
        : _topAuctionVehicleBodyGridView(
            isLoading: isLoadingPagination,
            topAuctionVehicles: vehicles,
            onTapDetails: onTapDetails,
            onTapFav: onTapFav);
  }
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
