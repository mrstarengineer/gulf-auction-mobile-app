import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class PusherRepository {
  final ApiClient _apiClient;
  
  PusherRepository({required ApiClient apiClient}) : _apiClient = apiClient;
  
  
  Future<http.Response> pusherAuthenticateRepo (
      {String? socketId, String? channelName}) async{
    return await _apiClient.postRequest(baseApiUrl: Environment.baseApiUrl, ApiEndpoints.pusherAuth, body: {
      'socket_id': socketId ?? '',
      'channel_name': channelName ?? '',
    });
  }

  Future<http.Response> newBidAPIRepo (
      {required int id, dynamic itemNumber, dynamic amount}) async{
    return await _apiClient.postRequest(ApiEndpoints.newBid(id: id), body: {
      'item_number': itemNumber,
      'amount': amount,
    });
  }
}