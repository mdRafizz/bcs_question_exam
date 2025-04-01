import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/providers/api_service.dart';
import '../../../routes/app_pages.dart';

class DataDeletionController extends GetxController {
  var isLoading = false.obs;
  final _apiService = ApiService();
  final reason = TextEditingController();
  final box = GetStorage();


  @override
  void onClose() {
    reason.dispose();
    super.onClose();
  }

  void deleteAccount() async {
    if (reason.text.isEmpty) {
      AppSnack.errorSnack('Please tell us why you want to delete?');
    } else {
      try {
        isLoading(true);
        final response = await _apiService.dataDeletion(reason.text, box.read('token'));
        if (response != null) {
          if (response.statusCode == 200) {
            AppSnack.successSnack(response.data['message']);
            Get.offAllNamed(Routes.HOME);
          } else {
            AppSnack.errorSnack('${response.data["errors"]['reason'][0]}');
          }
        } else {
          AppSnack.errorSnack('Unable to get response.');
        }
      } catch (e) {
        AppSnack.errorSnack("Error: $e");
      }
      finally{
        isLoading(false);
      }
    }
  }
}
