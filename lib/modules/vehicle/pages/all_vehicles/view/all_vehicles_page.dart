import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/all_vehicles/all_vehicles.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/filter_vehicle/controller/filter_vehicle_controller.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class AllVehiclesPage extends StatefulWidget {
  const AllVehiclesPage({super.key});

  @override
  State<AllVehiclesPage> createState() => _AllVehiclesPageState();
}

class _AllVehiclesPageState extends State<AllVehiclesPage> {
  late ScrollController _scrollController;
  final _globalController = Get.find<GlobalController>();
  final _allVehiclesController = Get.find<AllVehiclesController>();
  final _filterVehicleController = Get.find<FilterVehicleController>();

  final auctionId = Get.parameters['auctionId'] ?? '';
  final isFromAuctionList =
      bool.parse(Get.parameters['isFromAuctionList'] ?? 'false');

  String searchParams = '';

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
        !_allVehiclesController.isLoadingPagination) {
      if (isFromAuctionList) {
        _allVehiclesController.fetchMoreAuctionVehicles(
            searchParams: searchParams, auctionId: int.parse(auctionId));
      } else {
        _allVehiclesController.fetchMoreSearchVehicles(
            searchParams: searchParams);
      }
    }
  }

  _initialApiCalls() async {
    _allVehiclesController.fetchFilterVehicleOptions();
    if (isFromAuctionList) {
      _allVehiclesController.fetchAuctionVehicles(
          loadingInitial: true,
          searchParams: searchParams,
          auctionId: int.parse(auctionId));
    } else {
      _allVehiclesController.searchVehicle(
          loadingInitial: true, searchParams: searchParams);
    }
  }

  _refreshPage() {
    _allVehiclesController.allVehiclesCurrentPageNo = '1';
    _allVehiclesController.topAuctionVehiclesCurrentPageNo = '1';
    if (isFromAuctionList) {
      searchParams = 'auction_id=$auctionId';
    } else {
      searchParams = '';
    }
    _initialApiCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(
          title: auctionId.isEmpty ? 'All Vehicles' : 'Auction Vehicles',
          onTapBack: () {
            _filterVehicleController.clearAllFilters();
            Get.back();
          }),
      body: Column(
        children: [
          // HEADER
          Obx(
            () => AllVehiclesWidgets.header(
                selectedView: _allVehiclesController.selectedView,
                onTapSwitchView: _allVehiclesController.toggleView,
                searchTextController:
                    _allVehiclesController.searchTextController,
                onTapFilter: () async {
                  if (_allVehiclesController.filterVehicleOptions != null) {
                    searchParams = await Get.toNamed(AppRoutes.filterVehicles,
                        parameters: {
                          'isFromAllVehicles': 'true',
                          'isFromAuctionList': '$isFromAuctionList',
                          'auctionId': auctionId,
                        });
                  }
                },
                onSearch: (value) {
                  if (isFromAuctionList) {
                    _allVehiclesController.fetchAuctionVehicles(
                        loadingInitial: true,
                        searchParams: searchParams,
                        auctionId: int.parse(auctionId));
                  } else {
                    _allVehiclesController.searchVehicle(
                        loadingInitial: true, searchParams: searchParams);
                  }
                }),
          ),

          SizedBox(
            height: Dimensions.getHeight(10),
          ),

          //   BODY
          Expanded(child: Obx(() {
            final vehicles = auctionId.isEmpty
                ? _allVehiclesController.allVehicles
                : _allVehiclesController.topAuctionVehicles;
            if (_allVehiclesController.isLoadingInitial) {
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
                  child: AllVehiclesWidgets.body(
                    isAuction: auctionId.isNotEmpty,
                    vehicles: vehicles,
                    isLoadingPagination:
                        _allVehiclesController.isLoadingPagination,
                    selectedView: _allVehiclesController.selectedView,
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
