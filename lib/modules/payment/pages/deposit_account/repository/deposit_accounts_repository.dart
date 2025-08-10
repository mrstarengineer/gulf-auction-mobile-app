import 'dart:io';

import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class DepositAccountRepository {
  final ApiClient _apiClient;

  DepositAccountRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchPaymentDues(
      {required MPaymentOptions pageType,
      String? searchParams,
      String limit = '10',
      String pageNo = '1'}) async {
    return await _apiClient.getRequest(ApiEndpoints.paymentReceiptsList(
        limit: limit,
        page: pageNo,
        searchParams: searchParams,
        type:
            pageType == MPaymentOptions.depositAccount ? 'deposit' : 'online'));
  }

  Future<http.Response> fetchBalanceSummary(
      {required MPaymentOptions pageType}) async {
    return await _apiClient.getRequest(ApiEndpoints.balanceSummary(
      type: pageType == MPaymentOptions.depositAccount ? 'deposit' : 'online',
    ));
  }

  Future<http.Response> submitPaymentReceipt(
      {String? bankName, String? remittanceNo, int? amount, String? paymentDate, String? receiptUrl, required MPaymentOptions pageType,}) async {
    return await _apiClient.postRequest(ApiEndpoints.paymentReceipt, body: {
      "bank_name" : bankName,
      "reference_number" : remittanceNo,
      "amount" : amount,
      "payment_date": paymentDate,
      "attachment": receiptUrl,
      "type": pageType == MPaymentOptions.depositAccount ? 'deposit' : 'online'
    });
  }

  Future<http.Response> uploadPaymentReceipt(
      {required String filePath}) async {
    return await _apiClient.uploadDocument(ApiEndpoints.uploadReceipt, file: File(filePath));
  }
}
