import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/providers/api_service.dart';

class ForgetPasswordController extends GetxController{
  final email = TextEditingController();
  final isLoading = false.obs;
  final ApiService _apiService = ApiService();

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }

  void forgetPassword()async {
    if(email.text.isEmpty){
      AppSnack.errorSnack('Please provide the email address associated with your account.');
    }else{
      try{
        debugPrint('0');
        isLoading(true);

        final response = await _apiService.forgetPassword(email.text.trim());

        debugPrint('1');

        if(response == null){
          debugPrint('response is null');
          AppSnack.errorSnack("Server error! Please try later.");
          return;
        }

        if(response.statusCode != 200){
          debugPrint('status code is not 200');
          debugPrint(response.statusCode.toString());
          debugPrint(response.statusMessage);
          print(response.data);
          print(response.data['errors']['email'][0] );
          final errorMessage = response.data['errors']['email'][0];
          AppSnack.errorSnack(errorMessage.toString());
          return;
        }

        debugPrint('2');

        final successMessage = response.data['message'];
        AppSnack.successSnack(successMessage.toString());
        Get.offAllNamed(Routes.HOME);

      }catch(e){
        AppSnack.errorSnack('Server error! Please try later.');
        debugPrint(e.toString());
      }finally{
        isLoading(false);
      }
    }
  }
}