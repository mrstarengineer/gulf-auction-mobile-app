import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/modules/sell_my_car/sell_my_car.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../global/global.dart';
import '../../../settings/settings.dart';

class SellMyCarPage extends StatefulWidget {
  const SellMyCarPage({super.key});

  @override
  State<SellMyCarPage> createState() => _SellMyCarPageState();
}

class _SellMyCarPageState extends State<SellMyCarPage> {
  final _sellMyCarController = Get.find<SellMyCarController>();
  late ScrollController _scrollController;
  final _pageType = Get.arguments;

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
        !_sellMyCarController.isLoadingPagination) {
      _sellMyCarController.fetchMoreVehicles(pageType: _pageType);
    }
  }

  _initialApiCalls() async {
    _sellMyCarController.fetchVehicles(
        pageType: _pageType, loadingInitial: true);
  }

  _refreshPage() {
    _sellMyCarController.vehiclesCurrentPageNo = '1';
    _initialApiCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(
          title: _pageType == MSellMyCarOptions.allVehicle
              ? 'All Vehicle'
              : _pageType == MSellMyCarOptions.inStock
                  ? 'In Stock'
                  : _pageType == MSellMyCarOptions.pendingVehicle
                      ? 'Pending'
                      : _pageType == MSellMyCarOptions.inAuction
                          ? 'In Auction'
                          : _pageType == MSellMyCarOptions.documentStatus
                              ? 'Document Status'
                              : _pageType == MSellMyCarOptions.returnVehicle
                                  ? 'Returned Vehicles'
                                  : _pageType ==
                                          MSellMyCarOptions
                                              .sellingApprovalVehicle
                                      ? 'On Approval'
                                      : _pageType ==
                                              MSellMyCarOptions.soldVehicle
                                          ? 'Sold'
                                          : _pageType ==
                                                  MSellMyCarOptions
                                                      .unsoldVehicle
                                              ? 'Unsold'
                                              : _pageType ==
                                                      MSellMyCarOptions
                                                          .rejectedVehicle
                                                  ? 'Rejected'
                                                  : ''),
      body: Column(
        children: [
          SellMyCarWidgets.header(
              searchTextController: _sellMyCarController.searchTextController,
              onSearch: (value) {
                _sellMyCarController.fetchVehicles(
                    pageType: _pageType, loadingInitial: true);
              }),
          Expanded(
            child: Obx(
              () {
                if (_sellMyCarController.isLoadingInitial) {
                  return AppLoaders.loaderWithText();
                } else if (_sellMyCarController.bidVehicles == null) {
                  return AppAlertMessages.errorAlert();
                } else if (_sellMyCarController.bidVehicles?.data != null &&
                    _sellMyCarController.bidVehicles!.data!.isEmpty) {
                  return AppAlertMessages.emptyAlert();
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      _refreshPage();
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      child: SellMyCarWidgets.allCarsBody(
                        context,
                        pageType: _pageType,
                        onTapEdit: (id) {
                          context.showLoaderOverlay;
                          _sellMyCarController
                              .fetchSingleVehicle(
                                  vehicleId: id, showLoader: false)
                              .then(
                            (response) {
                              context.hideLoaderOverlay;
                              if (response.isSuccess) {
                                Get.toNamed(AppRoutes.addVehicle,
                                    arguments:
                                        _sellMyCarController.singleVehicleInfo);
                              }
                            },
                          );
                        },
                        onTapDelete: (id) {
                          context.showLoaderOverlay;
                          _sellMyCarController
                              .deleteVehicle(vehicleId: id)
                              .then(
                            (response) {
                              context.hideLoaderOverlay;
                              if (response.isSuccess) {
                                _refreshPage();
                              }
                              AppToasts.shortToast(response.message);
                            },
                          );
                        },
                        onTap: (vehicleId, vehicleTitle, status) {
                          Get.toNamed(
                            AppRoutes.myCars + AppRoutes.carDetails,
                            parameters: {
                              'vehicleId': '$vehicleId',
                              'vehicleTitle': '$vehicleTitle',
                            },
                            arguments: getMSellMyCarOptions(status??-1),
                          );
                        },
                        isLoadingPagination:
                            _sellMyCarController.isLoadingPagination,
                        allVehicles: _sellMyCarController.bidVehicles,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
