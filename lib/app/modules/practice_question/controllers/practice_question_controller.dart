import 'dart:convert';

import 'package:bcs_preli_preparation/app/data/providers/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/model/question.dart';

class PracticeQuestionController extends GetxController {

  var isLoading = false.obs;
  var questions = <Question>[].obs;
  var selectedAnswers = <int, int>{}.obs;

  final _apiService = ApiService();



  @override
  void onInit() {
    debugPrint('id: ${Get.arguments['categoryId']}');
    loadQuestion(Get.arguments['categoryId']);
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

  void loadQuestion(String id) async {
    try{
      debugPrint('0');
      isLoading(true);
      debugPrint('1');

      final fetchedQuestions = await _apiService.fetchQuestionsByCategory(id);

      debugPrint('2');
      debugPrint('Fetched Questions Count: ${fetchedQuestions.length}');

      questions.assignAll(fetchedQuestions);
      debugPrint('Stored Questions Count: ${questions.length}');

      for (var question in questions) {
        debugPrint(question.toString());
      }
    }catch(e){
      debugPrint('Something went wrong: $e');
    }finally{
      isLoading(false);
    }
  }

  void selectAnswer(int questionId, int selectedOption) {
    selectedAnswers[questionId] = selectedOption;
  }

}
