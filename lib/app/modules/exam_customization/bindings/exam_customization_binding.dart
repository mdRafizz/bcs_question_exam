import 'package:get/get.dart';

import '../controllers/exam_customization_controller.dart';

class ExamCustomizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamCustomizationController>(
      () => ExamCustomizationController(),
    );
  }
}
