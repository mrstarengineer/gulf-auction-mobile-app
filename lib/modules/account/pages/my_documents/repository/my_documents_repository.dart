import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class MyDocumentsRepository {
  final ApiClient _apiClient;
  MyDocumentsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchDocuments () async{
    return await _apiClient.getRequest(ApiEndpoints.documents);
  }
}