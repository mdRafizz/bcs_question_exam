import 'package:get/get.dart';

import '../controllers/result_overview_controller.dart';

class ResultOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultOverviewController>(
      () => ResultOverviewController(),
    );
  }
}
