import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';
import 'package:gulf_car_auction/utils/toasts/app_toasts.dart';

class AppCarousalSliders {
  AppCarousalSliders._();

  static Widget carousalSliderWithDotIndicator({
    required List<dynamic> images,
    required ValueChanged<int>? photoTap,
    required CarouselSliderController carouselController,
    ValueChanged<int>? onPageChanged,
    required int currentIndexCarousalSlider,
  }) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {

            photoTap?.call(currentIndexCarousalSlider);
          },
          child: CarouselSlider(
            items: images
                .map(
                  (item) => CachedNetworkImage(
                    imageUrl: item.url ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        AppSkeletons.shimmerContainer(
                      width: double.maxFinite,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppPngIcons.placeholder),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              height: Dimensions.getHeight(217),
              viewportFraction: 1,
              autoPlay: images.length > 1 ? true : false,
              onPageChanged: (index, reason) {
                onPageChanged?.call(index);
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              return _sliderDotIndicator(
                  onTap: () => carouselController.animateToPage(entry.key),
                  bgColor: currentIndexCarousalSlider == entry.key
                      ? AppColors.primaryColor
                      : Colors.transparent);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

Widget _sliderDotIndicator({VoidCallback? onTap, Color? bgColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: Dimensions.getWidth(10),
      height: Dimensions.getWidth(10),
      padding: EdgeInsets.all(Dimensions.getWidth(1.5)),
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.getHeight(12),
          horizontal: Dimensions.getWidth(1)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white),
      ),
      child: Container(
        width: Dimensions.getWidth(7),
        height: Dimensions.getWidth(7),
        // margin: EdgeInsets.symmetric(vertical: Dimensions.getHeight(12), horizontal: Dimensions.getWidth(1)),
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
      ),
    ),
  );
}
