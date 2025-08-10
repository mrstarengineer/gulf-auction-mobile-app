import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class VehicleDetailsRepository {
  final ApiClient _apiClient;

  VehicleDetailsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchLotDetails ({required String lotNo}) async{
    return await _apiClient.getRequest(ApiEndpoints.lotDetails(lotNo: lotNo));
  }

  Future<http.Response> offlineBidByVehicle ({required String vehicleId, required Map<String, dynamic> body}) async{
    return await _apiClient.postRequest(ApiEndpoints.offlineBidByVehicle(vehicleId: vehicleId), body: body);
  }

  Future<http.Response> buyNowVehicle ({required String vehicleId, required Map<String, dynamic> body}) async{
    return await _apiClient.postRequest(ApiEndpoints.buyNowVehicle(vehicleId: vehicleId), body: body);
  }
}