import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class PaymentDueRepository {
  final ApiClient _apiClient;

  PaymentDueRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchPaymentDues(
      {required MPaymentOptions pageType,
      String? searchParams,
      String limit = '10',
      String pageNo = '1'}) async {
    return await _apiClient.getRequest(
      pageType == MPaymentOptions.paymentDue
          ? ApiEndpoints.pendingInvoiceList(
              limit: limit, page: pageNo, searchParams: searchParams)
          : ApiEndpoints.paymentHistoryList(
              limit: limit, page: pageNo, searchParams: searchParams),
    );
  }
}
