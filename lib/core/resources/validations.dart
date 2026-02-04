import 'package:evently_c17/core/resources/strings_manager.dart';
import 'app_constants.dart';

class Validations {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringsManager.validateRequired;
    }
    if (!RegExp(AppConstants.emailRegex).hasMatch(value)) {
      return StringsManager.validateEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringsManager.validateRequired;
    }
    if (value.length < 8) {
      return StringsManager.validatePassword;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return StringsManager.validateRequired;
    }
    return null;
  }

  static String? validateConfirmPass(String? value, String pass) {
    if (value != pass) {
      return StringsManager.validateConfirmPassword;
    }
    return null;
  }
}
