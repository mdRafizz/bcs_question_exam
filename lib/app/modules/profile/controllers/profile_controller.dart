import 'package:bcs_preli_preparation/app/data/model/user.dart';
import 'package:bcs_preli_preparation/app/data/providers/api_service.dart';
import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/model/exma_history.dart';

class ProfileController extends GetxController {
  final GetStorage box = GetStorage();
  final _apiService = ApiService();
  var isLoading = false.obs;
  var isLoggingOut = false.obs;
  var isHistoryLoading = false.obs;
  var name = ''.obs;
  var phoneNumber = ''.obs;
  var university = ''.obs;
  var address = ''.obs;
  var selectedFileName = ''.obs;
  var selectedFileExtension = ''.obs;
  var selectedFileBytes = Rxn<Uint8List>();
  final ImagePicker _picker = ImagePicker();
  var user = Rxn<User>();
  var examHistory = Rxn<ExamHistory>();

  @override
  void onInit() {
    loadProfileInfo();
    loadExamHistory();
    super.onInit();
  }


  void loadProfileInfo() async {
    try {
      isLoading(true);
      final response = await _apiService.userInfo(box.read('token'));

      if (response != null) {
        if (response.statusCode == 200) {
          user.value = User.fromJson(response.data['data']);
          if (kDebugMode) {
            print(user.value?.id);
            print(user.value?.name);
            print(user.value?.email);
            // print(data);
          }
        } else {
          if (kDebugMode) {
            print(response.statusCode);
          }
        }
      } else {
        if (kDebugMode) {
          print('response খালি');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('ইরর: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  //*****************************************

  Future<void> pickProfile() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      selectedFileName.value = pickedFile.name;
      selectedFileBytes.value = await pickedFile.readAsBytes();
    }
  }

  //*****************************************

  void updateProfile() async {
    try {
      isLoading(true);
      final response = await _apiService.updateProfile(
        selectedFileBytes.value,
        selectedFileName.value,
        university.value,
        address.value,
        phoneNumber.value,
        box.read('token'),
      );

      if (response == null) {
        AppSnack.errorSnack("No Internet Connection");
        return;
      }

      if (response.statusCode == 200) {
        AppSnack.successSnack('Profile updated successfully!');
        Get.offAllNamed(Routes.HOME);
      } else {
        var err = response.data['errors'];
        var firstError =
            err.containsKey("profile_image")
                ? err['profile_image'][0]
                : err.containsKey("mobile")
                ? err['mobile'][0]
                : err.containsKey("university")
                ? err['university'][0]
                : err.containsKey("address")
                ? err['address'][0]
                : 'Something went wrong';
        AppSnack.errorSnack(firstError);
      }
    } catch (e) {
      AppSnack.errorSnack("An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  //*****************************************

  void loadExamHistory() async {
    try {
      isHistoryLoading(true);

      final response = await _apiService.examHistory(box.read('token'));


        if (response.statusCode == 200) {
          examHistory.value = ExamHistory.fromJson(response.data);
        } else {
          AppSnack.errorSnack('Failed to load exam history');
        }
      } catch (e) {
        AppSnack.errorSnack('Error: $e');
      } finally {
        isHistoryLoading(false);
      }
  }

  void logout() async {
    try {
      isLoggingOut(true);
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
      isLoggingOut(false);
    }
  }

}
