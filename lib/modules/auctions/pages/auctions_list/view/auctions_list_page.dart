import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auctions_list/auctions_list.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../../../global/global.dart';

class AuctionsListPage extends StatefulWidget {
  const AuctionsListPage({super.key});

  @override
  State<AuctionsListPage> createState() => _AuctionsListPageState();
}

class _AuctionsListPageState extends State<AuctionsListPage> {
  final _auctionListController = Get.find<AuctionsListController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
  }

  _initialApiCalls() async {
    _auctionListController.fetchFilterVehicleOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(title: 'Auctions'),
      body: Obx(() {
        if (_auctionListController.isLoading) {
          return AppLoaders.loaderWithText();
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              _initialApiCalls();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.getHeight(10)),
                child: Column(
                  children: [
                    AuctionsListWidgets.auctionsListBody(
                        isAuctionLive: true,
                        auctions: _auctionListController
                            .auctionListInfo?.liveAuctions,
                        onTapCatalogue: (url) {
                          final extension = getFileExtension(url ?? '');
                          if (extension == 'jpg' ||
                              extension == 'png' ||
                              extension == 'pdf') {
                            Get.toNamed(AppRoutes.filesPreview, arguments: url);
                          } else {
                            AppToasts.shortToast(Strings.unsupportedFileFormat);
                          }
                        },
                        onTapJoin: (auctionId) {
                          final isUserLoggedIn =
                              Get.find<PreferenceController>()
                                  .containsKey(PrefsKeys.accessToken);
                          if (isUserLoggedIn) {
                            Get.toNamed(AppRoutes.auctionBidLive,
                                parameters: {
                                  'selectedAuctionId': '$auctionId'
                                });
                          } else {
                            Get.toNamed(AppRoutes.signIn,
                                parameters: {'isFromGuestUser': 'true'});
                          }
                        },
                        onTapViewCars: (auctionId) {
                          Get.toNamed(AppRoutes.allVehicle, parameters: {
                            'auctionId': '$auctionId',
                            'isFromAuctionList': 'true'
                          });
                        }),
                    SizedBox(
                      height: Dimensions.getHeight(14),
                    ),
                    AuctionsListWidgets.auctionsListBody(
                      isAuctionLive: false,
                      auctions:
                          _auctionListController.auctionListInfo?.laterToday,
                      onTapViewCars: (auctionId) {
                        Get.toNamed(AppRoutes.allVehicle, parameters: {
                          'auctionId': '$auctionId',
                          'isFromAuctionList': 'true'
                        });
                      },
                      onTapCatalogue: (url) {
                        final extension = getFileExtension(url ?? '');
                        if (extension == 'jpg' ||
                            extension == 'png' ||
                            extension == 'pdf') {
                          Get.toNamed(AppRoutes.filesPreview, arguments: url);
                        } else {
                          AppToasts.shortToast(Strings.unsupportedFileFormat);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
