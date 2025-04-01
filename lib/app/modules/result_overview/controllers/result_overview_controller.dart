import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/exam_result.dart';

class ResultOverviewController extends GetxController {
  late ExamResult result;

  @override
  void onInit() {
    fetchExamResult();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchExamResult() {
    // print(response);
    result = ExamResult.fromJson(Get.arguments['response']);

    for (var question in result.detailedResults!) {
      debugPrint("Question: ${question.question}");
      debugPrint("Selected Option: ${question.selectedOption}");
      debugPrint("Correct Answer: ${question.correctAnswer}");
      debugPrint("Is Correct: ${question.isCorrect}");
    }
  }
}
