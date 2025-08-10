import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';

class WatchedVehiclesWidgets {
  WatchedVehiclesWidgets._();

  static Widget body ({
    MSelectedView selectedView = MSelectedView.grid,
    VehicleInfo? vehicles,
    Function(bool, int?)? onTapFav,
    bool isLoadingPagination = false,
    ValueChanged<VehicleData?>? onTapDetails,
  }){
    return ((){
      if(selectedView == MSelectedView.list){
        return _allVehiclesListView(
          allVehicles: vehicles,
          isLoadingPagination: isLoadingPagination,
          onTapDetails: onTapDetails,
          onTapFav: onTapFav,
        );
      } else {
        return _topAuctionVehicleBodyGridView(
          isLoadingPagination: isLoadingPagination,
          allVehicles: vehicles,
          onTapDetails: onTapDetails,
          onTapFav: onTapFav,
        );
      }
    }());
  }
}

Widget _topAuctionVehicleBodyGridView({
  bool isLoadingPagination = false,
  VehicleInfo? allVehicles,
  Function(bool, int?)? onTapFav,
  ValueChanged<VehicleData?>? onTapDetails,
}) {
  return DynamicHeightGridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (allVehicles?.data?.length ?? 0) + 1,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      builder: (ctx, index) {
        if (index < (allVehicles?.data?.length ?? 0)) {
          final vehicleInfo = allVehicles!.data![index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: (){
                    onTapDetails?.call(vehicleInfo);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: index.isEven ? Dimensions.getHeight(12) : 0, right: index.isOdd ? Dimensions.getHeight(12) : 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.getWidth(10))),
                      boxShadow: AppShadow.cardShadow,
                    ),
                    child: Column(
                      children: [
                        _vehicleCarPreview(
                            thumbnailUrl: vehicleInfo.thumbnailUrl,
                            isFav: vehicleInfo.isWatched ?? false,
                            isListView: false,
                            tag: (vehicleInfo.isUpcoming ?? false) ? 'COMING SOON' : 'SALE',
                            onTapFav: (isWatched){
                              onTapFav?.call(isWatched, vehicleInfo.id);
                            }
                        ),
                        _vehicleDetails(
                            title: vehicleInfo.title,
                            engineType: vehicleInfo.engineType,
                            drive: vehicleInfo.drive,
                            fuelType: vehicleInfo.fuelType,
                            odometer: vehicleInfo.odometer,
                            nextBidAmount: '${vehicleInfo.nextBidAmount}',
                            vehicleType: vehicleInfo.categoryId == 2 ? MVehicleType.buyNow : MVehicleType.auction,
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
          return isLoadingPagination
              ? _vehicleSkeleton(selectedView: MSelectedView.grid)
              : const SizedBox.shrink();
        }
      });
}

Widget _allVehiclesListView({
  bool isLoadingPagination = false,
  VehicleInfo? allVehicles,
  Function(bool, int?)? onTapFav,
  ValueChanged<VehicleData?>? onTapDetails,
}) {
  return Wrap(
    spacing: Dimensions.getWidth(10),
    runSpacing: Dimensions.getHeight(10), // Vertical spacing between rows
    children:
    List.generate((allVehicles?.data?.length ?? 0) + 1, (index) {
      if (index < (allVehicles?.data?.length ?? 0)) {
        final vehicleInfo = allVehicles!.data![index];
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: GestureDetector(
                onTap: (){
                  onTapDetails?.call(vehicleInfo);
                },
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: Dimensions.getHeight(12), right: Dimensions.getHeight(12), top: index == 0 ? Dimensions.getHeight(6) : 0),
                  // Half width of screen with margin adjustment
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
                          isFav: vehicleInfo.isWatched ?? false,
                          isListView: true,
                          tag: (vehicleInfo.isUpcoming ?? false) ? 'COMING SOON' : 'SALE',
                          onTapFav: (isWatched){
                            onTapFav?.call(isWatched, vehicleInfo.id);
                          }
                      ),
                      Expanded(
                        child: _vehicleDetails(
                            title: vehicleInfo.title,
                            engineType: vehicleInfo.engineType,
                            drive: vehicleInfo.drive,
                            fuelType: vehicleInfo.fuelType,
                            odometer: vehicleInfo.odometer,
                            nextBidAmount: '${vehicleInfo.nextBidAmount}',
                            vehicleType: vehicleInfo.categoryId == 2 ? MVehicleType.buyNow : MVehicleType.auction,
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
        return isLoadingPagination
            ? _vehicleSkeleton(selectedView: MSelectedView.list)
            : const SizedBox.shrink();
      }
    }),
  );
}

Widget _vehicleCarPreview({
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
      tag == null || tag.isEmpty ? const SizedBox.shrink() : Positioned(
        top: 5,
        left: 5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(8), vertical: Dimensions.getHeight(4)),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Dimensions.getWidth(8)),
              border: Border.all(color: AppColors.primaryColor, width: 0.5)
          ),
          child: AppTexts.extraSmallText(text: tag),
        ),
      ),
    ],
  );
}

Widget _vehicleDetails(
    {String? title,
      String? engineType,
      String? odometer,
      String? fuelType,
      String? drive,
      String? nextBidAmount,
      VoidCallback? onTapBid,
      required MVehicleType vehicleType,
    }) {
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
                      text: 'AED $nextBidAmount',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                  vehicleType == MVehicleType.auction
                      ? AppTexts.extraSmallText(
                      text: 'Starting Bid',
                      color: AppColors.extraLightFontColor) : const SizedBox.shrink()
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

Widget _vehicleSkeleton(
    {MSelectedView selectedView = MSelectedView.grid}) {
  return Container(
    margin: EdgeInsets.only(left: Dimensions.getHeight(12), right: Dimensions.getHeight(12)),
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
