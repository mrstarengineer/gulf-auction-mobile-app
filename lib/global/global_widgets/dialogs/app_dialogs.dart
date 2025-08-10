import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';

class AppDialogs {
  AppDialogs._();

  static void acceptConfirmation(
    BuildContext context, {
    String title = 'Accept The Offer?',
    String btn1Text = 'Yes',
    String btn2Text = 'Cancel',
    VoidCallback? onTapBtn1,
    VoidCallback? onTapBtn2,
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: AppTexts.smallText(text: title),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  if (onTapBtn1 == null) {
                    Get.back();
                  } else {
                    onTapBtn1.call();
                  }
                },
                child: AppTexts.smallText(text: btn1Text),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  if (onTapBtn2 == null) {
                    Get.back();
                  } else {
                    onTapBtn2.call();
                  }
                },
                child: AppTexts.smallText(text: btn2Text),
              ),
            ],
          );
        });
  }

  static void closingConfirmation(
    BuildContext context, {
    String title = 'Close the App?',
    String btn1Text = 'Cancel',
    String btn2Text = 'Close',
    VoidCallback? onTapBtn1,
    VoidCallback? onTapBtn2,
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: AppTexts.smallText(text: title),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  if (onTapBtn1 == null) {
                    Get.back();
                  } else {
                    onTapBtn1.call();
                  }
                },
                child: AppTexts.smallText(text: btn1Text),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  if (onTapBtn2 == null) {
                    Get.back();
                  } else {
                    onTapBtn2.call();
                  }
                },
                child: AppTexts.smallText(text: btn2Text),
              ),
            ],
          );
        });
  }

  static void deleteConfirmation(
    BuildContext context, {
    String title = 'Are you sure want to delete?',
    String btn1Text = 'Cancel',
    String btn2Text = 'Delete',
    VoidCallback? onTapBtn1,
    VoidCallback? onTapBtn2,
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: AppTexts.smallText(text: title),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                  if (onTapBtn1 != null) {
                    onTapBtn1.call();
                  }
                },
                child: AppTexts.smallText(text: btn1Text),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                  if (onTapBtn2 != null) {
                    onTapBtn2.call();
                  }
                },
                child: AppTexts.smallText(text: btn2Text),
              ),
            ],
          );
        });
  }
}
