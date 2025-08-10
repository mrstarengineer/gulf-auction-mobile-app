import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';

import '../../../../../models/models.dart';
import '../../../../../utils/debonucer/debouncer.dart';

class PaymentDueWidgets {
  PaymentDueWidgets._();

  static Widget header({
    TextEditingController? searchTextController,
    ValueChanged<String>? onSearch,
  }) {
    Debouncer debounce = Debouncer(milliseconds: 500);
    return AppTextFields.textFieldHintOnly(
        controller: searchTextController,
        hintText: 'Global search...',
        prefixIconSvgPath: AppSvgIcons.search,
        onChanged: (value) {
          if (value != null) {
            debounce.run(() => onSearch?.call(value));
          }
        });
  }

  static Widget body(
    BuildContext context, {
    required MPaymentOptions pageType,
    List<PaymentDueData>? paymentDues,
    bool isLoadingPagination = false,
  }) {
    return Wrap(
      spacing: Dimensions.getWidth(10),
      runSpacing: Dimensions.getHeight(10),
      children: List.generate(paymentDues?.length ?? 0, (index) {
        if (index < (paymentDues?.length ?? 0)) {
          final info = paymentDues![index];
          final bool isOdd = index.isOdd;
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _transactionInfo(
                  pageType: pageType,
                  item: info,
                  isOdd: isOdd,
                ),
              ),
            ),
          );
        } else {
          return isLoadingPagination
              ? _transactionInfoSkeleton()
              : const SizedBox.shrink();
        }
      }),
    );
  }

  static Widget paymentDueTableHeader({required MPaymentOptions pageType}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.getHeight(8),
        horizontal: Dimensions.getWidth(12),
      ),
      color: AppColors.primaryColor.withOpacity(0.2),
      child: Row(
        children: pageType == MPaymentOptions.paymentDue
            ? [
                _headerCell('Invoice', flex: 3),
                _headerCell('Vehicle', flex: 4),
                _headerCell('Amount', flex: 2),
                _headerCell('Status', flex: 2),
                _headerCell('Due Amount', flex: 2),
              ]
            : [
                _headerCell('VIN', flex: 3),
                _headerCell('Invoice', flex: 2),
                _headerCell('P. Mode', flex: 2),
                _headerCell('P. Date', flex: 2),
                _headerCell('Amount', flex: 2),
              ],
      ),
    );
  }
}

Widget _transactionInfoSkeleton() {
  return AppSkeletons.shimmerContainer(
    height: Dimensions.getHeight(120),
  );
}

Widget _transactionInfo(
    {PaymentDueData? item,
    bool isOdd = false,
    required MPaymentOptions pageType}) {
  return Container(
    padding: EdgeInsets.all(Dimensions.getHeight(10)),
    decoration: BoxDecoration(
        color: isOdd ? AppColors.white : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(Dimensions.getHeight(0))),
    child: Row(
      children: pageType == MPaymentOptions.paymentDue
          ? [
              _dataCell(item?.invoiceNumber ?? '', flex: 3),
              _dataCell(item?.vehicleTitle ?? '', flex: 4),
              _dataCell(item?.totalAmount?.toStringAsFixed(2) ?? '', flex: 2),
              _dataCell(item?.statusName ?? '', flex: 2),
              _dataCell(item?.dueAmount?.toStringAsFixed(2) ?? '', flex: 2),
            ]
          : [
              _dataCell(item?.vin ?? '', flex: 3),
              _dataCell(item?.invoiceNumber ?? '', flex: 2),
              _dataCell(item?.accountType ?? '', flex: 2),
              _dataCell(item?.paymentDate ?? '', flex: 2),
              _dataCell(item?.amount?.toStringAsFixed(2) ?? '', flex: 2),
            ],
    ),
  );
}

Widget _headerCell(String title, {int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(4)),
      child: AppTexts.extraSmallText(
        text: title,
        fontWeight: FontWeight.bold,
        maxLine: 2,
      ),
    ),
  );
}

Widget _dataCell(String text, {int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(4)),
      child: AppTexts.extraSmallText(text: text, maxLine: 3),
    ),
  );
}
