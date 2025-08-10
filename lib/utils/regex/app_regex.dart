class AppRegex {
  AppRegex._();
  static bool isEmailValidated (String email){
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return regex.hasMatch(email);
  }

  static bool isPassLowerCaseValidated (String pass){
    RegExp regex = RegExp(r'[a-z]');
    return regex.hasMatch(pass);
  }

  static bool isPassUpperCaseValidated (String pass){
    RegExp regex = RegExp(r'[A-Z]');
    return regex.hasMatch(pass);
  }

  static bool isPassNumberValidated (String pass){
    RegExp regex = RegExp(r'[0-9]');
    return regex.hasMatch(pass);
  }

  static bool isPassSpecialCharValidated (String pass){
    RegExp regex = RegExp(r'[!@#$%^&*]');
    return regex.hasMatch(pass);
  }

  static bool isPassEightCharValidated (String pass){
    RegExp regex = RegExp(r'.{8,}');
    return regex.hasMatch(pass);
  }

}