import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:http/http.dart' as http;
import '../../../../../network/network.dart';

class SignInRepository {
  final ApiClient _apiClient;
  final PreferenceController _preferenceController;

  SignInRepository(
      {required ApiClient apiClient,
      required PreferenceController preferenceController})
      : _apiClient = apiClient,
        _preferenceController = preferenceController;

  Future<http.Response> signIn({required Map<String, dynamic> body}) async {
    return await _apiClient.postRequest(ApiEndpoints.signIn, body: body);
  }

  saveUserToken({required String token}) async {
    _apiClient.updateHeader(token: token);

    await _preferenceController.setString(PrefsKeys.accessToken, value: token);
  }

  Future<http.Response> resetPassword({String? email}) async {
    return await _apiClient.postRequest(
      ApiEndpoints.forgetPassword,
      body: {
        "email": email,
      },
    );
  }
}
