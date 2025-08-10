import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_calender/auction_calender.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../global/global.dart';

class AuctionCalenderPage extends StatefulWidget {
  const AuctionCalenderPage({super.key});

  @override
  State<AuctionCalenderPage> createState() => _AuctionCalenderPageState();
}

class _AuctionCalenderPageState extends State<AuctionCalenderPage> {
  final _auctionCalenderController = Get.find<AuctionCalenderController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
    super.initState();
  }

  _initialApiCalls() {
    _auctionCalenderController.fetchAuctionsCalender();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(title: 'Auction Calender'),
      body: Obx(() {
        if (_auctionCalenderController.isLoading) {
          return AppLoaders.loaderWithText();
        } else {
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: SfCalendar(
                  view: CalendarView.month,
                  dataSource: _auctionCalenderController.myAuctionCalender.myAuctionCalender,
                  minDate: DateTime.now(),
                  onSelectionChanged: (CalendarSelectionDetails details) {
                    _auctionCalenderController.onCalenderDatePressed(context, selectedDate: details.date);
                  },
                ),
              ),
              Expanded(
                flex: 3,
                  child:  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.getHeight(10)),
                      child: AuctionCalenderWidgets.auctionListBody(
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
                          calenderAuctionList:
                              _auctionCalenderController.calendarAuctionList,
                          onTapViewCars: (auctionId) {
                            Get.toNamed(AppRoutes.allVehicle, parameters: {'auctionId' : '$auctionId', 'isFromAuctionList': 'true'});
                          }
                      ),
                    ),
                  ))
            ],
          );
        }
      }),
    );
  }
}
