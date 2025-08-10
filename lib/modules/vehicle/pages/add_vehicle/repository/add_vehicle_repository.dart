import 'dart:io';
import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class AddVehicleRepository {
  final ApiClient _apiClient;

  AddVehicleRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchMake () async{
    return await _apiClient.getRequest(ApiEndpoints.searchMake);
  }

  Future<http.Response> fetchModel ({String? makeId}) async{
    return await _apiClient.getRequest(ApiEndpoints.searchModel(makeId: makeId));
  }

  Future<http.Response> fetchStaticDataOptions () async{
    return await _apiClient.getRequest(ApiEndpoints.vehicleStaticDataOptions);
  }

  Future<http.Response> autoFillByVin ({Map<String, dynamic>? body}) async{
    return await _apiClient.postRequest(ApiEndpoints.autoFillByVin, body: body);
  }

 Future<http.Response> updateVehicle ({int? vehicleId, required Map<String, dynamic> body}) async{
    return await _apiClient.putRequest(ApiEndpoints.memberSingleVehicle(vehicleId: vehicleId), body: body);
  }

  Future<http.Response> createVehicle ({required Map<String, dynamic> body}) async{
    return await _apiClient.postRequest(ApiEndpoints.createVehicle, body: body);
  }

  Future<http.Response> uploadVehicleDoc ({required File file}) async{
    return await _apiClient.uploadDocument(baseApiUrl: 'https://api.gulfcarauction.com/api/v1', ApiEndpoints.vehicleDocUpload, file: file);
  }

  Future<http.Response> uploadVehiclePhoto ({required File file}) async{
    return await _apiClient.uploadDocument( ApiEndpoints.vehiclePhotoUpload, file: file);
  }

}