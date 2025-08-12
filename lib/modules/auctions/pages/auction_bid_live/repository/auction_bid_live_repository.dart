import 'package:gulf_car_auction/settings/settings.dart';

import '../../../../../network/network.dart';
import 'package:http/http.dart' as http;

class AuctionBidLiveRepository {
  final ApiClient _apiClient;

  AuctionBidLiveRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<http.Response> joinAuction({int? auctionId}) async {
    return await _apiClient.getRequest(ApiEndpoints.joinAuction(id: auctionId));
  }

  Future<http.Response> upcomingVehicles({int? auctionId}) async {
    return await _apiClient
        .getRequest(ApiEndpoints.upcomingVehicles(auctionId: auctionId));
  }

  Future<http.Response> newBidAPIRepo(
      {required int id, dynamic itemNumber, dynamic amount}) async {
    return await _apiClient.postRequest(ApiEndpoints.newBid(id: id), body: {
      'item_number': itemNumber,
      'amount': amount,
    });
  }
}
