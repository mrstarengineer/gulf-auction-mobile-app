import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/more/more.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';

class MorePageWidgets {
  MorePageWidgets._();

  static PreferredSizeWidget appBar(
      {VoidCallback? onTapBack,
      VoidCallback? onTapLogout,
      bool isUserLoggedIn = false}) {
    return AppBar(
      leadingWidth: Dimensions.getHeight(65),
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
        child: AppButtons.circleButtonStrokeOnly(
            onTap: onTapBack,
            svgIconPath: AppSvgIcons.arrowLeft,
            iconSize: Dimensions.getHeight(18)),
      ),
      actions: isUserLoggedIn
          ? [
              AppButtons.circleButtonStrokeOnly(
                  onTap: onTapLogout,
                  padding: Dimensions.getHeight(7),
                  svgIconPath: AppSvgIcons.logout,
                  iconSize: Dimensions.getHeight(13)),
              SizedBox(
                width: Dimensions.getWidth(9),
              ),
            ]
          : null,
    );
  }

  static Widget header(
      {String? profilePicUrl,
      String? name,
      String? accountTypeName,
      String? roleName}) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: profilePicUrl ?? '',
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: Dimensions.getHeight(40),
            backgroundColor: AppColors.lightGrey,
            backgroundImage: imageProvider,
          ),
          placeholder: (context, url) => AppSkeletons.shimmerCircle(
            radius: Dimensions.getHeight(40),
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: AppColors.lightGrey,
            radius: Dimensions.getHeight(40),
            backgroundImage: AssetImage(AppPngIcons.placeholder),
          ),
        ),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.mediumText(text: name ?? ''),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.extraSmallText(
            text: accountTypeName ?? '', color: AppColors.extraLightFontColor),
        SizedBox(
          height: Dimensions.getHeight(5),
        ),
        AppTexts.extraSmallText(
            text: roleName ?? '', color: AppColors.extraLightFontColor),
      ],
    );
  }

  static Widget body({ValueChanged? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ACCOUNT OPTIONS
          _optionsBody(
              title: 'Accounts',
              options: MorePageOptions.accountOptions,
              onTap: onTap),

          SizedBox(
            height: Dimensions.getHeight(24),
          ),

          // BID STATUS OPTIONS
          _optionsBody(
              title: 'Buyer Section',
              options: MorePageOptions.bidStatusOptions,
              onTap: onTap),

          SizedBox(
            height: Dimensions.getHeight(24),
          ),

          // AUCTIONS OPTIONS
          _optionsBody(
              title: 'Auctions',
              options: MorePageOptions.auctionsOptions,
              onTap: onTap),

          SizedBox(
            height: Dimensions.getHeight(24),
          ),

          // SELL MY CAR OPTIONS
          _optionsBody(
              title: 'Seller Section',
              options: MorePageOptions.sellMyCarOptions,
              onTap: onTap),

          SizedBox(
            height: Dimensions.getHeight(24),
          ),

          // PAYMENT OPTIONS
          _optionsBody(
              title: 'Payment',
              options: MorePageOptions.paymentOptions,
              onTap: onTap),

          SizedBox(
            height: Dimensions.getHeight(24),
          ),

          // PAYMENT OPTIONS
          _optionsBody(
              title: 'More',
              options: MorePageOptions.moreOptions,
              onTap: onTap),

          SizedBox(
            height: Dimensions.getHeight(24),
          ),
        ],
      ),
    );
  }
}

Widget _optionsBody(
    {ValueChanged? onTap,
    required List<MorePageOptions> options,
    required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppTexts.mediumText(text: title, color: AppColors.primaryColor),
      SizedBox(
        height: Dimensions.getHeight(16),
      ),
      Wrap(
        spacing: Dimensions.getWidth(22), // Horizontal space between widgets
        runSpacing: Dimensions.getHeight(22),
        children: List.generate(options.length, (index) {
          final optionInfo = options[index];
          return GestureDetector(
            onTap: () {
              onTap?.call(optionInfo.optionName);
            },
            child: SizedBox(
              width: Dimensions.getWidth(70),
              child: Column(
                children: [
                  AppButtons.circleButtonStrokeOnly(
                      padding: Dimensions.getWidth(12),
                      svgIconPath: optionInfo.iconSvgPath),
                  SizedBox(
                    height: Dimensions.getHeight(10),
                  ),
                  AppTexts.smallText(
                      text: optionInfo.title,
                      color: AppColors.lightFontColor,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center)
                ],
              ),
            ),
          );
        }),
      ),
    ],
  );
}
