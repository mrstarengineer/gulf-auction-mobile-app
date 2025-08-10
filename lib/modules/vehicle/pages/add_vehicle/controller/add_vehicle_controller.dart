import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/helper/helper.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/add_vehicle/add_vehicle.dart';
import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/network/handler/handler.dart';
import 'package:gulf_car_auction/settings/enums/enums.dart';

class AddVehicleController extends GetxController {
  final AddVehicleRepository _repo;

  AddVehicleController({required AddVehicleRepository repo}) : _repo = repo;

  late TextEditingController vinTextController;
  late TextEditingController odometerTextController;
  late TextEditingController yearTextController;
  late TextEditingController priceTextController;
  late TextEditingController sellingPriceTextController;
  // late TextEditingController reservePriceTextController;
  late TextEditingController trimTextController;

  final MyCarInfo? editVehicleInfoData = Get.arguments;

  @override
  Future<void> onInit() async {
    vinTextController = TextEditingController();
    odometerTextController = TextEditingController();
    yearTextController = TextEditingController();
    priceTextController = TextEditingController();
    sellingPriceTextController = TextEditingController();
    // reservePriceTextController = TextEditingController();
    trimTextController = TextEditingController();

    await fetchStaticDataOptions();
    await fetchMake();
    if (editVehicleInfoData != null) {
      await fetchModel(makeId: '${editVehicleInfoData!.makeId}');
      updateAllData();
    }
    super.onInit();
  }

  @override
  void onClose() {
    vinTextController.dispose();
    odometerTextController.dispose();
    yearTextController.dispose();
    priceTextController.dispose();
    sellingPriceTextController.dispose();
    // reservePriceTextController.dispose();
    trimTextController.dispose();
    super.onClose();
  }

  updateAllData() {
    vinTextController.text = editVehicleInfoData?.vin ?? '';
    trimTextController.text = editVehicleInfoData?.trim ?? '';
    yearTextController.text = editVehicleInfoData?.year ?? '';
    selectedBodyStyle = editVehicleInfoData?.bodyStyleId;
    selectedEngineType = editVehicleInfoData?.engineTypeId;
    selectedFuelType = editVehicleInfoData?.fuelTypeId;
    selectedDriveTrain = editVehicleInfoData?.driveTrainId;
    selectedTransmission = editVehicleInfoData?.transmissionId;
    selectedCylinder = editVehicleInfoData?.cylinderId;
    selectedPrimaryDamage = editVehicleInfoData?.primaryDamageId;
    selectedSecondaryDamage = editVehicleInfoData?.secondaryDamageId;
    setSelectedSaleExecutiveId = editVehicleInfoData?.salesExecutiveId;
    odometerTextController.text = editVehicleInfoData?.odometer == null
        ? ''
        : '${editVehicleInfoData!.odometer}';
    selectedColor = editVehicleInfoData?.colorId;
    selectedMileageType = editVehicleInfoData?.mileageTypeId;
    hasKeys = editVehicleInfoData?.keys == true
        ? MVehicleHasKeys.yes
        : MVehicleHasKeys.no;
    selectedHighlight = editVehicleInfoData?.highlightId;
    selectedCategory = editVehicleInfoData?.categoryId;
    priceTextController.text = editVehicleInfoData?.startBidAmount == null
        ? ''
        : '${editVehicleInfoData!.startBidAmount}';
    selectedSaleType = editVehicleInfoData?.saleType;
    priceTextController.text = editVehicleInfoData?.reserveAmount == null
        ? ''
        : '${editVehicleInfoData!.reserveAmount}';
    sellingPriceTextController.text = editVehicleInfoData?.sellingPrice == null
        ? ''
        : '${editVehicleInfoData!.sellingPrice}';
    selectedMake = editVehicleInfoData?.makeId;
    selectedModel = editVehicleInfoData?.vehicleModelId;
    vehiclePhotos.assignAll(editVehicleInfoData?.vehicleImages
            ?.map((e) => e.url)
            .where((url) => url != null) // Filter out null values
            .map((url) => url!) // Convert to non-nullable
            .toList() ??
        []);
    vccDocument = editVehicleInfoData!.vccDocument;
    termsAndConditionsAgreed = true;
  }

  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  // Terms and Conditions Check
  final _termsAndConditionsAgreed = false.obs;

