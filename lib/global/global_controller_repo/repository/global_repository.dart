import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class GlobalRepository {
  final ApiClient _apiClient;
  GlobalRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchMe () async{
    return await _apiClient.getRequest(ApiEndpoints.me);
  }

  Future<http.Response> fetchActiveCountries () async{
    return await _apiClient.getRequest(ApiEndpoints.activeCountries);
  }

  Future<http.Response> fetchHeroBanners () async{
    return await _apiClient.getRequest(ApiEndpoints.heroBanner);
  }

  Future<http.Response> vehicleIsWatch ({int? vehicleId, bool isWatched = false}) async{
    return await _apiClient.postRequest(ApiEndpoints.vehicleWatch(vehicleId: vehicleId), body: {
      "watched": isWatched
    });
  }

}