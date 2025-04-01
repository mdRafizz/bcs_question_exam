import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/providers/api_service.dart';

class RegisterController extends GetxController {
  /// Text Controllers for user input
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  var obscureText = true.obs;
  var cObscureText = true.obs;
  final isLoading = false.obs;

  /// API service instance
  final ApiService _apiService = ApiService();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    name.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  /// Register method
  void register() async {
    if (_isInputInvalid()) return;

    isLoading.value = true;
    try {
      final response = await _apiService.register(
        name.text.trim(),
        email.text.trim(),
        password.text,
        confirmPassword.text,
      );

      if (response == null) {
        AppSnack.errorSnack("No Internet Connection");
        return;
      }

      _handleResponse(response);
    } catch (e) {
      AppSnack.errorSnack("An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Validate user input
  bool _isInputInvalid() {
    if (name.text.trim().isEmpty) {
      AppSnack.errorSnack('Please provide your full name.');
      return true;
    }

    if (email.text.trim().isEmpty) {
      AppSnack.errorSnack('Please enter your email address.');
      return true;
    }

    if (!isValidEmail(email.text.trim())) {
      AppSnack.errorSnack('Please enter a valid email address.');
      return true;
    }

    if (password.text.isEmpty) {
      AppSnack.errorSnack('Please create a secure password.');
      return true;
    }

    if (confirmPassword.text.isEmpty) {
      AppSnack.errorSnack('Please confirm your password.');
      return true;
    }

    if (password.text != confirmPassword.text) {
      AppSnack.errorSnack('The passwords you entered do not match.');
      return true;
    }

    return false;
  }

  /// Handle API response
  void _handleResponse(response) {
    switch (response.statusCode) {
      case 200:
        AppSnack.successSnack("Registration Successful!");
        Get.offNamed(Routes.LOGIN);
        break;
      case 422:
        String errorMsg =
            response.data['errors']['email']?.first ??
            response.data['errors']['password']?.first ??
            "Validation Error!";
        AppSnack.errorSnack(errorMsg);
        break;
      case 404:
        AppSnack.errorSnack("API Endpoint Not Found!");
        break;
      case 500:
        AppSnack.errorSnack("Something went wrong!");
        break;
      default:
        AppSnack.errorSnack("Unexpected error occurred.");
    }
  }

  /// Regular expression for basic email validation.
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
}
