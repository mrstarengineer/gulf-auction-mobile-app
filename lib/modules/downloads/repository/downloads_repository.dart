import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class DownloadsRepository {
  final ApiClient _apiClient;

  DownloadsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchDownloads() async {
    return await _apiClient.getRequest(ApiEndpoints.publicDownloads);
  }
}