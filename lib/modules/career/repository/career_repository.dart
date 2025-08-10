import 'dart:io';

import 'package:gulf_car_auction/network/api/api.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;

class CareerRepository {
  final ApiClient _apiClient;

  CareerRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<http.Response> fetchJob({String? jobId}) async {
    return await _apiClient.getRequest(ApiEndpoints.publicJobs(jobId: jobId));
  }

  Future<http.Response> jobApply({
    String? email,
    String? fatherName,
    String? jobPostId,
    String? name,
    String? phone,
    String? resumeUrl,
    String? visaStatus,
    String? yearOfExperience,
  }) async {
    return await _apiClient.postRequest(ApiEndpoints.publicJobPostApply, body: {
      "email": email,
      "father_name": fatherName,
      "job_post_id": jobPostId,
      "name": name,
      "phone": phone,
      "resume" : resumeUrl,
      "visa_status" : visaStatus,
      "years_of_experience": yearOfExperience,
    });
  }

  Future<http.Response> jobUploadResume({required String filePath}) async {
    return await _apiClient.uploadDocument(
        ApiEndpoints.publicJobsUploadAttachment,
        file: File(filePath));
  }
}
