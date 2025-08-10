import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class AuctionsListRepository {
  final ApiClient _apiClient;

  AuctionsListRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<http.Response> fetchAuctionDashboard () async{
    return await _apiClient.postRequest(ApiEndpoints.auctionDashboard, body: {
      'timezone': 'Asia/Dubai',
      'tz_short': 'GST',
    });
  }
}
