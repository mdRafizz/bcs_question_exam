import 'package:bcs_preli_preparation/app/data/providers/api_service.dart';
import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  late String? token;
  final _apiService = ApiService();

  var obscureText = true.obs;
  var cObscureText = true.obs;
  var isLoading = false.obs;

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    token = Get.arguments?['token'] ?? GetStorage().read("reset_token");

    if (token == null) {
      debugPrint("Token is null. Redirecting to Home...");
      Get.offAllNamed(Routes.HOME);
    } else {
      debugPrint("Token received: $token");
    }
  }

  @override
  void onReady() {
    GetStorage().remove('reset_token');
    super.onReady();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  void resetPassword() async {
    if (email.text.trim().isEmpty) {
      AppSnack.errorSnack('The email field is required.');
      return;
    } else if (password.text.length < 8) {
      AppSnack.errorSnack('The password field must be at least 8 characters.');
      return;
    } else if (confirmPassword.text != password.text) {
      AppSnack.errorSnack('The password field confirmation does not match.');
      return;
    } else {
      try {
        isLoading(true);
        final response = await _apiService.resetPassword(
          email.text.trim(),
          password.text,
          confirmPassword.text,
          Get.arguments['token'],
        );

        if (response != null && response.statusCode == 200) {
          Get.offAllNamed(Routes.HOME);
          AppSnack.successSnack('Password updated successfully!');
        } else {
          if (response == null) {
            AppSnack.errorSnack(
              'Something went wrong! Please try again later.',
            );
            return;
          }

          if (response.data != null) {
            if (response.data['errors'] != null &&
                response.data['errors']['email'] != null) {
              AppSnack.errorSnack(response.data['errors']['email'][0]);
            } else if (response.data['message'] != null) {
              AppSnack.errorSnack(response.data['message']);
            } else {
              AppSnack.errorSnack(
                'Something went wrong! Please try again later.',
              );
            }
          } else {
            AppSnack.errorSnack(
              'Something went wrong! Please try again later.',
            );
          }
        }
      } catch (e) {
        AppSnack.errorSnack(e.toString());
      } finally {
        isLoading(false);
      }
    }
  }
}
