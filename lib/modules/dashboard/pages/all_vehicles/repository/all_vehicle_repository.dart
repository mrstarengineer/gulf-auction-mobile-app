import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class AllVehicleRepository {
  final ApiClient _apiClient;

  AllVehicleRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchAllVehicles(
      {String limit = '1', String pageNo = '10', String? searchParams}) async {
    return await _apiClient.getRequest(ApiEndpoints.searchVehicle(
        limit: limit, page: pageNo, searchParams: searchParams));
  }

  Future<http.Response> fetchFilterVehicleOptions() async {
    return await _apiClient.getRequest(ApiEndpoints.filterVehicle());
  }
}
