import 'package:gulf_car_auction/settings/settings.dart';

import '../../../../../network/network.dart';
import 'package:http/http.dart' as http;

class AuctionBidLiveRepository {
  final ApiClient _apiClient;

  AuctionBidLiveRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> joinAuction ({int? auctionId}) async{
    return await _apiClient.getRequest(ApiEndpoints.joinAuction(id: auctionId));
  }
}
