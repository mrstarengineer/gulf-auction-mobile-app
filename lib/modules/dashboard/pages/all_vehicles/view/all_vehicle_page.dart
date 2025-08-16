import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/dashboard/controller/dashboard_controller.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../controller/all_vehicle_controller.dart';
import '../widgets/all_vehicle_widgets.dart';

class AllVehiclePage extends StatefulWidget {
  const AllVehiclePage({super.key});

  @override
  State<AllVehiclePage> createState() => _AllVehiclePageState();
}

class _AllVehiclePageState extends State<AllVehiclePage> {
  final _globalController = Get.find<GlobalController>();
  final _dashboardController = Get.find<DashboardController>();
  final _allVehicleController = Get.find<AllVehicleController>();
  String searchParams = '';
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_allVehicleController.isLoadingPagination) {
      _allVehicleController.fetchMoreBuyNowVehicles(searchParams: searchParams);
    }
  }

  _initialApiCalls({bool showLoader = false}) async {
    _allVehicleController.fetchFilterVehicleOptions(showLoader: showLoader);
    _allVehicleController.fetchAllVehicles(
        showLoader: showLoader,
        loadingInitial: true,
        searchParams: searchParams);
  }

  _refreshPage() {
    _allVehicleController.buyNowVehiclesCurrentPageNo = '1';
    searchParams = '';
    _initialApiCalls(showLoader: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AllVehicleWidgets.appBar(onTapBack: () {
        _dashboardController.updateSelectedScreenIndex(0);
      }),
      body: Column(
        children: [
          // HEADER
          Obx(
            () => AllVehicleWidgets.header(
                selectedView: _allVehicleController.selectedView,
                onTapSwitchView: _allVehicleController.toggleView,
                searchTextController:
                    _allVehicleController.searchTextController,
                onTapFilter: () async {
                  if (_allVehicleController.filterVehicleOptions != null) {
                    searchParams = await Get.toNamed(AppRoutes.filterVehicles,
                        arguments: _allVehicleController.filterVehicleOptions
                            ?.toMap());
                  }
                },
                onSearch: (value) {
                  _allVehicleController.fetchAllVehicles(
                      loadingInitial: true, searchParams: searchParams);
                }),
          ),

          SizedBox(
            height: Dimensions.getHeight(10),
          ),

          // BODY
          Expanded(child: Obx(() {
            final vehicles = _allVehicleController.buyNowVehicles;
            if (_allVehicleController.isLoadingInitial) {
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getWidth(16),
                    ),
                    child: AllVehicleWidgets.body(
                      vehicles: vehicles,
                      isLoadingPagination:
                          _allVehicleController.isLoadingPagination,
                      selectedView: _allVehicleController.selectedView,
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
                ),
              );
            }
          }))
        ],
      ),
    );
  }
}
