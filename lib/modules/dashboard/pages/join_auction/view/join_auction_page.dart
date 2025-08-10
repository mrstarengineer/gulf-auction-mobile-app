import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/dashboard/dashboard.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/join_auction/join_auction.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../../../settings/settings.dart';

class JoinAuctionPage extends StatefulWidget {
  const JoinAuctionPage({super.key});

  @override
  State<JoinAuctionPage> createState() => _JoinAuctionPageState();
}

class _JoinAuctionPageState extends State<JoinAuctionPage> {
  final _joinAuctionController = Get.find<JoinAuctionController>();
  final _dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
  }

  _initialApiCalls() async {
    _joinAuctionController.fetchAuctionsData();
  }

  _refreshPage() {
    _joinAuctionController.fetchAuctionsData(showLoader: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JoinAuctionPageWidgets.appBar(onTapBack: () {
        _dashboardController.updateSelectedScreenIndex(0);
      }),
      body: Obx(() {
        if (_joinAuctionController.isLoading) {
          return AppLoaders.loaderWithText();
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              _refreshPage();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.getHeight(8)),
                child: JoinAuctionPageWidgets.joinAuctionBody(
                    selectedAuctionType:
                        _joinAuctionController.selectedAuctionType,
                    onChangedType: (value) {
                      _joinAuctionController.setSelectedAuctionType = value;
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
                    auctionsLive:
                        _joinAuctionController.auctionListInfo?.liveAuctions,
                    auctionsLater:
                        _joinAuctionController.auctionListInfo?.laterToday,
                    onTapJoin: (auctionId) {
                      final isUserLoggedIn = Get.find<PreferenceController>()
                          .containsKey(PrefsKeys.accessToken);
                      if (isUserLoggedIn) {
                        Get.toNamed(AppRoutes.auctionBidLive,
                            parameters: {'selectedAuctionId': '$auctionId'});
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
              ),
            ),
          );
        }
      }),
    );
  }
}
