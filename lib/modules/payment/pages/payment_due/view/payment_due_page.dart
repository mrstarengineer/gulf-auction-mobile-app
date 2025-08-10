import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import '../../../../../utils/utils.dart';
import '../payment_due.dart';

class PaymentDuePage extends StatefulWidget {
  const PaymentDuePage({super.key});

  @override
  State<PaymentDuePage> createState() => _PaymentDuePageState();
}

class _PaymentDuePageState extends State<PaymentDuePage> {
  late ScrollController _scrollController;
  final _pageType = Get.arguments;
  final _paymentDueController = Get.find<PaymentDueController>();

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
        !_paymentDueController.isLoadingPagination) {
      _paymentDueController.fetchMorePaymentDues(pageType: _pageType);
    }
  }

  _initialApiCalls() async {
    _paymentDueController.fetchPaymentDues(
        pageType: _pageType, loadingInitial: true);
  }

  _refreshPage() {
    _paymentDueController.searchTextController.clear();
    _paymentDueController.paymentReceiptsPageNo = '1';

    _initialApiCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(
          title: _pageType == MPaymentOptions.paymentDue
              ? 'Payment Due'
              : _pageType == MPaymentOptions.paymentHistory
                  ? 'Payment History'
                  : ''),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.getHeight(10)),
        child: Column(
          children: [
            PaymentDueWidgets.header(
                searchTextController:
                    _paymentDueController.searchTextController,
                onSearch: (value) {
                  _paymentDueController.fetchPaymentDues(
                      pageType: _pageType, loadingInitial: true);
                }),
            SizedBox(
              height: Dimensions.getHeight(10),
            ),
            PaymentDueWidgets.paymentDueTableHeader(pageType: _pageType),

            // BODY
            Expanded(
              child: Obx(() {
                if (_paymentDueController.isLoadingInitial) {
                  return AppLoaders.loaderWithText();
                } else if (_paymentDueController.paymentDues == null) {
                  return AppAlertMessages.errorAlert();
                } else if (_paymentDueController.paymentDues?.data != null &&
                    _paymentDueController.paymentDues!.data!.isEmpty) {
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
                        child: PaymentDueWidgets.body(
                          context,
                          pageType: _pageType,
                          isLoadingPagination:
                              _paymentDueController.isLoadingPagination,
                          paymentDues: _paymentDueController.paymentDues!.data,
                        )),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
