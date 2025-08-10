import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/members/member_dashboard_info.dart';
import 'package:gulf_car_auction/modules/payment/pages/accounts/accounts.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/loaders/app_loaders.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<MyAccountController>();
    return Scaffold(
      appBar: AppBars.appBar(title: 'My Account'),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.getHeight(10)),
        child: Obx(() {
          if (accountController.isLoadingInitial) {
            return AppLoaders.loaderWithText();
          } else {
            return Column(
              children: [
                AccountsWidgets.header(
                  object: accountController.memberDashboardInfo ??
                      MemberDashboardInfo(),
                ),
                SizedBox(
                  height: Dimensions.getHeight(24),
                ),
                AccountsWidgets.depositCard(onTap: () {
                  Get.toNamed(AppRoutes.depositPayment,
                      arguments: MPaymentOptions.depositAccount);
                }),
              ],
            );
          }
        }),
      ),
    );
  }
}