  bool get termsAndConditionsAgreed => _termsAndConditionsAgreed.value;

  set termsAndConditionsAgreed(value) =>
      _termsAndConditionsAgreed.value = value;

  updateTermsAndConditionsAgreed(value) => termsAndConditionsAgreed = value;

  RxList<String> vehiclePhotos = <String>[].obs;

  final _hasKeys = MVehicleHasKeys.yes.obs;

  MVehicleHasKeys get hasKeys => _hasKeys.value;

  set hasKeys(value) => _hasKeys.value = value;

  final _documentType = MVehicleDocumentType.vcc.obs;

  MVehicleDocumentType get documentType => _documentType.value;

  set documentType(value) => _documentType.value = value;

  final _vccDocument = ''.obs;

  String get vccDocument => _vccDocument.value;

  set vccDocument(value) => _vccDocument.value = value;

  final _selectedCategory = 0.obs;

  int get selectedCategory => _selectedCategory.value;

  set selectedCategory(value) => _selectedCategory.value = value;

  final _selectedMake = 0.obs;

  int get selectedMake => _selectedMake.value;

  set selectedMake(value) => _selectedMake.value = value;

  final _selectedModel = 0.obs;

  int get selectedModel => _selectedModel.value;

  set selectedModel(value) => _selectedModel.value = value;

  final _selectedBodyStyle = 0.obs;

  int get selectedBodyStyle => _selectedBodyStyle.value;

  set selectedBodyStyle(value) => _selectedBodyStyle.value = value;

  final _selectedEngineType = 0.obs;

  int get selectedEngineType => _selectedEngineType.value;

  set selectedEngineType(value) => _selectedEngineType.value = value;

  final _selectedFuelType = 0.obs;

  int get selectedFuelType => _selectedFuelType.value;

  set selectedFuelType(value) => _selectedFuelType.value = value;

  final _selectedDriveTrain = 0.obs;

  int get selectedDriveTrain => _selectedDriveTrain.value;

  set selectedDriveTrain(value) => _selectedDriveTrain.value = value;

  final _selectedTransmission = 0.obs;

  int get selectedTransmission => _selectedTransmission.value;

  set selectedTransmission(value) => _selectedTransmission.value = value;

  final _selectedCylinder = 0.obs;

  int get selectedCylinder => _selectedCylinder.value;

  set selectedCylinder(value) => _selectedCylinder.value = value;

  final _selectedPrimaryDamage = 0.obs;

  int get selectedPrimaryDamage => _selectedPrimaryDamage.value;

  set selectedPrimaryDamage(value) => _selectedPrimaryDamage.value = value;

  final _selectedSecondaryDamage = 0.obs;

  int get selectedSecondaryDamage => _selectedSecondaryDamage.value;

  set selectedSecondaryDamage(value) => _selectedSecondaryDamage.value = value;

  final _selectedColor = 0.obs;

  int get selectedColor => _selectedColor.value;

  set selectedColor(value) => _selectedColor.value = value;

  final _selectedMileageType = 0.obs;

  int get selectedMileageType => _selectedMileageType.value;

  set selectedMileageType(value) => _selectedMileageType.value = value;

  final _selectedHighlight = 0.obs;

  int get selectedHighlight => _selectedHighlight.value;

  set selectedHighlight(value) => _selectedHighlight.value = value;

  final _selectedSaleType = 0.obs;

  int get selectedSaleType => _selectedSaleType.value;

  set selectedSaleType(value) => _selectedSaleType.value = value;

  final _selectedSaleExecutiveId = 0.obs;

  int get selectedSaleExecutiveId => _selectedSaleExecutiveId.value;

  set setSelectedSaleExecutiveId(value) =>
      _selectedSaleExecutiveId.value = value;

//   MODELS

