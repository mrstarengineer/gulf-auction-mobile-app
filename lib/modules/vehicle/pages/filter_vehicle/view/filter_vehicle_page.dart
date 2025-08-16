import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/home/home.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/all_vehicles/all_vehicles.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/filter_vehicle/filter_vehicle.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../../../global/global.dart';
import '../../../../../settings/settings.dart';
import '../../../../buy_now_vehicles_copy/controller/buy_now_vehicle_controller.dart';

class FilterVehiclePage extends StatelessWidget {
  const FilterVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    final filterDataMapAllVehicle =
        Get.find<AllVehiclesController>().filterVehicleOptions?.toMap();
    final filterDataMapHome =
        Get.find<HomeController>().filterVehicleOptions?.toMap();
    final filterDataMapBuyNow =
        Get.find<BuyNowVehicleController>().filterVehicleOptions?.toMap();
    final homeController = Get.find<HomeController>();
    final filterVehicleController = Get.find<FilterVehicleController>();
    final allVehiclesController = Get.find<AllVehiclesController>();
    final buyNowVehicleController = Get.find<BuyNowVehicleController>();
    final isFromAllVehicles =
        bool.parse(Get.parameters['isFromAllVehicles'] ?? 'false');
    final isFromAuctionList =
        bool.parse(Get.parameters['isFromAuctionList'] ?? 'false');
    final isFromBuyNowVehicles =
        bool.parse(Get.parameters['isFromBuyNowVehicles'] ?? 'false');
    final auctionId = Get.parameters['auctionId'] ?? '';

