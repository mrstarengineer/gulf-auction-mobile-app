import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/network/handler/handler.dart';
import 'package:gulf_car_auction/settings/enums/enums.dart';

import '../deposit_accounts.dart';

class DepositAccountController extends GetxController {
  final DepositAccountRepository _repo;

  DepositAccountController({required DepositAccountRepository repo}) : _repo = repo;

  late TextEditingController searchTextController;
  late TextEditingController bankNameController;
  late TextEditingController paymentAmountController;
  late TextEditingController remittanceNoController;

  @override
  void onInit() {
    searchTextController = TextEditingController();
    bankNameController = TextEditingController();
    paymentAmountController = TextEditingController();
    remittanceNoController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    bankNameController.dispose();
    paymentAmountController.dispose();
    remittanceNoController.dispose();
    super.onClose();
  }


  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  final _isLoadingPagination = false.obs;

  bool get isLoadingPagination => _isLoadingPagination.value;

  set isLoadingPagination(value) => _isLoadingPagination.value = value;

  final _paymentReceiptUrl = ''.obs;

  String get paymentReceiptUrl => _paymentReceiptUrl.value;

  set paymentReceiptUrl(value) => _paymentReceiptUrl.value = value;

  final _paymentReceiptDate = ''.obs;

  String get paymentReceiptDate => _paymentReceiptDate.value;

  set paymentReceiptDate(value) => _paymentReceiptDate.value = value;

  // MODELS
  RxList<BalanceSummaryInfo> balanceSummaries = <BalanceSummaryInfo>[].obs;

  final Rxn<PaymentReceiptInfo> _paymentReceipts = Rxn<PaymentReceiptInfo>();

  PaymentReceiptInfo? get paymentReceipts => _paymentReceipts.value;

  set paymentReceipts(value) => _paymentReceipts.value = value;

  final _paymentReceiptsPageNo = '1'.obs;

  String get paymentReceiptsPageNo => _paymentReceiptsPageNo.value;

  set paymentReceiptsPageNo(value) => _paymentReceiptsPageNo.value = value;

  Future<ApiResponseModel> fetchBalanceSummary(
      {required MPaymentOptions pageType}) async {
    try {
      isLoadingInitial = true;

      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchBalanceSummary(pageType: pageType);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          final summaries = responseBody['data'];

          balanceSummaries.assignAll(
              summaries.map<BalanceSummaryInfo>((summary) =>
                  BalanceSummaryInfo.fromJson(summary)));

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );
      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingInitial = false;
    }
  }

  Future<ApiResponseModel> fetchPaymentReceipts(
      {required MPaymentOptions pageType,
        String pageNo = '1',
        String limit = '10',
        bool loadingInitial = false,
        bool loadingPagination = false}) async {
    try {
      if (loadingPagination) isLoadingPagination = true;
      if (loadingInitial) isLoadingInitial = true;

      late ApiResponseModel apiResponseModel;

      var searchParam = 'payment_global_search=${searchTextController.text
          .trim()}';

      final response = await _repo.fetchPaymentDues(pageType: pageType,
          limit: limit,
          pageNo: pageNo,
          searchParams: searchParam);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          if (pageNo == '1') {
            paymentReceiptsPageNo = '1';

            paymentReceipts = PaymentReceiptInfo.fromJson(responseBody);
          } else {
            List<dynamic> dataList = responseBody['data'];

            for (var dataMap in dataList) {
              paymentReceipts?.data?.add(PaymentReceiptData.fromJson(dataMap));
            }
          }

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingPagination = false;
      isLoadingInitial = false;
    }
  }

  Future<void> fetchMorePaymentReceipts(
      {required MPaymentOptions pageType,}) async {
    if (isLoadingPagination) return;
    if (int.parse(paymentReceiptsPageNo) == paymentReceipts?.meta?.lastPage) return;

    int nextPage = int.parse(paymentReceiptsPageNo) + 1;
    paymentReceiptsPageNo = nextPage.toString();

    await fetchPaymentReceipts(pageType: pageType,
        pageNo: paymentReceiptsPageNo,
        loadingPagination: true);
  }


  Future<ApiResponseModel> uploadPaymentReceipt(
      {required String filePath}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.uploadPaymentReceipt(filePath: filePath);

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        var fileUrl = responseBody['url'];

        paymentReceiptUrl = fileUrl;

        apiResponseModel = ApiResponseModel(isSuccess: true, message: fileUrl);


        return apiResponseModel;
      },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> submitPaymentReceipt(
      {required MPaymentOptions pageType,}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.submitPaymentReceipt(
          bankName: bankNameController.text.trim(),
          amount: int.parse(paymentAmountController.text.trim()),
          remittanceNo: remittanceNoController.text.trim(),
          paymentDate: paymentReceiptDate,
          receiptUrl: paymentReceiptUrl,
        pageType: pageType
      );

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: responseBody['message']);


        return apiResponseModel;
      },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }


}