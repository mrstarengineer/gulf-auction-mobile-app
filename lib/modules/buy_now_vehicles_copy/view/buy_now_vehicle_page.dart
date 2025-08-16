import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../controller/buy_now_vehicle_controller.dart';
import '../widgets/buy_now_vehicle_widgets.dart';

class BuyNowVehiclePage extends StatefulWidget {
  const BuyNowVehiclePage({super.key});

  @override
  State<BuyNowVehiclePage> createState() => _BuyNowVehiclePageState();
}

class _BuyNowVehiclePageState extends State<BuyNowVehiclePage> {
  final _globalController = Get.find<GlobalController>();

  // final _dashboardController = Get.find<DashboardController>();
  final _buyNowVehicleController = Get.find<BuyNowVehicleController>();
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
        !_buyNowVehicleController.isLoadingPagination) {
      _buyNowVehicleController.fetchMoreBuyNowVehicles(
          searchParams: searchParams);
    }
  }

  _initialApiCalls({bool showLoader = false}) async {
    _buyNowVehicleController.fetchFilterVehicleOptions(showLoader: showLoader);
    _buyNowVehicleController.fetchBuyNowVehicles(
        showLoader: showLoader,
        loadingInitial: true,
        searchParams: searchParams);
  }

  _refreshPage() {
    _buyNowVehicleController.buyNowVehiclesCurrentPageNo = '1';
    searchParams = '';
    _initialApiCalls(showLoader: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(
          title: 'Buy Now Vehicles',
          onTapBack: () {
            Get.back();
          }),
      body: Column(
        children: [
          // HEADER
          Obx(
            () => BuyNowVehicleWidgets.header(
                selectedView: _buyNowVehicleController.selectedView,
                onTapSwitchView: _buyNowVehicleController.toggleView,
                searchTextController:
                    _buyNowVehicleController.searchTextController,
                onTapFilter: () async {
                  if (_buyNowVehicleController.filterVehicleOptions != null) {
                    searchParams = await Get.toNamed(AppRoutes.filterVehicles,
                        parameters: {
                          'isFromBuyNowVehicles': 'true',
                        });
                  }
                },
                onSearch: (value) {
                  _buyNowVehicleController.fetchBuyNowVehicles(
                      loadingInitial: true, searchParams: searchParams);
                }),
          ),

          SizedBox(
            height: Dimensions.getHeight(10),
          ),

          // BODY
          Expanded(child: Obx(() {
            final vehicles = _buyNowVehicleController.buyNowVehicles;
            if (_buyNowVehicleController.isLoadingInitial) {
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
                  child: BuyNowVehicleWidgets.body(
                    vehicles: vehicles,
                    isLoadingPagination:
                        _buyNowVehicleController.isLoadingPagination,
                    selectedView: _buyNowVehicleController.selectedView,
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
              );
            }
          }))
        ],
      ),
    );
  }
}
