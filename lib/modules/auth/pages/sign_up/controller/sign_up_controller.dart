import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/auth/pages/sign_up/sign_up.dart';
import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/network/handler/handler.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/toasts/app_toasts.dart';

class SignUpController extends GetxController {
  final SignUpRepository _repo;

  SignUpController({required SignUpRepository repo}) : _repo = repo;

  bool isDocumentsRequired =
      bool.parse(Get.parameters['isDocumentsRequired'] ?? 'false');

  late TextEditingController companyController;
  late TextEditingController trnController;
  late TextEditingController ibanController;
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController numberController;
  late TextEditingController passController;
  late TextEditingController confirmPassController;
  late TextEditingController addressController;
  late TextEditingController otpTextController;
  List<TextEditingController> stepper4TextEditingControllers = [];
  late List<Documents> stepper4Documents;

  @override
  void onInit() {
    if (isDocumentsRequired) {
      activeStepNo = 4;
    }
    if (activeStepNo == 4) {
      Get.context!.showLoaderOverlay;
      fetchDocuments().then((response) {
        Get.context!.hideLoaderOverlay;
        if (!response.isSuccess) {
          AppToasts.shortToast(response.message);
        }
      });
    }
    companyController = TextEditingController();
    trnController = TextEditingController();
    ibanController = TextEditingController();
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    numberController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    addressController = TextEditingController();
    otpTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    companyController.dispose();
    trnController.dispose();
    ibanController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    numberController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    addressController.dispose();
    otpTextController.dispose();
    super.dispose();
  }

  // Loading
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  //Password visibility

  final _isPassVisible = false.obs;

  bool get isPassVisible => _isPassVisible.value;

  set isPassVisible(value) => _isPassVisible.value = value;

  toggleIsPassVisible() => isPassVisible = !isPassVisible;

  final _isConfirmPassVisible = false.obs;

  bool get isConfirmPassVisible => _isConfirmPassVisible.value;

  set isConfirmPassVisible(value) => _isConfirmPassVisible.value = value;

  toggleIsConfirmPassVisible() => isConfirmPassVisible = !isConfirmPassVisible;

  // Profile Type
  final _selectedProfileType = MProfileType.individual.obs;

  MProfileType get selectedProfileType => _selectedProfileType.value;

  set selectedProfileType(value) => _selectedProfileType.value = value;

  updateSelectedProfileType(value) => selectedProfileType = value;

  // Selected Country Step 3 (Setting Password)
  final _selectedCountryIDStep3 = 0.obs;

  int get selectedCountryIDStep3 => _selectedCountryIDStep3.value;

  set selectedCountryIDStep3(value) => _selectedCountryIDStep3.value = value;

  final _isCountrySelectedStep3 = true.obs;

  get isCountrySelectedStep3 => _isCountrySelectedStep3.value;

  set isCountrySelectedStep3(value) {
    _isCountrySelectedStep3.value = value;
  }

  updateIsCountrySelectedStep3(value) => isCountrySelectedStep3 = value;

  updateSelectedCountryIDStep3(value) => selectedCountryIDStep3 = value;

  // Country Code
  final _selectedCountryCode = '+971'.obs;

  String get selectedCountryCode => _selectedCountryCode.value;

  set selectedCountryCode(value) => _selectedCountryCode.value = value;

  updateSelectedCountryCode(value) => selectedCountryCode = value;

  // Terms and Conditions Check
  final _termsAndConditionsAgreed = false.obs;

  bool get termsAndConditionsAgreed => _termsAndConditionsAgreed.value;

  set termsAndConditionsAgreed(value) =>
      _termsAndConditionsAgreed.value = value;

  updateTermsAndConditionsAgreed(value) => termsAndConditionsAgreed = value;

  // Step Count
  final _activeStepNo = 2.obs;

  int get activeStepNo => _activeStepNo.value;

  set activeStepNo(value) => _activeStepNo.value = value;

  updateActiveStepNo(value) => activeStepNo = value;

  //Otp Validation
  final _isOtpValid = true.obs;

  get isOtpValid => _isOtpValid.value;

  set isOtpValid(value) {
    _isOtpValid.value = value;
  }

  Future<void> otpValid() async {
    isOtpValid = true;
  }

  Future<void> otpNotValid() async {
    isOtpValid = false;
  }

