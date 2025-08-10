import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class AuctionCalenderRepository {

  final ApiClient _apiClient;

  AuctionCalenderRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchAuctionCalender () async{
    return await _apiClient.getRequest(ApiEndpoints.auctionCalender());
  }
}