import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/career/career.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../utils/loaders/app_loaders.dart';

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final careerController = Get.find<CareerController>();
    return Scaffold(
      appBar: AppBars.appBar(title: 'Featured Jobs'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.getHeight(22), horizontal: Dimensions.getWidth(16)),
        child: Column(
          children: [

          //   Header
            CareerWidgets.header(),
            
            SizedBox(height: Dimensions.getHeight(17),),

          //   BODY
            Expanded(
              child: Obx((){
                if (careerController.isLoading) {
                  return AppLoaders.loaderWithText();
                } else if (careerController.allJobsData.isEmpty) {
                  return AppAlertMessages.emptyAlert();
                } else {
                  return  CareerWidgets.body(
                    jobsData: careerController.allJobsData,
                    onTap: (jobId, jobTitle){
                      careerController.clearJobApplyData();
                      Get.toNamed(AppRoutes.career + AppRoutes.careerDetails, parameters: {'jobId': '$jobId', 'jobTitle' : '$jobTitle'});
                    }
                  );
              
              }
              }),
            )

          ],
        ),
      ),
    );
  }
}
