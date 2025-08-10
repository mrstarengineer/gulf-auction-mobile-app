class ApiResponseModel {
  final bool _isSuccess;
  final String _message;

  ApiResponseModel({required bool isSuccess, required String message})
      : _message = message,
        _isSuccess = isSuccess;

  String get message => _message;

  bool get isSuccess => _isSuccess;
}
