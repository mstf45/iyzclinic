import '../constants/app_strings.dart';

class ValidateClass {
  String? validateName(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.nameRequired;
    if (v.trim().length < 2) return AppStrings.minNameTwoRequired;
    return null;
  }

  String? validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.emailRequired;
    final emailReg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailReg.hasMatch(v.trim())) return AppStrings.validEmail;
    return null;
  }

  String? validatePassword(String? v) {
    if (v == null || v.isEmpty) return AppStrings.passwordRequired;
    if (v.length < 6) return AppStrings.shortPassword;
    return null;
  }

  String? validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.phoneNumberRequired;
    final digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) return AppStrings.validPhoneNumber;
    if (digits.length > 10) return AppStrings.invalidPhoneNumber;
    return null;
  }
}
