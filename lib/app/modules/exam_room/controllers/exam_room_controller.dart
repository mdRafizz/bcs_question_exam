import 'dart:async';

import 'package:bcs_preli_preparation/app/data/model/question.dart';
import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/providers/api_service.dart';

class ExamRoomController extends GetxController {
  var isLoading = false.obs;
  var isSubmitting = false.obs;
  var questions = <Question>[].obs;
  var selectedAnswers = <int, int>{}.obs;

  final _apiService = ApiService();
  final box = GetStorage();

  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  var currentQuestionIndex = 0.obs;

  var remainingTime = 0.obs;
  var isStopped = false.obs;

  @override
  void onInit() {
    super.onInit();
    // loadQuestion(
    //   id: Get.arguments['categoryId'],
    //   dataRequest: Get.arguments['data'],
    // );
    questions.assignAll(Get.arguments['questions']);
    startTimer(Get.arguments['time']);
  }


  @override
  void onClose() {
    stopTimer();
    pageController.dispose();
    scrollController.dispose();
    super.onClose();
  }


  void jumpToQuestion(int index) {
    currentQuestionIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );


    if (scrollController.hasClients) {
      double itemWidth = 40.w + 8.w * 2;
      double scrollPosition = index * itemWidth;

      scrollController.animateTo(
        scrollPosition,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      jumpToQuestion(currentQuestionIndex.value + 1);
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      jumpToQuestion(currentQuestionIndex.value - 1);
    }
  }

  void selectAnswer(int questionId, int selectedOption) {
    if (!selectedAnswers.containsKey(questionId)) {
      selectedAnswers[questionId] = selectedOption;
    }
  }

  void startTimer(String time) {
    String examTimeString = time;

    double examTimeInMinutesDouble = double.parse(examTimeString);
    int minutes = examTimeInMinutesDouble.toInt();
    int seconds = ((examTimeInMinutesDouble - minutes) * 60).toInt();
    int totalSeconds = minutes * 60 + seconds;
    remainingTime.value = totalSeconds;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0 && !isStopped.value) {
        remainingTime.value--;
      } else {
        timer.cancel();
        if (remainingTime.value == 0) {
          if(selectedAnswers.isNotEmpty) {
            AppSnack.warningSnack('সময় শেষ হওয়ায়, আপনার উত্তরপত্রটি স্বয়ংক্রিয়ভাবে জমা হয়েছে');
            submitAnswer();
          }else{
            AppSnack.errorSnack('দুঃখিত, নির্ধারিত সময়ের মধ্যে আপনি প্রশ্নের উত্তর প্রদান না করায় ফলাফল তৈরি হয়নি।');
            Get.offAllNamed(Routes.HOME);
          }
        }
      }
    });
  }

  void stopTimer() {
    isStopped.value = true;
  }

  void submitAnswer() async {
    try {
      stopTimer();
      isSubmitting(true);
      print(Get.arguments['title']);
      print(box.read('token'));
      final response = await _apiService.submitExam(
        selectedAnswers,
        box.read('token'),
        Get.arguments['title'],
      );

      if (response.statusCode == 200) {
        Get.offNamed(Routes.RESULT_OVERVIEW, arguments: {'response': response.data});
      }
    } catch (e) {
      AppSnack.errorSnack('unable to submit: $e');
    } finally {
      isSubmitting(false);
    }
  }
}
