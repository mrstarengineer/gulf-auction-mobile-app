import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class SellMyCarRepository {
  final ApiClient _apiClient;

  SellMyCarRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchVehicles(
      {required MSellMyCarOptions pageType,
      String? searchParams,
      String limit = '10',
      String pageNo = '1'}) async {
    return await _apiClient.getRequest(
      pageType == MSellMyCarOptions.pendingVehicle
          ? ApiEndpoints.memberPendingVehicle(
              limit: limit, page: pageNo, searchParams: searchParams)
          : pageType == MSellMyCarOptions.documentStatus
              ? ApiEndpoints.documentPending(
                  limit: limit, page: pageNo, searchParams: searchParams)
              : pageType == MSellMyCarOptions.inStock
                  ? ApiEndpoints.memberInStockVehicle(
                      limit: limit, page: pageNo, searchParams: searchParams)
                  : pageType == MSellMyCarOptions.inAuction
                      ? ApiEndpoints.memberAuctionVehicle(
                          limit: limit,
                          page: pageNo,
                          searchParams: searchParams)
                      : pageType == MSellMyCarOptions.soldVehicle
                          ? ApiEndpoints.memberSoldVehicle(
                              limit: limit,
                              page: pageNo,
                              searchParams: searchParams)
                          : pageType == MSellMyCarOptions.unsoldVehicle
                              ? ApiEndpoints.memberUnsoldVehicle(
                                  limit: limit,
                                  page: pageNo,
                                  searchParams: searchParams)
                              : pageType ==
                                      MSellMyCarOptions.sellingApprovalVehicle
                                  ? ApiEndpoints.memberSellingApprovalVehicle(
                                      limit: limit,
                                      page: pageNo,
                                      searchParams: searchParams)
                                  : pageType == MSellMyCarOptions.returnVehicle
                                      ? ApiEndpoints.memberReturnedVehicle(
                                          limit: limit,
                                          page: pageNo,
                                          searchParams: searchParams)
                                      : pageType ==
                                              MSellMyCarOptions.rejectedVehicle
                                          ? ApiEndpoints.memberRejectedVehicle(
                                              limit: limit,
                                              page: pageNo,
                                              searchParams: searchParams)
                                          : ApiEndpoints.memberAllVehicle(
                                              limit: limit,
                                              page: pageNo,
                                              searchParams: searchParams),
    );
  }

  Future<http.Response> fetchSingleVehicle({int? vehicleId}) async {
    return await _apiClient
        .getRequest(ApiEndpoints.memberSingleVehicle(vehicleId: vehicleId));
  }

  Future<http.Response> deleteVehicle({int? vehicleId}) async {
    return await _apiClient
        .deleteRequest(ApiEndpoints.memberSingleVehicle(vehicleId: vehicleId));
  }

  Future<http.Response> counterOffer(
      {int? vehicleId,
      required int? counterAmount,
      String? note,
      required int status}) async {
    final body = {
      "counter_amount": counterAmount,
      "rejection_note": note,
      "status": status
    };
    return await _apiClient.postRequest(
        ApiEndpoints.counterOffer(vehicleId: vehicleId),
        body: body);
  }

  Future<http.Response> acceptOffer(
      {int? vehicleId, required int status}) async {
    final body = {"status": status};
    return await _apiClient.postRequest(
        ApiEndpoints.counterOffer(vehicleId: vehicleId),
        body: body);
  }
}
