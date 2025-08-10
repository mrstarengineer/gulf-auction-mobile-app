import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/bids/bids_view/bids_view.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../../models/models.dart';
import '../../../../routes/routes.dart';
import '../../../../settings/settings.dart';

class BidsViewPage extends StatefulWidget {
  const BidsViewPage({super.key});

  @override
  State<BidsViewPage> createState() => _BidsViewPageState();
}

class _BidsViewPageState extends State<BidsViewPage> {
  final _pageType = Get.arguments;
  final _bidsViewController = Get.find<BidsViewController>();
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
        !_bidsViewController.isLoadingPagination) {
      _bidsViewController.fetchMoreVehicles(pageType: _pageType);
    }
  }

  _initialApiCalls() async {
    _bidsViewController.fetchVehicles(
      loadingInitial: true,
      pageType: _pageType,
    );
  }

  _refreshPage() {
    _bidsViewController.vehiclesCurrentPageNo = '1';
    _initialApiCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(
          title: _pageType == MBidStatusOptions.preBid
              ? 'My Prebids'
              : _pageType == MBidStatusOptions.vehiclesWon
                  ? 'Vehicles Won'
                  : _pageType == MBidStatusOptions.vehiclesLoss
                      ? 'Vehicles Lost'
                      : _pageType == MBidStatusOptions.vehiclesOnApproval
                          ? 'Vehicle On Approval'
                          : ''),
      body: Column(
        children: [
          // HEADER
          BidsViewWidgets.header(
            onSearch: (value) {
              _bidsViewController.fetchVehicles(
                loadingInitial: true,
                pageType: _pageType,
              );
            },
            onTapFilter: () {
              AppBottomSheets.filterByDate(
                title: 'Filter by Date Range',
                items: _bidsViewController.dateFilterOptions,
                selectedItem: _bidsViewController.selectedDateFilter.value,
                onChanged: (DateFilterOption? newValue) {
                  if (newValue != null) {
                    if (_bidsViewController.selectedDateFilter.value !=
                        newValue) {
                      _bidsViewController.selectedDateFilter.value = newValue;
                      Get.back();
                      _bidsViewController.fetchVehicles(
                          pageType: _pageType, loadingInitial: true);
                    }
                  }
                },
              );
            },
            searchTextController: _bidsViewController.searchTextController,
          ),

          Expanded(
            child: Obx(() {
              if (_bidsViewController.isLoadingInitial) {
                return AppLoaders.loaderWithText();
              } else if (_bidsViewController.bidVehicles == null) {
                return AppAlertMessages.errorAlert();
              } else if (_bidsViewController.bidVehicles?.data != null &&
                  _bidsViewController.bidVehicles!.data!.isEmpty) {
                return AppAlertMessages.emptyAlert();
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    _refreshPage();
                  },
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      child: BidsViewWidgets.body(
                        onViewPressed: (id){
                          _bidsViewController.selectedBidType = _pageType;
                          _bidsViewController.selectedBidId = id;
                          Get.toNamed(AppRoutes.bidsView + AppRoutes.bidsDetails);
                        },
                          pageType:_pageType,
                          isLoadingPagination:
                              _bidsViewController.isLoadingPagination,
                          allVehicles: _bidsViewController.bidVehicles,),),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
