import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class AllVehiclesRepository {
  final ApiClient _apiClient;

  AllVehiclesRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> searchVehicle ({String limit = '6', String pageNo = '1', String? searchParams}) async{
    return await _apiClient.getRequest(ApiEndpoints.searchVehicle(limit: limit, page: pageNo, searchParams: searchParams));
  }

  Future<http.Response> fetchAuctionVehicles ({String limit = '1', String pageNo = '10', String? searchParams}) async{
    return await _apiClient.getRequest(ApiEndpoints.auctionVehicles(limit: limit, page: pageNo, searchParams: searchParams));
  }

  Future<http.Response> fetchFilterVehicleOptions () async{
    return await _apiClient.getRequest(ApiEndpoints.filterVehicle());
  }


}