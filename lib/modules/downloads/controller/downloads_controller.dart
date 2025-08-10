import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/downloads/downloads.dart';

import '../../../network/network.dart';

class DownloadsController extends GetxController {
  final DownloadsRepository _repo;

  DownloadsController({required DownloadsRepository repo}) : _repo = repo;
  late MediaDownload flutterMediaDownloaderPlugin;

  @override
  void onInit() {
    flutterMediaDownloaderPlugin = MediaDownload();
    fetchDownloads();
    super.onInit();
  }


  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading (value) => _isLoading.value = value;

  RxList<DownloadsInfo> downloadsData = <DownloadsInfo>[].obs;

  Future<ApiResponseModel> fetchDownloads() async {
    try {
      isLoading = true;

      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchDownloads();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          List downloads = responseBody['data'];

          downloadsData.assignAll(downloads.map((e) => DownloadsInfo.fromJson(e)).toList());

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future<void> downloadFile (BuildContext context,{required String url, String? fileName}) async {
    await flutterMediaDownloaderPlugin.downloadMedia(
        context,
        url,
        null,
        fileName ?? 'Gulf Car Auction');
  }
}