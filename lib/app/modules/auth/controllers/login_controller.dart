import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/providers/api_service.dart';

class LoginController extends GetxController {

  /// User Input Controllers
  final email = TextEditingController();
  final password = TextEditingController();

  /// Loading Indicator
  var obscureText = true.obs;
  var isLoading = false.obs;

  /// API Service Instance
  final ApiService _apiService = ApiService();

  /// Local Storage
  final box = GetStorage();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }


  /// Login Method
  void logIn() async {
    if (_isInputInvalid()) return;

    isLoading.value = true;
    try {
      final response = await _apiService.login(
        email.text.trim(),
        password.text,
      );

      if (response == null) {
        AppSnack.errorSnack("No Internet Connection",);
        return;
      }

      _handleResponse(response,);
    } catch (e) {
      AppSnack.errorSnack("An error occurred: $e",);
    } finally {
      isLoading.value = false;
    }
  }


  /// Validate Input Fields
  bool _isInputInvalid() {
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
    return false;
  }

  /// Handle API Response
  void _handleResponse(response) {
    switch (response.statusCode) {
      case 200:
        _storeUserData(response.data);
        AppSnack.successSnack("Login Successful!");
        Get.offAllNamed(Routes.HOME);
        break;
      case 422:
        AppSnack.errorSnack(
            response.data["message"] ?? "Validation Error!");
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


  /// Store User Data Locally
  void _storeUserData(Map<String, dynamic> data) {
    box.write("token", data["token"]);
    // box.write("user", data["user"]);
    if (kDebugMode) {
      print("User Info:\n${data['user']}\n");
      print("Token:\n${data['token']}");
    }
  }


  /// Regular expression for basic email validation.
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

}