  final RxList<VehiclePartInfo> make = <VehiclePartInfo>[].obs;
  final RxList<VehiclePartInfo> models = <VehiclePartInfo>[].obs;

  final Rxn<VehicleStaticDataOption> _vehicleStaticDataOptions =
      Rxn<VehicleStaticDataOption>();

  VehicleStaticDataOption? get vehicleStaticDataOptions =>
      _vehicleStaticDataOptions.value;

  set vehicleStaticDataOptions(value) =>
      _vehicleStaticDataOptions.value = value;

  final Rxn<AutoFillByVinData> _autoFillByVinData = Rxn<AutoFillByVinData>();

  AutoFillByVinData? get autoFillByVinData => _autoFillByVinData.value;

  set autoFillByVinData(value) => _autoFillByVinData.value = value;

  Future<ApiResponseModel> fetchMake() async {
    try {
      isLoading = true;
      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchMake();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          List makesData = responseBody;

          make.assignAll(
              makesData.map((data) => VehiclePartInfo.fromJson(data)).toList());

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

  Future<ApiResponseModel> fetchModel({required String makeId}) async {
    try {
      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchModel(makeId: makeId);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          List modelsData = responseBody;

          models.assignAll(modelsData
              .map((data) => VehiclePartInfo.fromJson(data))
              .toList());

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> fetchStaticDataOptions() async {
    try {
      isLoading = true;
      late ApiResponseModel apiResponseModel;
      final response = await _repo.fetchStaticDataOptions();

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          vehicleStaticDataOptions =
              VehicleStaticDataOption.fromJson(responseBody);

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

  Future<ApiResponseModel> autoFillByVin() async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.autoFillByVin(body: {
        'vin': vinTextController.text.trim(),
      });

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          autoFillByVinData = AutoFillByVinData.fromJson(responseBody);

          final makeName = autoFillByVinData?.makeName;
          final modelName = autoFillByVinData?.modelName;
          final year = autoFillByVinData?.year;

          // YEAR
          if (year != 0) {
            yearTextController.text = autoFillByVinData?.year.toString() ?? '';
          }

          // MAKE
          if (makeName != null && makeName.isNotEmpty) {
            bool isMakeContain =
                make.any((e) => e.id == autoFillByVinData?.makeId);

            if (!isMakeContain) {
              make.add(VehiclePartInfo(
                  id: autoFillByVinData?.makeId,
                  name: autoFillByVinData?.makeName));
            }
            selectedMake = autoFillByVinData?.makeId;
          }

          // MODEL
          if (modelName != null && modelName.isNotEmpty) {
            bool isModelContain =
                models.any((e) => e.id == autoFillByVinData?.modelId);

            if (!isModelContain) {
              make.add(VehiclePartInfo(
                  id: autoFillByVinData?.modelId,
                  name: autoFillByVinData?.modelName));
            }
            selectedModel = autoFillByVinData?.modelId;
          }

          apiResponseModel = ApiResponseModel(isSuccess: true, message: '');

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> uploadPhotoOrDocument(
      {required String imgPath, bool isPhoto = true}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = isPhoto
          ? await _repo.uploadVehiclePhoto(file: File(imgPath))
          : await _repo.uploadVehicleDoc(file: File(imgPath));

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          var fileUrl = responseBody['url'];

          if (isPhoto) {
            vehiclePhotos.add(fileUrl);
          } else {
            vccDocument = fileUrl;
          }

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

  Future<ApiResponseModel> createVehicle() async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.createVehicle(body: {
        'selling_price': sellingPriceTextController.text.trim(),
        'reserve_amount': priceTextController.text.trim(),
        'body_style_id': selectedBodyStyle != 0 ? selectedBodyStyle : null,
        'color_id': selectedColor != 0 ? selectedColor : null,
        'cylinder_id': selectedCylinder != 0 ? selectedCylinder : null,
        'drive_train_id': selectedDriveTrain != 0 ? selectedDriveTrain : null,
        'engine_type_id': selectedEngineType != 0 ? selectedEngineType : null,
        'file_urls': {
          'photos': vehiclePhotos,
        },
        'fuel_type_id': selectedFuelType != 0 ? selectedFuelType : null,
        'highlight_id': selectedHighlight != 0 ? selectedHighlight : null,
        'keys': hasKeys == MVehicleHasKeys.yes ? '1' : '0',
        'make_id': selectedMake != 0 ? selectedMake : null,
        'mileage_type_id':
            selectedMileageType != 0 ? selectedMileageType : null,
        'odometer': odometerTextController.text.trim(),
        'primary_damage_id':
            selectedPrimaryDamage != 0 ? selectedPrimaryDamage : null,
        'secondary_damage_id':
            selectedSecondaryDamage != 0 ? selectedSecondaryDamage : null,
        'start_bid_amount': priceTextController.text.trim(),
        // 'sale_type': selectedSaleType != 0 ? selectedSaleType : null,
        'sale_type': 2,
        'sales_executive_id': selectedSaleExecutiveId,
        'transmission_id':
            selectedTransmission != 0 ? selectedTransmission : null,
        'vehicle_model_id': selectedModel != 0 ? selectedModel : null,
        'category_id': selectedCategory != 0 ? selectedCategory : null,
        'vin': vinTextController.text.trim(),
        'year': yearTextController.text.isNotEmpty
            ? int.parse(yearTextController.text.trim())
            : null,
        'terms_condition': termsAndConditionsAgreed,
        'vcc_document': vccDocument,
        'document_type':
            documentType == MVehicleDocumentType.vcc ? 'vcc' : 'hayaza',
      });

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          var message = responseBody['message'];

          apiResponseModel =
              ApiResponseModel(isSuccess: true, message: message);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> editVehicle({int? vehicleId}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.updateVehicle(vehicleId: vehicleId, body: {
        'id': vehicleId,
        'sales_executive_id': selectedSaleExecutiveId,
        'selling_price': sellingPriceTextController.text.trim(),
        'reserve_amount': priceTextController.text.trim(),
        'body_style_id': selectedBodyStyle != 0 ? selectedBodyStyle : null,
        'color_id': selectedColor != 0 ? selectedColor : null,
        'cylinder_id': selectedCylinder != 0 ? selectedCylinder : null,
        'drive_train_id': selectedDriveTrain != 0 ? selectedDriveTrain : null,
        'engine_type_id': selectedEngineType != 0 ? selectedEngineType : null,
        'file_urls': {
          'photos': vehiclePhotos,
        },
        'fuel_type_id': selectedFuelType != 0 ? selectedFuelType : null,
        'highlight_id': selectedHighlight != 0 ? selectedHighlight : null,
        'keys': hasKeys == MVehicleHasKeys.yes ? '1' : '0',
        'make_id': selectedMake != 0 ? selectedMake : null,
        'mileage_type_id':
            selectedMileageType != 0 ? selectedMileageType : null,
        'odometer': odometerTextController.text.trim(),
        'primary_damage_id':
            selectedPrimaryDamage != 0 ? selectedPrimaryDamage : null,
        'secondary_damage_id':
            selectedSecondaryDamage != 0 ? selectedSecondaryDamage : null,
        'start_bid_amount': priceTextController.text.trim(),
        'sale_type': selectedSaleType != 0 ? selectedSaleType : null,
        'transmission_id':
            selectedTransmission != 0 ? selectedTransmission : null,
        'vehicle_model_id': selectedModel != 0 ? selectedModel : null,
        'category_id': selectedCategory != 0 ? selectedCategory : null,
        'vin': vinTextController.text.trim(),
        'trim': trimTextController.text.trim(),
        'year': yearTextController.text.isNotEmpty
            ? int.parse(yearTextController.text.trim())
            : null,
        'terms_condition': termsAndConditionsAgreed,
        'vcc_document': vccDocument,
      });

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          var message = responseBody['message'];

          apiResponseModel =
              ApiResponseModel(isSuccess: true, message: message);

          return apiResponseModel;
        },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('message: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }
}