    final startController = TextEditingController();
    final endController = TextEditingController();
    return Scaffold(
      appBar: AppBars.appBarWithAction(
        action: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.getWidth(10),
              vertical: Dimensions.getHeight(10)),
          child: AppButtons.textIconBtnWithStrokeOnly(
            icon: Icons.close,
            iconColor: AppColors.white,
            iconSize: Get.width * 0.06,
            onTap: () {
              context.showLoaderOverlay;
              if (isFromAllVehicles) {
                allVehiclesController
                    .fetchFilterVehicleOptions()
                    .then((response) {
                  if (response.isSuccess) {
                    filterVehicleController.clearAllFilters();
                    allVehiclesController
                        .fetchAuctionVehicles(
                            searchParams: filterVehicleController.searchParams,
                            auctionId: int.parse(auctionId))
                        .then((response) {
                      context.hideLoaderOverlay;
                      if (!response.isSuccess) {
                        AppToasts.shortToast(response.message);
                      }
                      Get.back(result: filterVehicleController.searchParams);
                    });
                  } else {
                    context.hideLoaderOverlay;
                    AppToasts.shortToast(response.message);
                  }
                });
              }
              if (isFromBuyNowVehicles) {
                buyNowVehicleController
                    .fetchFilterVehicleOptions()
                    .then((response) {
                  if (response.isSuccess) {
                    filterVehicleController.clearAllFilters();
                    buyNowVehicleController
                        .fetchBuyNowVehicles(
                            searchParams: filterVehicleController.searchParams)
                        .then((response) {
                      context.hideLoaderOverlay;
                      if (!response.isSuccess) {
                        AppToasts.shortToast(response.message);
                      }
                      Get.back(result: filterVehicleController.searchParams);
                    });
                  } else {
                    context.hideLoaderOverlay;
                    AppToasts.shortToast(response.message);
                  }
                });
              } else if (isFromAllVehicles) {
                allVehiclesController
                    .fetchFilterVehicleOptions()
                    .then((response) {
                  if (response.isSuccess) {
                    filterVehicleController.clearAllFilters();
                    allVehiclesController
                        .searchVehicle(
                            searchParams: filterVehicleController.searchParams)
                        .then((response) {
                      context.hideLoaderOverlay;
                      if (!response.isSuccess) {
                        AppToasts.shortToast(response.message);
                      }
                      Get.back(result: filterVehicleController.searchParams);
                    });
                  } else {
                    context.hideLoaderOverlay;
                    AppToasts.shortToast(response.message);
                  }
                });
              } else {
                homeController.fetchFilterVehicleOptions().then((response) {
                  if (response.isSuccess) {
                    filterVehicleController.clearAllFilters();
                    homeController
                        .fetchAuctionVehicles(
                            searchParams: filterVehicleController.searchParams)
                        .then((response) {
                      context.hideLoaderOverlay;
                      if (!response.isSuccess) {
                        AppToasts.shortToast(response.message);
                      }
                      Get.back(result: filterVehicleController.searchParams);
                    });
                  } else {
                    context.hideLoaderOverlay;
                    AppToasts.shortToast(response.message);
                  }
                });
              }
            },
            width: Get.width * 0.2,
            padding: 0,
            strokeColor: AppColors.white,
            textColor: AppColors.white,
            text: 'Reset All',
            fontWeight: FontWeight.normal,
            fontSize: Dimensions.getHeight(10),
          ),
        ),
        title: 'Vehicle Filters',
        onTapBack: () {
          context.showLoaderOverlay;
          if (isFromAuctionList) {
            allVehiclesController
                .fetchAuctionVehicles(
                    searchParams: filterVehicleController.searchParams,
                    auctionId: int.parse(auctionId))
                .then((response) {
              context.hideLoaderOverlay;
              if (!response.isSuccess) {
                AppToasts.shortToast(response.message);
              }
              filterVehicleController.updateSelectedIndex(0);
              Get.back(result: filterVehicleController.searchParams);
            });
          } else if (isFromBuyNowVehicles) {
            buyNowVehicleController
                .fetchBuyNowVehicles(
                    searchParams: filterVehicleController.searchParams)
                .then((response) {
              context.hideLoaderOverlay;
              if (!response.isSuccess) {
                AppToasts.shortToast(response.message);
              }
              filterVehicleController.updateSelectedIndex(0);
              Get.back(result: filterVehicleController.searchParams);
            });
          } else if (isFromAllVehicles) {
            allVehiclesController
                .searchVehicle(
                    searchParams: filterVehicleController.searchParams)
                .then((response) {
              context.hideLoaderOverlay;
              if (!response.isSuccess) {
                AppToasts.shortToast(response.message);
              }
              filterVehicleController.updateSelectedIndex(0);
              Get.back(result: filterVehicleController.searchParams);
            });
          } else {
            homeController
                .fetchAuctionVehicles(
                    searchParams: filterVehicleController.searchParams)
                .then((response) {
              context.hideLoaderOverlay;
              if (!response.isSuccess) {
                AppToasts.shortToast(response.message);
              }
              filterVehicleController.updateSelectedIndex(0);
              Get.back(result: filterVehicleController.searchParams);
            });
          }
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          context.showLoaderOverlay;
          if (isFromAuctionList) {
            allVehiclesController
                .fetchAuctionVehicles(
                    searchParams: filterVehicleController.searchParams,
                    auctionId: int.parse(auctionId))
                .then((response) {
              context.hideLoaderOverlay;
              if (!response.isSuccess) {
                AppToasts.shortToast(response.message);
              }
              filterVehicleController.updateSelectedIndex(0);
              Get.back(result: filterVehicleController.searchParams);
            });
          } else if (isFromBuyNowVehicles) {
            buyNowVehicleController
                .fetchBuyNowVehicles(
                    searchParams: filterVehicleController.searchParams)
                .then((response) {
              context.hideLoaderOverlay;
              if (!response.isSuccess) {
                AppToasts.shortToast(response.message);
              }
              filterVehicleController.updateSelectedIndex(0);
              Get.back(result: filterVehicleController.searchParams);
            });
          } else if (isFromAllVehicles) {
            allVehiclesController
                .searchVehicle(
                    searchParams: filterVehicleController.searchParams)
                .then((response) {
              context.hideLoaderOverlay;
              if (!response.isSuccess) {
                AppToasts.shortToast(response.message);
              }
              filterVehicleController.updateSelectedIndex(0);
              Get.back(result: filterVehicleController.searchParams);
            });
          } else {
            homeController
                .fetchAuctionVehicles(
                    searchParams: filterVehicleController.searchParams)
                .then((response) {
              context.hideLoaderOverlay;
              if (!response.isSuccess) {
                AppToasts.shortToast(response.message);
              }
              filterVehicleController.updateSelectedIndex(0);
              Get.back(result: filterVehicleController.searchParams);
            });
          }

          return false;
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Obx(() => FilterVehicleWidgets.optionTitles(
                    selectedIndex: filterVehicleController.selectedIndex,
                    filterDataMap: isFromAllVehicles
                        ? filterDataMapAllVehicle
                        : isFromBuyNowVehicles
                            ? filterDataMapBuyNow
                            : filterDataMapHome,
                    onTap: filterVehicleController.updateSelectedIndex))),
            Expanded(
              flex: 2,
              child: Obx(
                () => FilterVehicleWidgets.optionValueField(
                  filterVehicleController: filterVehicleController,
                  filterDataMap: isFromAllVehicles
                      ? filterDataMapAllVehicle
                      : isFromBuyNowVehicles
                          ? filterDataMapBuyNow
                          : filterDataMapHome,
                  selectedIndex: filterVehicleController.selectedIndex,
                  startController: startController,
                  endController: endController,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FilterVehicleWidgets.submitButton(
          title: 'Vehicle Filters',
          onTapBack: () {
            context.showLoaderOverlay;
            if (isFromAuctionList) {
              allVehiclesController
                  .fetchAuctionVehicles(
                      searchParams: filterVehicleController.searchParams,
                      auctionId: int.parse(auctionId))
                  .then((response) {
                context.hideLoaderOverlay;
                if (!response.isSuccess) {
                  AppToasts.shortToast(response.message);
                }
                filterVehicleController.updateSelectedIndex(0);
                Get.back(result: filterVehicleController.searchParams);
              });
            } else if (isFromBuyNowVehicles) {
              buyNowVehicleController
                  .fetchBuyNowVehicles(
                      searchParams: filterVehicleController.searchParams)
                  .then((response) {
                context.hideLoaderOverlay;
                if (!response.isSuccess) {
                  AppToasts.shortToast(response.message);
                }
                filterVehicleController.updateSelectedIndex(0);
                Get.back(result: filterVehicleController.searchParams);
              });
            } else if (isFromAllVehicles) {
              allVehiclesController
                  .searchVehicle(
                      searchParams: filterVehicleController.searchParams)
                  .then((response) {
                context.hideLoaderOverlay;
                if (!response.isSuccess) {
                  AppToasts.shortToast(response.message);
                }
                filterVehicleController.updateSelectedIndex(0);
                Get.back(result: filterVehicleController.searchParams);
              });
            } else {
              homeController
                  .fetchAuctionVehicles(
                      searchParams: filterVehicleController.searchParams)
                  .then((response) {
                context.hideLoaderOverlay;
                if (!response.isSuccess) {
                  AppToasts.shortToast(response.message);
                }
                filterVehicleController.updateSelectedIndex(0);
                Get.back(result: filterVehicleController.searchParams);
              });
            }
          },
          onTapReset: () {
            context.showLoaderOverlay;
            if (isFromAllVehicles) {
              allVehiclesController
                  .fetchFilterVehicleOptions()
                  .then((response) {
                if (response.isSuccess) {
                  filterVehicleController.clearAllFilters();
                  allVehiclesController
                      .fetchAuctionVehicles(
                          searchParams: filterVehicleController.searchParams,
                          auctionId: int.parse(auctionId))
                      .then((response) {
                    context.hideLoaderOverlay;
                    if (!response.isSuccess) {
                      AppToasts.shortToast(response.message);
                    }
                    Get.back(result: filterVehicleController.searchParams);
                  });
                } else {
                  context.hideLoaderOverlay;
                  AppToasts.shortToast(response.message);
                }
              });
            }
            if (isFromBuyNowVehicles) {
              buyNowVehicleController
                  .fetchFilterVehicleOptions()
                  .then((response) {
                if (response.isSuccess) {
                  filterVehicleController.clearAllFilters();
                  buyNowVehicleController
                      .fetchBuyNowVehicles(
                          searchParams: filterVehicleController.searchParams)
                      .then((response) {
                    context.hideLoaderOverlay;
                    if (!response.isSuccess) {
                      AppToasts.shortToast(response.message);
                    }
                    Get.back(result: filterVehicleController.searchParams);
                  });
                } else {
                  context.hideLoaderOverlay;
                  AppToasts.shortToast(response.message);
                }
              });
            } else if (isFromAllVehicles) {
              allVehiclesController
                  .fetchFilterVehicleOptions()
                  .then((response) {
                if (response.isSuccess) {
                  filterVehicleController.clearAllFilters();
                  allVehiclesController
                      .searchVehicle(
                          searchParams: filterVehicleController.searchParams)
                      .then((response) {
                    context.hideLoaderOverlay;
                    if (!response.isSuccess) {
                      AppToasts.shortToast(response.message);
                    }
                    Get.back(result: filterVehicleController.searchParams);
                  });
                } else {
                  context.hideLoaderOverlay;
                  AppToasts.shortToast(response.message);
                }
              });
            } else {
              homeController.fetchFilterVehicleOptions().then((response) {
                if (response.isSuccess) {
                  filterVehicleController.clearAllFilters();
                  homeController
                      .fetchAuctionVehicles(
                          searchParams: filterVehicleController.searchParams)
                      .then((response) {
                    context.hideLoaderOverlay;
                    if (!response.isSuccess) {
                      AppToasts.shortToast(response.message);
                    }
                    Get.back(result: filterVehicleController.searchParams);
                  });
                } else {
                  context.hideLoaderOverlay;
                  AppToasts.shortToast(response.message);
                }
              });
            }
          }),
    );
  }
}
