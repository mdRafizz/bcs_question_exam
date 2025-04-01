import 'package:get/get.dart';

import '../controllers/bcs_years_controller.dart';

class BcsYearsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BcsYearsController>(
      () => BcsYearsController(),
    );
  }
}
