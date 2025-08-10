import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/career/career.dart';
import '../../../helper/app_helper/app_helper.dart';
import '../../../network/network.dart';

class CareerController extends GetxController {
  final CareerRepository _repo;

  CareerController({required CareerRepository repo}) : _repo = repo;

  late TextEditingController nameController;
  late TextEditingController fathersNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController yearController;

  @override
  void onInit() {
    nameController = TextEditingController();
    fathersNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    yearController = TextEditingController();
    fetchJobs();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    fathersNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    yearController.dispose();
    super.onClose();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading (value) => _isLoading.value = value;

  RxList<JobsInfo> allJobsData = <JobsInfo>[].obs;

  final Rxn<JobsInfo> _specificJob = Rxn(JobsInfo());

  JobsInfo? get specificJob => _specificJob.value;

  set specificJob(value) => _specificJob.value = value;

  final _jobResumeUrl = ''.obs;

  String get jobResumeUrl => _jobResumeUrl.value;

  set jobResumeUrl(value) => _jobResumeUrl.value = value;

  final _selectedVisaStatus = ''.obs;

  String get selectedVisaStatus => _selectedVisaStatus.value;

  set selectedVisaStatus(value) => _selectedVisaStatus.value = value;

  clearJobApplyData (){
    nameController.clear();
    fathersNameController.clear();
    emailController.clear();
    phoneController.clear();
    yearController.clear();
    jobResumeUrl = '';
    selectedVisaStatus = '';
  }

  // API CALLS

  Future<ApiResponseModel> fetchJobs({String? jobId}) async {
    try {
      isLoading = true;

      late ApiResponseModel apiResponseModel;

      final response = await _repo.fetchJob(jobId: jobId);

      final apiResponseHandler = ApiResponseHandler(
        response,
        successCallback: (response) {
          var responseBody = json.decode(response.body);

          if(jobId == null){
            List jobs = responseBody['data'];

            allJobsData.assignAll(jobs.map((e) => JobsInfo.fromJson(e)).toList());
          } else {
            var jobInfo = responseBody['data'];

            specificJob = JobsInfo.fromJson(jobInfo);
          }



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

  Future<ApiResponseModel> jobUploadResume(
      {required String filePath}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.jobUploadResume(filePath: filePath);

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        var fileUrl = responseBody['url'];

        jobResumeUrl = fileUrl;

        apiResponseModel = ApiResponseModel(isSuccess: true, message: fileUrl);


        return apiResponseModel;
      },
      );

      return apiResponseHandler.handleResponse();
    } catch (e) {
      ePrintWrapped('error: $e');
      return ApiResponseModel(isSuccess: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> jobApply({String? jobPostId}) async {
    try {
      late ApiResponseModel apiResponseModel;

      final response = await _repo.jobApply(
        email: emailController.text.trim(),
        fatherName: fathersNameController.text.trim(),
         jobPostId: jobPostId,
        name: nameController.text.trim(),
       phone: phoneController.text.trim(),
        resumeUrl: jobResumeUrl,
        visaStatus: selectedVisaStatus,
         yearOfExperience: yearController.text.trim(),
      );

      log('response: ${response.body}');

      final apiResponseHandler = ApiResponseHandler(
        response, successCallback: (response) {
        var responseBody = json.decode(response.body);

        apiResponseModel = ApiResponseModel(isSuccess: true, message: responseBody['message']);


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