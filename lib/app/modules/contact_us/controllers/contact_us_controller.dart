import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/providers/api_service.dart';
import '../../../widgets/app_snack.dart';

class ContactUsController extends GetxController {

  final email = TextEditingController();
  final name = TextEditingController();
  final subject = TextEditingController();
  final message = TextEditingController();

  final _apiService = ApiService();
  var isLoading = false.obs;


  @override
  void onClose() {
    email.dispose();
    name.dispose();
    subject.dispose();
    message.dispose();
    super.onClose();
  }

  void contactUs() async {
    if(name.text.isEmpty){
      AppSnack.errorSnack('The name field is required.');
      return;
    }
    if(email.text.isEmpty){
      AppSnack.errorSnack('The email field is required.');
      return;
    }
    if(subject.text.isEmpty){
      AppSnack.errorSnack('The subject field is required.');
      return;
    }
    if(message.text.isEmpty){
      AppSnack.errorSnack('The message field must be at least 10 characters.');
      return;
    }
    try {
      isLoading(true);
      final response = await _apiService.contactUs(
          name.text, email.text, subject.text, message.text);

      if (response != null && response.statusCode == 200) {
        AppSnack.successSnack(response.data['message']);
        Get.offAllNamed(Routes.HOME);
      } else {
        var err = response!.data['errors'];
        var firstError = err.containsKey("name")
            ? err['name'][0]
            : err.containsKey("email")
            ? err['email'][0]
            : err.containsKey("subject")
            ? err['subject'][0]
            : err.containsKey("message")
            ? err['message'][0]
            : 'Something went wrong';
        AppSnack.errorSnack(firstError,);
      }
    } catch (e) {
      AppSnack.errorSnack("$e",);
    } finally {
      isLoading(false);
    }
  }

}
