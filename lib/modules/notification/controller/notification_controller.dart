import 'dart:convert';

import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/notification/notification.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../network/network.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repo;

  NotificationController({required NotificationRepository repo}) : _repo = repo;

  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  final _isLoadingPagination = false.obs;

  bool get isLoadingPagination => _isLoadingPagination.value;

  set isLoadingPagination(value) => _isLoadingPagination.value = value;

  // MODELS
  final Rxn<NotificationInfo> _allNotifications = Rxn<NotificationInfo>();

  NotificationInfo? get allNotifications => _allNotifications.value;

  set allNotifications(value) => _allNotifications.value = value;

  final Rxn<NotificationInfo> _unreadNotifications = Rxn<NotificationInfo>();

  NotificationInfo? get unreadNotifications => _unreadNotifications.value;

  set unreadNotifications(value) => _unreadNotifications.value = value;

  // API CALLS

  final _allNotificationCurrentPageNo = '1'.obs;

  String get allNotificationCurrentPageNo =>
      _allNotificationCurrentPageNo.value;

  set allNotificationCurrentPageNo(value) =>
      _allNotificationCurrentPageNo.value = value;

  final _unreadNotificationCurrentPageNo = '1'.obs;

  String get unreadNotificationCurrentPageNo =>
      _unreadNotificationCurrentPageNo.value;

  set unreadNotificationCurrentPageNo(value) =>
      _unreadNotificationCurrentPageNo.value = value;

  Future<ApiResponseModel> fetchNotifications({
    bool? unreadOnly,
    String pageNoAllNotification = '1',
    String pageNoUnreadNotification = '1',
    String limit = '10',
    bool loadingInitial = false,
    bool loadingPagination = false,
    bool isRefresh = false,
  }) async {
    try {
      if (loadingPagination) isLoadingPagination = true;
      if (loadingInitial) isLoadingInitial = true;

      // To make less api calls
      if(!isRefresh){
        if(unreadOnly ?? false){
          if(unreadNotifications != null && unreadNotifications?.data != null && unreadNotifications!.data!.isNotEmpty){
            return ApiResponseModel(isSuccess: true, message: 'Already fetched Notifications');
          }
        } else if(allNotifications != null && allNotifications?.data != null && allNotifications!.data!.isNotEmpty){
          return ApiResponseModel(isSuccess: true, message: 'Already fetched Notifications');
        }
      }


      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchNotifications(unreadyOnly: unreadOnly);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          if (unreadOnly ?? false) {
            if (pageNoUnreadNotification == '1') {
              unreadNotificationCurrentPageNo = '1';

              unreadNotifications = NotificationInfo.fromJson(responseBody);
            } else {
              List<dynamic> dataList = responseBody['data'];

              for (var dataMap in dataList) {
                unreadNotifications?.data
                    ?.add(NotificationData.fromJson(dataMap));
              }
            }
          } else {
            if (pageNoAllNotification == '1') {
              allNotificationCurrentPageNo = '1';

              allNotifications = NotificationInfo.fromJson(responseBody);
            } else {
              List<dynamic> dataList = responseBody['data'];

              for (var dataMap in dataList) {
                allNotifications?.data?.add(NotificationData.fromJson(dataMap));
              }
            }
          }

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoadingPagination = false;
      isLoadingInitial = false;
    }
  }

  Future<void> fetchMoreNotifications(
      {String? searchParams, int? auctionId, bool? unreadOnly}) async {
    if (isLoadingPagination) return;
    if(unreadOnly ?? false){
      if (int.parse(unreadNotificationCurrentPageNo) ==
          unreadNotifications?.meta?.lastPage) return;

      int nextPage = int.parse(unreadNotificationCurrentPageNo) + 1;
      unreadNotificationCurrentPageNo = nextPage.toString();
    } else {
      if (int.parse(allNotificationCurrentPageNo) ==
          allNotifications?.meta?.lastPage) return;

      int nextPage = int.parse(allNotificationCurrentPageNo) + 1;
      allNotificationCurrentPageNo = nextPage.toString();
    }
    await fetchNotifications(
      unreadOnly: unreadOnly,
      pageNoUnreadNotification: unreadNotificationCurrentPageNo,
      pageNoAllNotification: allNotificationCurrentPageNo,
      loadingPagination: true,
    );
  }

  Future<ApiResponseModel> markAsRead({
    String? notificationId,
    bool isMarkAllRead = false,
  }) async {
    try {

      late ApiResponseModel apiResponseModel;

      final response = isMarkAllRead ? await _repo.markAllAsRead() : await  _repo.markAsRead(notificationId: notificationId);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          final List<NotificationData> totalUnreadNotifications = allNotifications?.data?.where((e) => e.isRead == false).toList() ?? [];

          for (var info in totalUnreadNotifications) {
            allNotifications?.data?.remove(info);
          }

          unreadNotifications?.data?.clear();

          apiResponseModel = ApiResponseModel(isSuccess: true, message: responseBody['message']);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }




  // NOTIFICATION PAGE REDIRECT
  void notificationPageRedirection({required NotificationData notificationInfo}) {
    switch (notificationInfo.notifiableType) {
      case 'Vehicle':
        Get.toNamed(AppRoutes.myCars + AppRoutes.carDetails, parameters: { 'vehicleId': '${notificationInfo.notifiableId}',});
        break;
      case 'CarLost':
        Get.toNamed(AppRoutes.bidsView, arguments: MBidStatusOptions.vehiclesLoss);
        break;
      case 'CarWon':
        Get.toNamed(AppRoutes.bidsView, arguments: MBidStatusOptions.vehiclesWon);
        break;
      case 'WishlistVehicle':
        Get.toNamed(AppRoutes.myCars + AppRoutes.carDetails, parameters: { 'vehicleId': '${notificationInfo.notifiableId}',});
        break;
      case 'SellingOnApproval':
        Get.toNamed(AppRoutes.myCars + AppRoutes.carDetails, parameters: { 'vehicleId': '${notificationInfo.notifiableId}',});
        break;
    }
  }
}
