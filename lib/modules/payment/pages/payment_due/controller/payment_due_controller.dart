import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/network/handler/handler.dart';
import 'package:gulf_car_auction/settings/enums/enums.dart';

import '../payment_due.dart';

class PaymentDueController extends GetxController {
  final PaymentDueRepository _repo;

  PaymentDueController({required PaymentDueRepository repo}) : _repo = repo;

  late TextEditingController searchTextController;

  @override
  void onInit() {
    searchTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  final _isLoadingPagination = false.obs;

  bool get isLoadingPagination => _isLoadingPagination.value;

  set isLoadingPagination(value) => _isLoadingPagination.value = value;

  // MODELS

  final Rxn<PaymentDueInfo> _paymentDues = Rxn<PaymentDueInfo>();

  PaymentDueInfo? get paymentDues => _paymentDues.value;

  set paymentDues(value) => _paymentDues.value = value;

  final _paymentReceiptsPageNo = '1'.obs;

  String get paymentReceiptsPageNo => _paymentReceiptsPageNo.value;

  set paymentReceiptsPageNo(value) => _paymentReceiptsPageNo.value = value;

  Future<ApiResponseModel> fetchPaymentDues(
      {required MPaymentOptions pageType,
      String pageNo = '1',
      String limit = '10',
      bool loadingInitial = false,
      bool loadingPagination = false}) async {
    try {
      if (loadingPagination) isLoadingPagination = true;
      if (loadingInitial) isLoadingInitial = true;

      late ApiResponseModel apiResponseModel;

      var searchParam = 'global_search=${searchTextController.text.trim()}';

      final response = await _repo.fetchPaymentDues(
          pageType: pageType,
          limit: limit,
          pageNo: pageNo,
          searchParams: searchParam);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          if (pageNo == '1') {
            paymentReceiptsPageNo = '1';
            paymentDues = PaymentDueInfo.fromJson(responseBody);
          } else {
            List<dynamic> dataList = responseBody['data'];

            for (var dataMap in dataList) {
              paymentDues?.data?.add(PaymentDueData.fromJson(dataMap));
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

  Future<void> fetchMorePaymentDues({
    required MPaymentOptions pageType,
  }) async {
    if (isLoadingPagination) return;
    if (int.parse(paymentReceiptsPageNo) == paymentDues?.meta?.lastPage) {
      return;
    }

    int nextPage = int.parse(paymentReceiptsPageNo) + 1;
    paymentReceiptsPageNo = nextPage.toString();

    await fetchPaymentDues(
        pageType: pageType,
        pageNo: paymentReceiptsPageNo,
        loadingPagination: true);
  }
}
