import 'dart:io';

class AuthUtil {
  AuthUtil._();

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateDistrict(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your district';
    }
    return null;
  }

  static String? validateService(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your service';
    }
    return null;
  }

  static String? validateExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your experience';
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Please enter a valid experience';
    }
    return null;
  }

  static String? validateImage(File? image) {
    if (image == null) {
      return 'Please upload an image';
    }
    return null;
  }
}
