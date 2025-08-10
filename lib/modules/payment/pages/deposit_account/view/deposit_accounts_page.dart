import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/loaders/app_loaders.dart';
import 'package:gulf_car_auction/utils/toasts/app_toasts.dart';

import '../deposit_accounts.dart';
import '../widgets/deposit_accounts_widgets.dart';

class DepositAccountPage extends StatefulWidget {
  const DepositAccountPage({super.key});

  @override
  State<DepositAccountPage> createState() => _DepositAccountPageState();
}

class _DepositAccountPageState extends State<DepositAccountPage> {
  late ScrollController _scrollController;
  final _pageType = Get.arguments;
  final _accountController = Get.find<DepositAccountController>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_accountController.isLoadingPagination) {
      _accountController.fetchMorePaymentReceipts(pageType: _pageType);
    }
  }

  _initialApiCalls() async {
    _accountController.fetchPaymentReceipts(
        pageType: _pageType, loadingInitial: true);
    _accountController.fetchBalanceSummary(pageType: _pageType);
  }

  _refreshPage({bool isClearAll = false}) {
    _accountController.searchTextController.clear();
    _accountController.paymentReceiptsPageNo = '1';
    if (isClearAll) {
      _accountController.bankNameController.clear();
      _accountController.paymentAmountController.clear();
      _accountController.remittanceNoController.clear();
      _accountController.paymentReceiptUrl = '';
      _accountController.paymentReceiptDate = '';
    }
    _initialApiCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(
          title: _pageType == MPaymentOptions.depositAccount
              ? 'Deposit Account'
              : _pageType == MPaymentOptions.onlineAccount
                  ? 'Online Account'
                  : ''),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.getHeight(10)),
        child: Column(
          children: [
            // HEADER
            Obx(
              () => DepositAccountWidgets.header(
                  pageType: _pageType,
                  amount:
                      _accountController.balanceSummaries.firstOrNull?.amount,
                  searchTextController: _accountController.searchTextController,
                  onSearch: (value) {
                    _accountController.fetchPaymentReceipts(
                        pageType: _pageType, loadingInitial: true);
                  }),
            ),

            SizedBox(
              height: Dimensions.getHeight(10),
            ),

            // BODY
            Expanded(
              child: Obx(() {
                if (_accountController.isLoadingInitial) {
                  return AppLoaders.loaderWithText();
                } else if (_accountController.paymentReceipts == null) {
                  return AppAlertMessages.errorAlert();
                } else if (_accountController.paymentReceipts?.data != null &&
                    _accountController.paymentReceipts!.data!.isEmpty) {
                  return AppAlertMessages.emptyAlert();
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      _refreshPage();
                    },
                    child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        child: DepositAccountWidgets.body(
                          context,
                          isLoadingPagination:
                              _accountController.isLoadingPagination,
                          paymentReceipts:
                              _accountController.paymentReceipts!.data,
                        )),
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: AppButtons.floatingActionBtn(context,
          iconColor: Colors.white, svgIconPath: AppSvgIcons.plus, onTap: () {
        DepositAccountWidgets.uploadFileModal(context,
            pageType: _pageType,
            bankNameController: _accountController.bankNameController,
            paymentAmountController: _accountController.paymentAmountController,
            remittanceNoController: _accountController.remittanceNoController,
            accountController: _accountController, onTapDate: (selectedDate) {
          _accountController.paymentReceiptDate = selectedDate;
        }, onUploadDocument: (filePath) {
          context.showLoaderOverlay;
          _accountController
              .uploadPaymentReceipt(filePath: filePath)
              .then((response) {
            context.hideLoaderOverlay;
            if (!response.isSuccess) {
              AppToasts.shortToast(response.message);
            }
          });
        }, onTapSubmit: () {
          context.showLoaderOverlay;
          _accountController
              .submitPaymentReceipt(pageType: _pageType)
              .then((response) {
            context.hideLoaderOverlay;
            Get.back();
            if (response.isSuccess) {
              _refreshPage(isClearAll: true);
            }
            AppToasts.shortToast(response.message);
          });
        });
      }),
    );
  }
}
