import 'dart:convert';
import 'package:get/get.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/contact/contact.dart';
import '../../../helper/app_helper/app_helper.dart';
import '../../../network/network.dart';

class ContactController extends GetxController {
  final ContactRepository _repo;

  ContactController({required ContactRepository repo}) : _repo = repo;

  @override
  void onInit() {
    fetchContactData();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  Rx<ContactModel> contactInfo = ContactModel().obs;

  // API CALLS

  Future<ApiResponseModel> fetchContactData() async {
    try {
      isLoading = true;

      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchContactData();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          contactInfo.value = ContactModel.fromJson(responseBody);

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    } finally {
      update();
      isLoading = false;
    }
  }
}
