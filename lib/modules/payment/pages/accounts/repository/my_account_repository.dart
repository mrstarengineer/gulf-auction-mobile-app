import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class MyAccountRepository {
  final ApiClient _apiClient;

  MyAccountRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchMemberDashboard() async {
    return await _apiClient.getRequest(ApiEndpoints.memberDashboard);
  }
}
