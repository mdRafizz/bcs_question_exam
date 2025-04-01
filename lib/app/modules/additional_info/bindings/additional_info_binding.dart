import 'package:get/get.dart';

import '../controllers/additional_info_controller.dart';

class AdditionalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdditionalInfoController>(
      () => AdditionalInfoController(),
    );
  }
}
