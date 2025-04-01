import 'package:bcs_preli_preparation/app/data/providers/api_service.dart';
import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../widgets/app_snack.dart';

class HomeController extends GetxController {

  var isLoading = false.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late GetStorage box;
  final _apiService = ApiService();

  @override
  void onInit() {
    box = GetStorage();
    super.onInit();
  }


  void logout() async {
    try {
      isLoading(true);
      final response = await _apiService.logout(box.read('token'));

      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        box.remove("token");
        Get.offAllNamed(Routes.HOME);
        AppSnack.successSnack('Logout successful!');
      } else {
        AppSnack.errorSnack(response.statusMessage.toString());
      }
    } catch (e) {
      AppSnack.errorSnack(e.toString());
      debugPrint('logout error: $e');
    }
    finally{
      isLoading(false);
    }
  }
}
