import 'package:bcs_preli_preparation/app/data/model/question.dart';
import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../widgets/app_loader.dart';
import '../../../widgets/reusable_text.dart';
import '../controllers/practice_question_controller.dart';

class PracticeQuestionView extends GetView<PracticeQuestionController> {
  const PracticeQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: Get.arguments['title']),
          Obx(() {
            if (controller.isLoading.value) {
              return SliverToBoxAdapter(
                child: Center(child: AppLoader.defaultLoader(context)),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) =>
                    _questionCard('${i + 1}', controller.questions[i]),
                childCount: controller.questions.length,
              ),
            );
          }),
        ],
      ),
    );
  }

  Container _questionCard(String sl, Question question) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.all(Radius.circular(9.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            'Question $sl',
            weight: FontWeight.w600,
            family: 'ferdoka',
            size: 17,
          ),
          Divider(color: CupertinoColors.systemGrey4),
          Gap(10.h),
          if (question.titleImage != null)
            CachedNetworkImage(
              imageUrl: question.titleImage!,
              height: 80.h,
              placeholder: (_, _) => CupertinoActivityIndicator(),
            ),
          ReusableText(
            question.question.toString(),
            size: 19,
            weight: FontWeight.bold,
            family: 'bn',
            textAlign: TextAlign.left,
          ),
          Gap(17.h),
          _optionBox(question, 1, 'A', question.option1.toString()),
          _optionBox(question, 2, 'B', question.option2.toString()),
          _optionBox(question, 3, 'C', question.option3.toString()),
          _optionBox(question, 4, 'D', question.option4.toString()),
          if (question.option5 != null)
            _optionBox(question, 5, 'E', question.option5.toString()),

          if (question.explanation != null || question.explanationImage != null)
            Obx(() {
              if (controller.selectedAnswers.containsKey(question.id)) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: CupertinoColors.systemGrey4),
                    Gap(3.h),
                    ReusableText('Description:',size: 19,family: 'ferdoka',weight: FontWeight.w600,),
                    Gap(2.h),
                  ],
                );
              }
              return SizedBox.shrink();
            }),
          if (question.explanationImage != null)
            Obx(() {
              if (question.explanationImage != null &&
                  controller.selectedAnswers.containsKey(question.id)) {
                return CachedNetworkImage(imageUrl: question.explanationImage!);
              }
              return SizedBox.shrink();
            }),

          if (question.explanation != null)
            Obx(() {
              if (question.explanation != null &&
                  controller.selectedAnswers.containsKey(question.id)) {
                return HtmlWidget(
                  question.explanation!,
                  textStyle: TextStyle(fontFamily: 'bn', fontSize: 17.sp),
                );
              }
              return SizedBox.shrink();
            }),
        ],
      ),
    );
  }

  Widget _optionBox(
    Question question,
    int optionNumber,
    String serial,
    String option,
  ) {
    return Obx(() {
      int? selected = controller.selectedAnswers[question.id];
      bool isSelected = selected == optionNumber;
      bool isCorrect = question.rightAns == optionNumber;
      bool hasAnswered = selected != null;

      Color bgColor = Colors.transparent;
      Color borderColor = Colors.black12;

      if (hasAnswered) {
        if (isSelected) {
          bgColor = isCorrect ? Colors.green : Colors.red;
          borderColor = isCorrect ? Colors.green : Colors.red;
        } else if (isCorrect) {
          bgColor = Colors.green;
          borderColor = Colors.green;
        }
      }

      return GestureDetector(
        onTap: () {
          if (hasAnswered) return;
          controller.selectAnswer(question.id!, optionNumber);
        },
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 375),
              // Smooth animation
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        hasAnswered && isSelected
                            ? Colors.white
                            : Colors.black54,
                    radius: 14.r,
                    child: ReusableText(
                      serial,
                      family: 'ferdoka',
                      size: 15,
                      weight: FontWeight.w600,
                      color:
                          hasAnswered && isSelected
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: ReusableText(
                      option,
                      family: 'bn',
                      size: 17,
                      weight: FontWeight.bold,
                      color:
                          hasAnswered && isSelected
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Gap(20.h),
          ],
        ),
      );
    });
  }
}

class MyWidgetFactory extends WidgetFactory with CachedNetworkImageFactory {}
