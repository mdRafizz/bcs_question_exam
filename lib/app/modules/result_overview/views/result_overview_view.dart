import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:bcs_preli_preparation/app/widgets/reusable_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../data/model/question_result.dart';
import '../controllers/result_overview_controller.dart';

class ResultOverviewView extends GetView<ResultOverviewController> {
  const ResultOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: 'Result Overview'),
          SliverList(
            delegate: SliverChildListDelegate([
              Gap(30.h),
              _examInfo('Exam name: ', controller.result.examName!),
              Gap(10.h),
              _examInfo(
                'Total marks:',
                controller.result.totalMarks.toString(),
                color: Colors.blue,
              ),
              Gap(10.h),
              _examInfo(
                'Negative marks: ',
                controller.result.negativeMarks.toString(),
                color: Colors.red,
              ),
              Gap(5.h),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                padding: EdgeInsets.symmetric(vertical: 7.h),
                alignment: Alignment.center,
                child: Row(
                  spacing: 10.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      'Final score: ',
                      family: 'ferdoka',
                      size: 18,
                      weight: FontWeight.w600,
                      color: Colors.green,
                    ),
                    ReusableText(
                      controller.result.finalScore.toString(),
                      weight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, i) =>_questionCard('${i + 1}', controller.result.detailedResults![i],),
              childCount: controller.result.detailedResults!.length,
            ),
          ),
        ],
      ),
    );
  }

  Padding _examInfo(String key, String value, {Color color = Colors.black}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 9.w,
        children: [
          ReusableText(
            key,
            family: 'ferdoka',
            size: 18,
            weight: FontWeight.w600,
            color: color,
          ),
          Expanded(
            child: ReusableText(value, weight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  Widget _questionCard(String sl, QuestionResult question) {
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
              height: 50.h,
              placeholder: (_, __) => CupertinoActivityIndicator(),
            ),
          ReusableText(
            question.question,
            size: 19,
            weight: FontWeight.bold,
            family: 'bn',
            textAlign: TextAlign.left,
          ),
          Gap(17.h),
          optionBox(question, 1, 'A', question.options["option_1"]),
          optionBox(question, 2, 'B', question.options["option_2"]),
          optionBox(question, 3, 'C', question.options["option_3"]),
          optionBox(question, 4, 'D', question.options["option_4"]),
          if (question.options["option_5"] != null)
            optionBox(question, 5, 'E', question.options["option_5"]),

          if (question.explanation != null || question.explanationImage != null) ...[
            Divider(color: CupertinoColors.systemGrey4),
            Gap(3.h),
            ReusableText('Description:',size: 19,family: 'ferdoka',weight: FontWeight.w600,),
            Gap(2.h),
            if(question.explanationImage != null)
              CachedNetworkImage(imageUrl: question.explanationImage!),
            if(question.explanation != null)
            HtmlWidget(
              question.explanation!,
              textStyle: TextStyle(fontFamily: 'bn', fontSize: 17.sp),
            ),
          ],
        ],
      ),
    );
  }

  Widget optionBox(QuestionResult question, int optionNumber, String serial, String? option) {
    if (option == null) return SizedBox.shrink();

    bool isSelected = question.selectedOption == optionNumber;
    bool isCorrect = question.correctAnswer == optionNumber;
    bool hasAnswered = question.selectedOption != null;

    Color bgColor = Colors.transparent;
    Color borderColor = Colors.black12;
    Color textColor = Colors.black;
    Color avatarBgColor = Colors.black54;
    Color serialTextColor = Colors.white;

    if (hasAnswered) {
      if (isSelected) {
        bgColor = isCorrect ? const Color(0xff45b44a) : const Color(0xffe83130);
        borderColor = isCorrect ? const Color(0xff45b44a) : const Color(0xffe83130);
        textColor = Colors.white;
        avatarBgColor = Colors.white;
        serialTextColor = Colors.black;
      } else if (isCorrect) {
        bgColor = const Color(0xff45b44a);
        borderColor = const Color(0xff45b44a);
        textColor = Colors.white;
        avatarBgColor = Colors.white;
        serialTextColor = Colors.black;
      }
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 9.h),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: avatarBgColor,
                radius: 14.r,
                child: ReusableText(
                  serial,
                  family: 'ferdoka',
                  size: 15,
                  weight: FontWeight.w600,
                  color: serialTextColor,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: ReusableText(
                  option,
                  family: 'bn',
                  size: 17,
                  weight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        Gap(20.h),
      ],
    );
  }

}

