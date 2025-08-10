import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/downloads/downloads.dart';
import 'package:gulf_car_auction/settings/dimensions/dimensions.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final downloadController = Get.find<DownloadsController>();
    return Scaffold(
      appBar: AppBars.appBar(title: 'Downloads'),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.getHeight(10)),
        child: Obx(() {
          if (downloadController.isLoading) {
            return AppLoaders.loaderWithText();
          } else if (downloadController.downloadsData.isEmpty) {
            return AppAlertMessages.emptyAlert();
          } else {
            return DownloadsWidgets.body(
                downloadsData: downloadController.downloadsData,
                onTapDownload: (url, fileName) async{
                  context.showLoaderOverlay;
                  await downloadController.downloadFile(context, url: url, fileName: fileName);
                  context.hideLoaderOverlay;
                  AppToasts.shortToast('Downloaded');
                });
          }
        }),
      ),
    );
  }
}
