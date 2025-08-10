import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/auction/auction.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_calender/auction_calender.dart';
import 'package:intl/intl.dart';

import '../../../../../network/network.dart';

class AuctionCalenderController extends GetxController {
  final AuctionCalenderRepository _repo;

  AuctionCalenderController({required AuctionCalenderRepository repo})
      : _repo = repo;

  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  final _myAuctionCalender = MyCalendar().obs;

  MyCalendar get myAuctionCalender => _myAuctionCalender.value;

  set myAuctionCalender(value) {
    _myAuctionCalender.value = value;
  }

  final _calendarAuctionList = [].obs;

  get calendarAuctionList => _calendarAuctionList;

  set calendarAuctionList(value) {
    _calendarAuctionList.value = value;
  }

  void onCalenderDatePressed(BuildContext context, {DateTime? selectedDate}) {
    // reset
    calendarAuctionList = [];
    update();

    try {
      if (selectedDate != null && myAuctionCalender.calenderMapList != null) {
        String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        if (myAuctionCalender.calenderMapList!.containsKey(formattedDate)) {
          calendarAuctionList =
              myAuctionCalender.calenderMapList![formattedDate]!;
        }
      }
    } catch (error) {
      ePrintWrapped(error.toString());
    } finally {
      context.hideLoaderOverlay;
    }

    update();
  }

  Future<ApiResponseModel> fetchAuctionsCalender() async {
    //reset
    _myAuctionCalender.value = MyCalendar();
    _calendarAuctionList.value = [];
    update();
    try {

      isLoading = true;
      late ApiResponseModel apiResponseModel;

      var response = await _repo.fetchAuctionCalender();

      final apiResponseHandler = ApiResponseHandler(response, successCallback: (response) {
        var responseBody = json.decode(response.body);
        MyCalendar myCalendar = MyCalendar.fromJson(responseBody);
        myAuctionCalender = myCalendar;
        if (myAuctionCalender.calenderMapList != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
          if (myAuctionCalender.calenderMapList!.containsKey(formattedDate)) {
            calendarAuctionList =
            myAuctionCalender.calenderMapList![formattedDate]!;
          }
        }

        apiResponseModel = ApiResponseModel(isSuccess: true, message: '');
        update();
        return apiResponseModel;
      });

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped(e.toString());
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoading = false;
    }
  }
}
