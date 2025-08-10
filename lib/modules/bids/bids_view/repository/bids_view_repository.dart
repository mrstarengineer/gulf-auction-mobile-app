import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class BidsViewRepository {
  final ApiClient _apiClient;

  BidsViewRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchBidDetails({required String apiEndPoints}) async {
    return await _apiClient.getRequest(apiEndPoints);
  }

  Future<http.Response> fetchVehicles({
    required MBidStatusOptions pageType,
    String limit = '10',
    String pageNo = '1',
    String searchParam = '',
  }) async {
    return await _apiClient.getRequest(pageType == MBidStatusOptions.preBid
        ? ApiEndpoints.myBid(limit: limit, page: pageNo, searchParam: searchParam)
        : pageType == MBidStatusOptions.vehiclesWon
            ? ApiEndpoints.lotsWon(
                limit: limit, page: pageNo, searchParam: searchParam)
            : pageType == MBidStatusOptions.vehiclesLoss
                ? ApiEndpoints.lotsLoss(
                    limit: limit, page: pageNo, searchParam: searchParam)
                : pageType == MBidStatusOptions.vehiclesOnApproval
                    ? ApiEndpoints.vehiclesOnApproval(
                        limit: limit, page: pageNo, searchParam: searchParam)
                    : ApiEndpoints.myBid(limit: limit, page: pageNo,searchParam: searchParam,),);
  }
}
