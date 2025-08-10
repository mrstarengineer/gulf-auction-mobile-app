
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:shimmer/shimmer.dart';

class AppSkeletons {

  AppSkeletons._();
  static Widget shimmerCircle(
      {Color? baseColor, Color? highlightColor, double? radius}) =>
      Shimmer.fromColors(
          baseColor: baseColor ?? AppColors.skeletonColor1,
          highlightColor: highlightColor ?? AppColors.skeletonColor2,
          child: CircleAvatar(
            radius: radius,
          ));

  static Widget shimmerContainer(
      { double? height,
        double? width,
        double? margin,
        Color? baseColor,
        Color? highlightColor,
        double? radius}) =>
      Shimmer.fromColors(
          baseColor: baseColor ?? AppColors.skeletonColor1,
          highlightColor: highlightColor ?? AppColors.skeletonColor2,
          child: Container(
            height: height,
            width: width,
            margin: EdgeInsets.all(margin ?? 0),
            decoration: BoxDecoration(
              color: AppColors.skeletonColor1,
              borderRadius: BorderRadius.circular(radius ?? Dimensions.getWidth(10)),
            ),
          ));
}