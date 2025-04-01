import 'package:get/get.dart';

import '../controllers/practice_question_controller.dart';

class PracticeQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PracticeQuestionController>(
      () => PracticeQuestionController(),
    );
  }
}
