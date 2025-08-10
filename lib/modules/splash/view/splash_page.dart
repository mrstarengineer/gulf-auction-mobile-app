import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/core/extensions/extensions.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // BG
          Container(
            width: context.screenWidth,
            height: context.screenHeight,
            color: AppColors.black,
          ),

          // Car
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: AppIconWidgets.pngAssetIcon(
                iconPath: AppPngIcons.carSplash,
                height: Dimensions.getWidth(250),
              )),

           // App Logo
           AppIconWidgets.pngAssetIcon(
            iconPath: AppPngIcons.appLogoWithText,
            height: Dimensions.getHeight(120),
            width: Dimensions.getWidth(270),
          )

        ],
      ),
    );
  }
}