  //Otp Sent

  final _isOtpSent = false.obs;

  get isOtpSent => _isOtpSent.value;

  set isOtpSent(value) {
    _isOtpSent.value = value;
  }

  updateIsOtpSent(value) => isOtpSent = value;

  // final RxList<DocumentType> documents = <DocumentType>[
  //   DocumentType(title: 'National/Emirates ID', refNumberLabel: 'ID Number'),
  //   DocumentType(title: 'Passport', refNumberLabel: 'Passport Number'),
  // ].obs;

  /// API CALLS
  Future<ApiResponseModel> memberRegistration() async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.memberRegistration(body: {
        "first_name": fNameController.text.trim(),
        "last_name": lNameController.text.trim(),
        "email": emailController.text.trim(),
        // "country_code" : ,
        "primary_phone": numberController.text.trim(),
        "primary_phone_code": selectedCountryCode,
        "type": selectedProfileType == MProfileType.individual ? 1 : 2,
        "company_name": companyController.text.trim(),
        "trn": trnController.text.trim(),
        "iban": ibanController.text.trim(),
      });

      log('response: ${response.body}');

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          ePrintWrapped('response: $responseBody');

          apiResponseModel = ApiResponseModel(
              isSuccess: true, message: responseBody['message']);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> verifyOTP() async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.verifyOTP(body: {
        "otp": otpTextController.text.trim(),
        "email": emailController.text.trim(),
      });

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          //Checking success because, invalid email also return status code 200!
          var isSuccess = responseBody['success'];

          if (isSuccess != null) {
            apiResponseModel = ApiResponseModel(
                isSuccess: true, message: responseBody['message']);
          } else {
            apiResponseModel = ApiResponseModel(
                isSuccess: false, message: 'validEmailConfirmationTxt'.tr);
          }

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> createPassword() async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.createPassword(body: {
        "email": emailController.text.trim(),
        "password": passController.text.trim(),
        "password_confirmation": confirmPassController.text.trim(),
        "otp": otpTextController.text.trim(),
      });

      ePrintWrapped('response: ${response.body}');

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          // Save Access Token
          Get.find<PreferenceController>().setString(PrefsKeys.accessToken,
              value: responseBody['access_token']);

          Get.find<ApiClient>().refreshHeaders();

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  // DOCUMENTS

  final Rxn<DocumentsInfo> _documents = Rxn<DocumentsInfo>();

  DocumentsInfo? get documents => _documents.value;

  set documents(value) => _documents.value = value;

  final _formatJsonList = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get documentsJsonList => _formatJsonList;

  set formatJsonList(value) => _formatJsonList.value = value;

  Future<ApiResponseModel> fetchDocuments() async {
    isLoading = true;
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchDocuments();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          documents = DocumentsInfo.fromJson(responseBody);

          // Populate stepper4Documents by mapping the requiredDocumentTypes
          stepper4Documents =
              documents?.requiredDocumentTypes?.entries.map((entry) {
                    String key =
                        entry.key; // This is the key for the document type
                    RequiredDocumentType documentType = entry.value;

                    // Create a new Documents object and assign the key as its type
                    return Documents(type: key, title: documentType.title);
                  }).toList() ??
                  [];

          stepper4TextEditingControllers = List.generate(
            documents?.requiredDocumentTypes?.length ?? 0,
            (index) => TextEditingController(),
          );

          apiResponseModel = ApiResponseModel(
              isSuccess: true, message: 'Successfully fetched documents');

          return apiResponseModel;
        },
      );
      isLoading = false;
      return apiResponseHandler.handleResponse();
    } catch (e) {
      isLoading = false;
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> uploadDocument({required File file}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.uploadDocument(file: file);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          var fileUrl = responseBody['url'];

          apiResponseModel =
              ApiResponseModel(isSuccess: true, message: fileUrl);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> storeDocument() async {
    try {
      late ApiResponseModel apiResponseModel;

      log('documents: $documentsJsonList');

      final response = await _repo.storeDocuments(
          address: addressController.text.trim(),
          countryId: selectedCountryIDStep3,
          documentsJson: documentsJsonList);

      ePrintWrapped('response: ${response.body}');

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          var msg = responseBody['message'];

          apiResponseModel = ApiResponseModel(isSuccess: true, message: msg);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }
}
