import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/notification/notification.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollControllerAllNotification;
  late ScrollController _scrollControllerUnreadNotification;
  late TabController _tabController;
  final _notificationController = Get.find<NotificationController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        _initialApiCallAllNotification();
      } else {
        _initialApiCallAllNotification(isUnread: true);
      }
    });
    _scrollControllerAllNotification = ScrollController();
    _scrollControllerAllNotification
        .addListener(_scrollListenerAllNotification);
    _scrollControllerUnreadNotification = ScrollController();
    _scrollControllerUnreadNotification
        .addListener(_scrollListenerUnreadNotification);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCallAllNotification();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _scrollListenerAllNotification() {
    if (_scrollControllerAllNotification.position.pixels >=
            _scrollControllerAllNotification.position.maxScrollExtent &&
        !_notificationController.isLoadingPagination) {
      _notificationController.fetchMoreNotifications();
    }
  }

  void _scrollListenerUnreadNotification() {
    if (_scrollControllerAllNotification.position.pixels >=
            _scrollControllerAllNotification.position.maxScrollExtent &&
        !_notificationController.isLoadingPagination) {
      _notificationController.fetchMoreNotifications(unreadOnly: true);
    }
  }

  _initialApiCallAllNotification(
      {bool? isUnread, bool isRefresh = false}) async {
    _notificationController.fetchNotifications(
        loadingInitial: true, unreadOnly: isUnread, isRefresh: isRefresh);
  }

  _refreshPage({bool isUnread = false}) {
    if (isUnread) {
      _notificationController.unreadNotificationCurrentPageNo = '1';
      _initialApiCallAllNotification(isUnread: true, isRefresh: true);
    } else {
      _notificationController.allNotificationCurrentPageNo = '1';
      _initialApiCallAllNotification(isRefresh: true);
    }
  }

  void notificationMarkAsRead({required NotificationData notiInfo}) {
    context.showLoaderOverlay;
    _notificationController
        .markAsRead(notificationId: '${notiInfo.id}')
        .then((response) {
      context.hideLoaderOverlay;
      if (response.isSuccess) {
        _notificationController.unreadNotifications?.data?.remove(notiInfo);
        _notificationController.allNotifications?.data
            ?.where((e) => e.id == notiInfo.id)
            .singleOrNull
            ?.isRead = true;
      } else {
        AppToasts.shortToast(response.message);
      }
      _notificationController.notificationPageRedirection(
          notificationInfo: notiInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationWidgets.appBar(
          title: 'Notifications',
          onTapMarkAllAsRead: () {
            final List<NotificationData> totalUnreadNotifications =
                _notificationController.allNotifications?.data
                        ?.where((e) => e.isRead == false)
                        .toList() ??
                    [];
            if (totalUnreadNotifications.isNotEmpty) {
              context.showLoaderOverlay;
              _notificationController
                  .markAsRead(isMarkAllRead: true)
                  .then((response) {
                context.hideLoaderOverlay;
                AppToasts.shortToast(response.message);
              });
            } else {
              AppToasts.shortToast(Strings.allNotificationsAlreadyRead);
            }
          }),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.getWidth(16),
        ),
        child: Column(
          children: [
            // TAB BAR
            NotificationWidgets.tabBar(
                controller: _tabController, title1: 'All', title2: 'Unread'),

            SizedBox(
              height: Dimensions.getHeight(10),
            ),

            // TAB BODY
            Expanded(
              child: TabBarView(
                  controller: _tabController, children: [
                // ALL NOTIFICATIONS
                RefreshIndicator.adaptive(
                  onRefresh: () async {
                    _refreshPage();
                  },
                  child: Obx(() => NotificationWidgets.notificationsBody(
                      onTap: (notiInfo) {
                        if (!(notiInfo.isRead ?? false)) {
                          notificationMarkAsRead(notiInfo: notiInfo);
                        } else {
                          _notificationController.notificationPageRedirection(
                              notificationInfo: notiInfo);
                        }
                      },
                      notifications: _notificationController.allNotifications,
                      isLoadingInitial:
                          _notificationController.isLoadingInitial,
                      isLoading: _notificationController.isLoadingInitial)),
                ),

                // UNREAD NOTIFICATIONS
                RefreshIndicator.adaptive(
                  onRefresh: () async {
                    _refreshPage(isUnread: true);
                  },
                  child: Obx(() => NotificationWidgets.notificationsBody(
                      onTap: (notiInfo) {
                        if (!(notiInfo.isRead ?? false)) {
                          notificationMarkAsRead(notiInfo: notiInfo);
                        } else {
                          _notificationController.notificationPageRedirection(
                              notificationInfo: notiInfo);
                        }
                      },
                      notifications:
                          _notificationController.unreadNotifications,
                      isLoadingInitial:
                          _notificationController.isLoadingInitial,
                      isLoading: _notificationController.isLoadingInitial)),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
