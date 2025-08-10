class AppMasks {
  AppMasks._();
  static String maskEmail(String emailAddress) {
    List<String> parts = emailAddress.split('@');
    if (parts.length == 2) {
      String username = parts[0];
      String maskedUsername = username.substring(0, 2) + '*' * (username.length - 2);
      return '$maskedUsername@${parts[1]}';
    } else {
      return emailAddress;
    }
  }
}