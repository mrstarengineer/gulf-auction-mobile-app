import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';

import '../../../global/global.dart';

class NotificationWidgets {
  NotificationWidgets._();

  static PreferredSizeWidget appBar(
      {VoidCallback? onTapBack, required String title, VoidCallback? onTapMarkAllAsRead}) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leadingWidth: Dimensions.getHeight(65),
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
        child: AppButtons.circleButtonStrokeOnly(
            onTap: onTapBack ?? () => Get.back(),
            svgIconPath: AppSvgIcons.arrowLeft,
            color: AppColors.white,
            strokeColor: AppColors.white,
            iconSize: Dimensions.getHeight(18)),
      ),
      title: AppTexts.smallText(text: title, color: AppColors.white),
      centerTitle: true,
      actions: [
        Center(child: AppButtons.textButton(
            onTap: onTapMarkAllAsRead,
            text: 'Mark all as read', color: AppColors.white)),
        SizedBox(width: Dimensions.getWidth(12),)
      ],
    );
  }

  static Widget tabBar({
    TabController? controller,
    required String title1,
    required String title2,
  }) {
    return TabBar(
      indicatorColor: AppColors.primaryColor,
      labelStyle: TextStyle(
          color: AppColors.baseFontColor,
          fontFamily: AppFonts.mulish,
          fontSize: Dimensions.mFontSize16),
      controller: controller,
      tabs: [
        Tab(
          text: title1,
        ),
        Tab(text: title2),
      ],
    );
  }

  static Widget notificationsBody({required bool isLoadingInitial,
    required bool isLoading,
    NotificationInfo? notifications, ValueChanged<NotificationData>? onTap}) {
   return (() {
      if (isLoadingInitial) {
        return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) => _notificationCardSkeleton(),
            separatorBuilder: (context, index) =>
                SizedBox(
                  height: Dimensions.getHeight(10),
                ),
            itemCount: 4);
      } else if( (notifications?.data?.length ?? 0) == 0){
        return AppAlertMessages.emptyAlert();
      } else {
        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          separatorBuilder: (_, index) =>
              SizedBox(
                height: Dimensions.getHeight(10),
              ),
          itemCount: (notifications?.data?.length ?? 0) + 1,
          itemBuilder: (context, index) {
            if (index < (notifications?.data?.length ?? 0)) {
              final info = notifications!.data![index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _notificationCard(
                        onTap: () {
                          onTap?.call(info);
                        },
                        isRead: info.isRead ?? false, message: info.message),
                  ),
                ),
              );
            } else {
              return isLoading
                  ? _notificationCardSkeleton()
                  : const SizedBox.shrink();
            }
          },
        );
      }
    }());
  }
}

Widget _notificationCard(
    {required bool isRead, String? message, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(Dimensions.getHeight(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.getHeight(8)),
        color:
        isRead ? AppColors.white : AppColors.primaryColor.withOpacity(0.08),
      ),
      child: Row(
        children: [
          AppButtons.circleButtonBg(
              svgIconPath: AppSvgIcons.notification,
              bgColor: AppColors.primaryColor),
          SizedBox(
            width: Dimensions.getWidth(6),
          ),
          Expanded(
              child: AppTexts.mediumText(
                  text: message ?? '', overflow: TextOverflow.visible))
        ],
      ),
    ),
  );
}

Widget _notificationCardSkeleton() {
  return Container(
    padding: EdgeInsets.all(Dimensions.getHeight(10)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.getHeight(8)),
      color: AppColors.white,
    ),
    child: Row(
      children: [
        AppSkeletons.shimmerCircle(radius: Dimensions.getHeight(18)),
        SizedBox(
          width: Dimensions.getWidth(6),
        ),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSkeletons.shimmerContainer(
                    width: Get.width * 0.6, height: Dimensions.getHeight(15)),
                SizedBox(
                  height: Dimensions.getHeight(6),
                ),
                AppSkeletons.shimmerContainer(
                    width: Get.width * 0.35, height: Dimensions.getHeight(10)),
              ],
            ))
      ],
    ),
  );
}
