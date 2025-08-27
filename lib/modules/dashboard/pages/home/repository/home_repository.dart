import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  final ApiClient _apiClient;

  HomeRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchAuctionVehicles(
      {String limit = '6',
      String pageNo = '1',
      String? searchParams,
      String? type}) async {
    //TODO 2098
    // if (type == 'Listed Vehicle') {
    //   return http.Response("{\"data\": []}",200);
    // }
    return await _apiClient.getRequest(type == 'Listed Vehicle'
        ? ApiEndpoints.auctionVehicles(
            auctionVehicleType: 1,
            limit: limit,
            page: pageNo,
            searchParams: searchParams)
        : type == 'Upcoming Auction'
            ? ApiEndpoints.auctionVehicles(
                auctionVehicleType: 2,
                limit: limit,
                page: pageNo,
                searchParams: searchParams)
            : ApiEndpoints.searchVehicle(
                limit: limit, page: pageNo, searchParams: searchParams));
  }

  Future<http.Response> fetchFilterVehicleOptions() async {
    return await _apiClient.getRequest(ApiEndpoints.filterVehicle());
  }

  Future<http.Response> fetchUpcomingAuctions() async {
    return await _apiClient.getRequest(ApiEndpoints.upcomingAuction);
  }

  Future<http.Response> fetchMemberDashboard() async {
    return await _apiClient.getRequest(ApiEndpoints.memberDashboard);
  }
}
