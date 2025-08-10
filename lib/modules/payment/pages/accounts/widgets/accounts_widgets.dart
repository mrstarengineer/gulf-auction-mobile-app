import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class AccountsWidgets {
  AccountsWidgets._();

  static Widget header({
    required MemberDashboardInfo object,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _balanceSummaryCard(
                  amount: object.totalDepositAmount ?? 0,
                  title: 'Deposit Amount'),
            ),
            SizedBox(
              width: Dimensions.getWidth(6),
            ),
            Expanded(
              child: _balanceSummaryCard(
                  amount: object.availableBiddingLimit ?? 0,
                  title: 'Bidding Limit'),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.getHeight(10),
        ),
        Row(
          children: [
            Expanded(
              child: _balanceSummaryCard(
                  amount: object.paddleDepositAmount ?? 0,
                  title: 'Paddle Balance'),
            ),
            SizedBox(
              width: Dimensions.getWidth(6),
            ),
            Expanded(
              child: _balanceSummaryCard(
                  amount: object.totalPaymentDue ?? 0, title: 'Payment Due'),
            ),
          ],
        ),
      ],
    );
  }

  static Widget depositCard({required VoidCallback onTap}) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(Dimensions.getHeight(4)),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.getHeight(6))),
      child: Column(
        children: [
          AppButtons.btnWithBg(
            text: 'Top Up your Deposit Account',
            fontWeight: FontWeight.bold,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

Widget _balanceSummaryCard({dynamic amount, required String title}) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.all(Dimensions.getHeight(16)),
    decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(Dimensions.getHeight(6))),
    child: Column(
      children: [
        AppTexts.smallText(
            text: title, fontWeight: FontWeight.bold, color: AppColors.white),
        SizedBox(
          height: Dimensions.getHeight(amount == null ? 0 : 6),
        ),
        amount == null
            ? const SizedBox.shrink()
            : AppTexts.mediumText(text: '$amount AED', color: AppColors.white, fontWeight: FontWeight.bold),
      ],
    ),
  );
}
