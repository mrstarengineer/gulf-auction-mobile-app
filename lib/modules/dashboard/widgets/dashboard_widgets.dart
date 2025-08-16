import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class DashboardWidgets {
  DashboardWidgets._();

  static Widget floatingActionBtn (){
    return SizedBox(
      width: Dimensions.getWidth(60),
      height: Dimensions.getWidth(60),
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 5,
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
          },
          child: AppIconWidgets.svgAssetIcon(iconPath: AppSvgIcons.addVehicle,size: Dimensions.getWidth(26)),
        ),
      ),
    );
  }

  static Widget bottomNavBar ({required int currentIndex, required ValueChanged<int> onScreenSelected}){
    return BottomAppBar(
      notchMargin: 0,
      child: Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(8), vertical: Dimensions.getHeight(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navBarItemCard(svgIconPath: AppSvgIcons.home, title: 'Home', isSelected: currentIndex == 0, onTap: () => onScreenSelected.call(0)),
            _navBarItemCard(svgIconPath: AppSvgIcons.streaming, title: 'Join Auction', isSelected: currentIndex == 1, onTap: () => onScreenSelected.call(1)),
            Padding(
              padding: EdgeInsets.only(top: Dimensions.getHeight(40)),
              child: AppTexts.extraSmallText(text: 'Add Vehicle', color: AppColors.baseColor)),
            _navBarItemCard(svgIconPath: AppSvgIcons.homeCar, title: 'All Vehicles', isSelected: currentIndex == 2, onTap: () => onScreenSelected.call(2)),

            _navBarItemCard(svgIconPath: AppSvgIcons.menu, title: 'More', isSelected: currentIndex == 3, onTap: () => onScreenSelected.call(3)),
          ],
        ),
      ),

    );
  }
}

Widget _navBarItemCard ({bool isSelected = false,required String svgIconPath, required String title, VoidCallback? onTap}){
  return   SizedBox(
    width: Dimensions.getWidth(60),
    height: Dimensions.getWidth(60),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primaryColorSuperLight,
        borderRadius: BorderRadius.circular(Dimensions.getWidth(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CircleAvatar(
              backgroundColor: isSelected ? AppColors.red : Colors.transparent,
              radius: Dimensions.getHeight(3),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.getHeight(5)),
              child: AppIconWidgets.svgAssetIcon(
                iconPath: svgIconPath,
                color: isSelected ? AppColors.primaryColor : AppColors.baseColor,
                size: Dimensions.getWidth(19)
              ),
            ),
            AppTexts.extraSmallText(text: title, color:  isSelected ? AppColors.primaryColor : AppColors.baseColor)
          ],
        ),
      ),
    ),
  );
}