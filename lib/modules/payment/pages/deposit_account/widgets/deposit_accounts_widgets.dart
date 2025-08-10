import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../deposit_accounts.dart';

class DepositAccountWidgets {
  DepositAccountWidgets._();

  static Widget header({
    TextEditingController? searchTextController,
    ValueChanged<String>? onSearch,
    required MPaymentOptions pageType,
    int? amount,
  }) {
    Debouncer debounce = Debouncer(milliseconds: 500);
    return Column(
      children: [
        _balanceSummaryCard(pageType: pageType, amount: amount),
        SizedBox(
          height: Dimensions.getHeight(10),
        ),
        AppTextFields.textFieldHintOnly(
            controller: searchTextController,
            hintText: 'Global search...',
            prefixIconSvgPath: AppSvgIcons.search,
            onChanged: (value) {
              if (value != null) {
                debounce.run(() => onSearch?.call(value));
              }
            }),
      ],
    );
  }

  static Widget body(
    BuildContext context, {
    List<PaymentReceiptData>? paymentReceipts,
    bool isLoadingPagination = false,
  }) {
    return Wrap(
      spacing: Dimensions.getWidth(10),
      runSpacing: Dimensions.getHeight(10),
      children: List.generate(paymentReceipts?.length ?? 0, (index) {
        if (index < (paymentReceipts?.length ?? 0)) {
          final info = paymentReceipts![index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _transactionInfo(
                    bankName: info.bankName,
                    amount: info.amount,
                    paymentDate: info.paymentDate,
                    refNo: info.referenceNumber,
                    status: info.statusName),
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

  static void uploadFileModal(
    BuildContext context, {
    required DepositAccountController accountController,
    required TextEditingController bankNameController,
    required TextEditingController paymentAmountController,
    required TextEditingController remittanceNoController,
    ValueChanged<String>? onUploadDocument,
    ValueChanged<String>? onTapDate,
    VoidCallback? onTapSubmit,
    required MPaymentOptions pageType,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                Dimensions.getWidth(12)), // Adjust the radius value as needed
          ),
        ),
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(
                left: Dimensions.getWidth(16),
                right: Dimensions.getWidth(16),
                top: Dimensions.getHeight(24),
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTexts.mediumText(
                      text:
                          'Top Up your ${pageType == MPaymentOptions.depositAccount ? 'Deposit' : 'Online'} Account',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: Dimensions.getHeight(16),
                  ),

                  // BANK NAME AND AMOUNT
                  Row(
                    children: [
                      Expanded(
                          child: AppTextFields.textFieldWithTitle(
                              title: 'Bank Name',
                              controller: bankNameController)),
                      SizedBox(
                        width: Dimensions.getWidth(6),
                      ),
                      Expanded(
                        child: AppTextFields.textFieldWithTitle(
                            title: 'Amount',
                            keyboardType: TextInputType.number,
                            controller: paymentAmountController),
                      ),
                    ],
                  ),

                  // REMITTANCE NO AND PAYMENT DATE
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFields.textFieldWithTitle(
                            title: 'Remittance No',
                            controller: remittanceNoController),
                      ),
                      SizedBox(
                        width: Dimensions.getWidth(6),
                      ),
                      Expanded(
                          child: Obx(
                        () => AppPickersButtons.datePicker(
                            title: 'Payment Date',
                            selectedDate: accountController.paymentReceiptDate,
                            onTap: onTapDate),
                      )),
                    ],
                  ),

                  Obx(() => AppPickersButtons.filePicker(
                      title: 'Upload Receipt',
                      filePath: accountController.paymentReceiptUrl,
                      onUploadDocument: onUploadDocument)),

                  AppTexts.mediumText(
                      text: '***All Fields are mandatory to send your request'),

                  SizedBox(
                    height: Dimensions.getHeight(14),
                  ),

                  AppButtons.btnWithBg(
                      text: 'Submit',
                      onTap: () {
                        if (bankNameController.text.isEmpty ||
                            paymentAmountController.text.isEmpty ||
                            remittanceNoController.text.isEmpty ||
                            accountController.paymentReceiptDate.isEmpty ||
                            accountController.paymentReceiptUrl.isEmpty) {
                          AppToasts.shortToast(Strings.allFieldsAreRequired);
                        } else {
                          onTapSubmit?.call();
                        }
                      }),

                  SizedBox(
                    height: Dimensions.getHeight(24),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget _transactionInfoSkeleton() {
  return AppSkeletons.shimmerContainer(
    height: Dimensions.getHeight(120),
  );
}

Widget _transactionInfo(
    {String? bankName,
    String? amount,
    String? paymentDate,
    String? refNo,
    String? status}) {
  return Container(
    padding: EdgeInsets.all(Dimensions.getHeight(10)),
    decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(Dimensions.getHeight(6))),
    child: Column(
      children: [
        _infoCard(title: 'Bank Name', value: bankName),
        SizedBox(
          height: Dimensions.getHeight(6),
        ),
        _infoCard(title: 'Amount', value: amount),
        SizedBox(
          height: Dimensions.getHeight(6),
        ),
        _infoCard(title: 'Payment Date', value: paymentDate),
        SizedBox(
          height: Dimensions.getHeight(6),
        ),
        _infoCard(title: 'Reference Number', value: refNo),
        SizedBox(
          height: Dimensions.getHeight(6),
        ),
        _infoCard(title: 'Status', value: status),
      ],
    ),
  );
}

Widget _balanceSummaryCard({required MPaymentOptions pageType, int? amount}) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.all(Dimensions.getHeight(16)),
    decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(Dimensions.getHeight(6))),
    child: Column(
      children: [
        AppTexts.mediumText(
            text:
                '${pageType == MPaymentOptions.depositAccount ? 'Deposit' : 'Online'} Account',
            fontWeight: FontWeight.bold,
            color: AppColors.white),
        SizedBox(
          height: Dimensions.getHeight(amount == null ? 0 : 6),
        ),
        amount == null
            ? const SizedBox.shrink()
            : AppTexts.mediumText(text: '$amount AED', color: AppColors.white),
      ],
    ),
  );
}

Widget _infoCard({required String title, String? value}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(flex: 4, child: AppTexts.smallText(text: title.toUpperCase())),
      AppTexts.smallText(text: ':'),
      SizedBox(
        width: Dimensions.getWidth(6),
      ),
      Expanded(
          flex: 5,
          child: AppTexts.smallText(
              text: value == null || value.isEmpty ? 'N/A' : value,
              overflow: TextOverflow.visible)),
    ],
  );
}
