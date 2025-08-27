import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/home/home.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _globalController = Get.find<GlobalController>();
  final _homeController = Get.find<HomeController>();
  late ScrollController _scrollController;
  final _isUserLoggedIn =
      Get.find<PreferenceController>().containsKey(PrefsKeys.accessToken);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_homeController.isLoading) {
      _homeController.fetchMoreAuctionVehicles();
    }
  }

  _swipeRefreshApiCalls() async {
    _homeController.fetchFilterVehicleOptions();
    _homeController.fetchAuctionVehicles(loadingAuctionVehicle: true);
    _homeController.fetchUpcomingAuctions();
    if (_isUserLoggedIn) {
      _homeController.fetchMemberDashboard();
    }
  }

  _refreshPage() {
    _homeController.topAuctionVehiclesCurrentPageNo = '1';
    _homeController.searchParamsAuctionVehicle = '';
    _homeController.selectedSort = MSortOptions.none;
    _homeController.toggleSortingQueryParams();
    _swipeRefreshApiCalls();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      child: Scaffold(
        backgroundColor: AppColors.red,
        body: SafeArea(
          child: Container(
            color: AppColors.white,
            child: Column(
              children: [
                // APP BAR
                Obx(
                  () => HomeWidgets.appBar(
                      upcomingAuctions: _homeController.upcomingAuctions,
                      isSearchFieldVisible:
                          _homeController.isSearchFieldVisible,
                      onTapShowAllVehicle: () =>
                          Get.toNamed(AppRoutes.allVehicle),
                      unreadNotificationCount: _homeController
                          .memberDashboardInfo
                          ?.notifications
                          ?.unreadNotifications,
                      onTapNotification: () =>
                          Get.toNamed(AppRoutes.notification),
                      onTapSearch: () {
                        _homeController.toggleIsSearchFieldVisible();
                      },
                      onTapJoinNow: () {
                        // _dashboardController.updateSelectedScreenIndex(1);
                        Get.toNamed(AppRoutes.auctionList);
                      },
                      onTapLogin: () {
                        Get.toNamed(AppRoutes.signIn,
                            parameters: {'isFromGuestUser': 'true'});
                      }),
                ),

                // BANNERS
                Obx(() => Padding(
                      padding: EdgeInsets.only(left: Dimensions.getWidth(4)),
                      child: HomeWidgets.header(
                          onTapBanner: (auctionId) {
                            Get.toNamed(AppRoutes.allVehicle, parameters: {
                              'auctionId': '$auctionId',
                              'isFromAuctionList': 'true'
                            });
                          },
                          isLoadingInitial: _homeController.isLoadingInitial,
                          globalMessage: _homeController
                              .memberDashboardInfo?.globalMessage,
                          upcomingAuctions: _homeController.upcomingAuctions),
                    )),

                // TOP AUCTION VEHICLE
                Expanded(
                  child: RefreshIndicator.adaptive(
                    onRefresh: () async {
                      _refreshPage();
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Obx(() => HomeWidgets.vehicles(
                          isLoadingInitial: _homeController.isLoadingInitial,
                          isLoadingAuctionVehicle:
                              _homeController.isLoadingAuctionVehicle,
                          isLoading: _homeController.isLoading,
                          selectedType: _homeController.selectedType,
                          onChanged: (value) {
                            _homeController.selectedType = value;
                          },
                          selectedView: _homeController.selectedView,
                          selectedSort: _homeController.selectedSort,
                          onTapSwitchView: _homeController.toggleView,
                          vehicles: _homeController.topAuctionVehicles,
                          onTapFav: (isWatched, vehicleId) {
                            context.showLoaderOverlay;
                            _globalController
                                .vehicleIsWatch(
                                    vehicleId: vehicleId, isWatched: isWatched)
                                .then((response) {
                              context.hideLoaderOverlay;
                              AppToasts.shortToast(response.message);
                              if (response.isSuccess) {
                                _refreshPage();
                              }
                            });
                          },
                          onTapDetails: (vehicleData) {
                            if (vehicleData?.lotNumber != null) {
                              Get.toNamed(AppRoutes.vehicleDetails,
                                  parameters: {
                                    'lotNo': '${vehicleData?.lotNumber}',
                                    'title': '${vehicleData?.title}',
                                  });
                            } else {
                              AppToasts.shortToast(Strings.lotNoNotFound);
                            }
                          },
                          onTapSort: () {
                            _homeController.toggleSort();
                            _homeController.fetchAuctionVehicles(
                                loadingAuctionVehicle: true);
                          },
                          onTapFilter: () async {
                            _homeController.searchParamsAuctionVehicle =
                                await Get.toNamed(AppRoutes.filterVehicles,
                                    arguments: _homeController
                                        .filterVehicleOptions
                                        ?.toMap());
                          })),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
