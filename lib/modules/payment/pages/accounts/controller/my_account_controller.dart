import 'dart:convert';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/payment/pages/accounts/repository/my_account_repository.dart';
import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/network/handler/handler.dart';

class MyAccountController extends GetxController {
  final MyAccountRepository _repo;

  MyAccountController({required MyAccountRepository repo}) : _repo = repo;

  final _isLoadingInitial = false.obs;

  bool get isLoadingInitial => _isLoadingInitial.value;

  set isLoadingInitial(value) => _isLoadingInitial.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchMemberDashboard();
  }

  final Rxn<MemberDashboardInfo> _memberDashboardInfo =
      Rxn<MemberDashboardInfo>();

  MemberDashboardInfo? get memberDashboardInfo => _memberDashboardInfo.value;

  set memberDashboardInfo(value) => _memberDashboardInfo.value = value;

  //  API CALLS

  Future<ApiResponseModel> fetchMemberDashboard() async {
    try {
   isLoadingInitial = true;
      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchMemberDashboard();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          memberDashboardInfo = MemberDashboardInfo.fromJson(responseBody);

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }finally {
      isLoadingInitial = false;
    }
  }
}
