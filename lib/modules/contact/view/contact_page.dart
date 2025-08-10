import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/contact/contact.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../utils/loaders/app_loaders.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contactController = Get.find<ContactController>();
    return Scaffold(
      appBar: AppBars.appBar(title: 'Contact'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.getHeight(22),
            horizontal: Dimensions.getWidth(16)),
        child: Column(
          children: [
            //   Header
            ContactWidgets.header(),

            SizedBox(
              height: Dimensions.getHeight(17),
            ),

            //   BODY
            Expanded(
              child: Obx(() {
                if (contactController.isLoading) {
                  return AppLoaders.loaderWithText();
                } else
                if (contactController.contactInfo.value.address == null) {
                  return AppAlertMessages.emptyAlert();
                } else {
                  return ContactWidgets.contactDetailsBody(contactController.contactInfo.value);
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
