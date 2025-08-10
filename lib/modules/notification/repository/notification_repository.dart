import 'package:gulf_car_auction/settings/settings.dart';

import '../../../network/network.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  final ApiClient _apiClient;

  NotificationRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchNotifications ({bool? unreadyOnly, String limit = '10', String page = '1', }) async{
    return await _apiClient.getRequest(ApiEndpoints.notifications(unreadyOnly: unreadyOnly, limit: limit, page: page, ));
  }

  Future<http.Response> markAsRead ({String? notificationId}) async{
    return await _apiClient.postRequest(ApiEndpoints.notificationMarkAsRead(notificationId: notificationId));
  }

  Future<http.Response> markAllAsRead () async{
    return await _apiClient.postRequest(ApiEndpoints.notificationMarkAllAsRead);
  }
}