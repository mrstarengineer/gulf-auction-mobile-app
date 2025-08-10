import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/modules/account/account.dart';

import '../../../../../models/models.dart';
import '../../../../../network/network.dart';

class MyDocumentsController extends GetxController {
  final MyDocumentsRepository _repo;

  MyDocumentsController({required MyDocumentsRepository repo}) : _repo = repo;

  final Rxn<DocumentsInfo> _documentsInfo = Rxn<DocumentsInfo>();

  DocumentsInfo? get documentsInfo => _documentsInfo.value;

  set documentsInfo(value) => _documentsInfo.value = value;

  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  set isLoading (value) => _isLoading.value = value;


  //   API CALLS
    Future<ApiResponseModel> fetchDocuments () async{
      try {
        isLoading = true;
        late ApiResponseModel apiResponseModel;
        final response = await _repo.fetchDocuments();

        log('response: ${response.body}');

        final apiResponseHandler = ApiResponseHandler(
          response, successCallback: (response) {

          var responseBody = json.decode(response.body);

          documentsInfo = DocumentsInfo.fromJson(responseBody);

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
        );

        return apiResponseHandler.handleResponse();
      } catch (e){
        ePrintWrapped('message: $e');
        return ApiResponseModel(isSuccess: false, message: e.toString());
      } finally {
        isLoading = false;
      }
    }


}