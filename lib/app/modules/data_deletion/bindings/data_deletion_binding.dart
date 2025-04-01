import 'package:get/get.dart';

import '../controllers/data_deletion_controller.dart';

class DataDeletionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataDeletionController>(
      () => DataDeletionController(),
    );
  }
}
