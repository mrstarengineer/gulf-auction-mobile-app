import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class WatchedVehiclesRepository {
  final ApiClient _apiClient;

  WatchedVehiclesRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchWatchedVehicles ({String limit = '1', String pageNo = '10'}) async{
    return await _apiClient.getRequest(ApiEndpoints.watchedVehicles(limit: limit, page: pageNo));
  }
}