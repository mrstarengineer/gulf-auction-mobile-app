class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class InternetException extends AppException {
  InternetException([String? message])
      : super(message, 'No internet connection');
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message]) : super(message, 'Request time out');
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error occurred while communicating with server');
}

class URLException extends AppException {
  URLException([String? message])
      : super(message, 'Invalid URl');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message])
      : super(message, 'Token is invalid');
}