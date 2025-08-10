import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/extensions/extensions.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/watched_vehicles/watched_vehicles.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class WatchedVehiclesPage extends StatefulWidget {
  const WatchedVehiclesPage({super.key});

  @override
  State<WatchedVehiclesPage> createState() => _WatchedVehiclesPageState();
}

class _WatchedVehiclesPageState extends State<WatchedVehiclesPage> {
  late ScrollController _scrollController;
  final _watchedVehiclesController = Get.find<WatchedVehiclesController>();
  final _globalController = Get.find<GlobalController>();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_watchedVehiclesController.isLoadingPagination) {
      _watchedVehiclesController.fetchMoreWatchedVehicle();
    }
  }

  _initialApiCalls() {
    _watchedVehiclesController.fetchWatchedVehicle(loadingInitial: true);
  }

  _refreshPage() {
    _watchedVehiclesController.currentPageNo = '1';
    _initialApiCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final vehicles = _watchedVehiclesController.watchedVehicles;
      return Scaffold(
        appBar: AppBars.appBarWithAction(
          action: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
            child: AppButtons.circleButtonStrokeOnly(
              onTap: () {
                if (_watchedVehiclesController.isLoadingInitial) {
                  AppToasts.shortToast(Strings.pleaseWaitUntilPageLoads);
                } else {
                  _watchedVehiclesController.toggleView();
                }
              },
              svgIconPath:
                  _watchedVehiclesController.selectedView == MSelectedView.list
                      ? AppSvgIcons.grid
                      : AppSvgIcons.list,
              color: AppColors.white,
              padding: Dimensions.getWidth(8),
              iconSize: Dimensions.getWidth(12),
            ),
          ),
          title: 'Watched Vehicles',
        ),
        body: (() {
          if (_watchedVehiclesController.isLoadingInitial) {
            return AppLoaders.loaderWithText();
          } else if (vehicles?.data?.isEmpty ?? false) {
            return AppAlertMessages.emptyAlert();
          } else {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                _refreshPage();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _scrollController,
                child: WatchedVehiclesWidgets.body(
                  selectedView: _watchedVehiclesController.selectedView,
                  vehicles: vehicles,
                  isLoadingPagination:
                      _watchedVehiclesController.isLoadingPagination,
                  onTapFav: (isWatched, vehicleId) {
                    context.showLoaderOverlay;
                    _globalController
                        .vehicleIsWatch(
                            vehicleId: vehicleId, isWatched: isWatched)
                        .then((response) {
                      context.hideLoaderOverlay;
                      AppToasts.shortToast(response.message);
                      if (response.isSuccess) {
                        _watchedVehiclesController.watchedVehicles?.data
                            ?.removeWhere((e) => e.id == vehicleId);
                      }
                    });
                  },
                  onTapDetails: (vehicleData) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (vehicleData?.lotNumber != null) {
                      Get.toNamed(AppRoutes.vehicleDetails, parameters: {
                        'lotNo': '${vehicleData?.lotNumber}',
                        'title': '${vehicleData?.title}',
                      });
                    } else {
                      AppToasts.shortToast(Strings.lotNoNotFound);
                    }
                  },
                ),
              ),
            );
          }
        }()),
      );
    });
  }
}
