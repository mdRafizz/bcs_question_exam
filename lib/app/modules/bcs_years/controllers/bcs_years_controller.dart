import 'dart:math';

import 'package:bcs_preli_preparation/app/data/model/subject_category.dart';
import 'package:bcs_preli_preparation/app/data/providers/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/model/question.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/question_fetching_error_dialogue.dart';

class BcsYearsController extends GetxController {
  var isLoading = false.obs;
  var isQLoading = false.obs;
  var categories = <SubjectCategory>[].obs;
  var colors = <Color>[].obs;
  final _apiService = ApiService();
  final box = GetStorage();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadData() async {
    try {
      debugPrint('0');
      isLoading(true);
      debugPrint('1');
      final fetchedCategories = await _apiService.fetchCategories();
      debugPrint('2');
      categories.value = fetchedCategories;
      debugPrint('3');
      generateColors(categories.length);
    } catch (e) {
      debugPrint('Error on loading category: $e');
    } finally {
      isLoading(false);
    }
  }

  void generateColors(int count) {
    List<Color> generatedColors = [];
    Random random = Random();

    for (int i = 0; i < count; i++) {
      generatedColors.add(
        Color.fromARGB(
          255,
          random.nextInt(156) + 100,
          random.nextInt(156) + 100,
          random.nextInt(156) + 100,
        ),
      );
    }

    colors.value = generatedColors;
  }

  void loadQuestion(int id, String title) async {
    try {
      debugPrint('0');
      isQLoading(true);
      debugPrint('1');

      var requestData = {
        "category_id": id,
        "subject": null,
        "sub_subject_bangla": null,
        "sub_subject_english": null,
        "sub_subject_math": null,
        "sub_subject_baf": null,
        "sub_subject_iaf": null,
        "sub_subject_geo": null,
        "sub_subject_ict": null,
        "sub_subject_metal_ability": null,
        "sub_subject_gensc": null,
        "question_no": null,
        "exam_time": null,
      };

      final response = await _apiService.fetchQuestionsForYearlyExam(
        requestData,
        box.read('token'),
      );

      debugPrint('2');
      if (response.data['success'] == false) {
        debugPrint('3');
        showDialog(
          context: Get.context!,
          builder:
              (_) => QuestionFetchingErrorDialogue(
                message: response.data['message'].toString(),
              ),
        );
        return;
      }

      List<dynamic> data = response.data['data'];
      debugPrint('API Raw Data Length: ${data.length}');

      List<Question> q = data.map((json) => Question.fromJson(json)).toList();
      Get.toNamed(
        Routes.EXAM_ROOM,
        arguments: {
          'questions': q,
          'time': response.data['exam_time_minutes'].toString(),
          'title': title,
        },
      );

      // startTimer(response.data['exam_time_minutes'].toString());
    } catch (e) {
      debugPrint('Something went wrong: $e');
    } finally {
      isQLoading(false);
    }
  }
}
