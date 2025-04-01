import 'package:bcs_preli_preparation/app/modules/auth/controllers/forget_password_controller.dart';
import 'package:bcs_preli_preparation/app/modules/auth/controllers/register_controller.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../controllers/reset_password_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
    Get.lazyPut(() => ResetPasswordController());
  }
}
