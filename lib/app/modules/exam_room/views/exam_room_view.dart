import 'dart:ui';

import 'package:bcs_preli_preparation/app/data/model/question.dart';
import 'package:bcs_preli_preparation/app/modules/exam_room/widgets/exam_exit_alert.dart';
import 'package:bcs_preli_preparation/app/widgets/app_loader.dart';
import 'package:bcs_preli_preparation/app/widgets/reusable_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/exam_room_controller.dart';

class ExamRoomView extends GetView<ExamRoomController> {
  const ExamRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        showDialog(
          context: context,
          builder: (context) => const ExamExitAlert(),
        );
      },
      child: Scaffold(
        backgroundColor: CupertinoColors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Exam Room',
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontFamily: 'ferdoka',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              actions: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.r)),
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      child: const ReusableText(
                        '--:--:--',
                        size: 14.5,
                        color: Colors.white,
                        weight: FontWeight.w600,
                        letterSpacing: 1.3,
                      ),
                    );
                  }

                  int hours = controller.remainingTime.value ~/ 3600;
                  int minutes = (controller.remainingTime.value % 3600) ~/ 60;
                  int seconds = controller.remainingTime.value % 60;

                  String formattedTime;
                  if (hours > 0) {
                    formattedTime =
                    "${hours.toString().padLeft(2, '0')}:${minutes.toString()
                        .padLeft(2, '0')}:${seconds.toString().padLeft(
                        2, '0')}";
                  } else {
                    formattedTime =
                    "${minutes.toString().padLeft(2, '0')}:${seconds.toString()
                        .padLeft(2, '0')}";
                  }

                  bool isLessThan10Minutes =
                      controller.remainingTime.value < 600;

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.r)),
                      color: isLessThan10Minutes ? Colors.red : Colors.blue,
                    ),
                    padding: EdgeInsets.fromLTRB(8.w, 5.h, 6.w, 5.h),
                    child: ReusableText(
                      formattedTime,
                      size: 14.5,
                      color: Colors.white,
                      weight: FontWeight.w600,
                      letterSpacing: 1.3,
                    ),
                  );
                }),
                Gap(8.w),
              ],
              pinned: true,
              floating: false,
              forceMaterialTransparency: true,
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: CupertinoColors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
            // Obx(() {
            //   if (controller.isLoading.value) {
            //     return SliverToBoxAdapter(
            //       child: Center(child: AppLoader.defaultLoader(context)),
            //     );
            //   }
            //   else {
            //     if (controller.isSuccess.value) {
            //       return SliverFillRemaining(
            //         hasScrollBody: true,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Gap(20.h),
            //             Container(
            //               padding: EdgeInsets.symmetric(vertical: 10.h),
            //               margin: EdgeInsets.symmetric(horizontal: 12.w),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(9.r),
            //                 // color: Colors.white,
            //                 border: Border.all(
            //                     color: CupertinoColors.systemGrey4),
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Padding(
            //                     padding: EdgeInsets.only(left: 10.w),
            //                     child: ReusableText(
            //                       'Question List',
            //                       family: 'ferdoka',
            //                       weight: FontWeight.w600,
            //                       size: 19,
            //                     ),
            //                   ),
            //                   Gap(8.h),
            //                   SizedBox(
            //                     height: 34.h,
            //                     child: ListView.builder(
            //                       key: ValueKey(controller.questions.length),
            //                       controller: controller.scrollController,
            //                       scrollDirection: Axis.horizontal,
            //                       itemCount: controller.questions.length,
            //                       itemBuilder: (context, index) {
            //                         int number = index + 1;
            //                         return GestureDetector(
            //                           onTap: () {
            //                             controller.jumpToQuestion(index);
            //                           },
            //                           child: Obx(() {
            //                             return Container(
            //                               key: ValueKey(
            //                                 controller.currentQuestionIndex
            //                                     .value,
            //                               ),
            //                               // এখানে একটি ইউনিক কী ব্যবহার করুন
            //                               margin: EdgeInsets.symmetric(
            //                                 horizontal: 8.w,
            //                               ),
            //                               width: 40.w,
            //                               decoration: BoxDecoration(
            //                                 shape: BoxShape.circle,
            //                                 color:
            //                                 controller
            //                                     .currentQuestionIndex
            //                                     .value ==
            //                                     index
            //                                     ? Colors.blue.shade300
            //                                     : Colors.transparent,
            //                                 border: Border.all(
            //                                   color: CupertinoColors
            //                                       .systemGrey3,
            //                                   width: .9.w,
            //                                 ),
            //                               ),
            //                               alignment: Alignment.center,
            //                               child: Text(
            //                                 '$number',
            //                                 style: TextStyle(
            //                                   fontSize: 18,
            //                                   fontWeight: FontWeight.w600,
            //                                   fontFamily: 'ferdoka',
            //                                   color:
            //                                   controller
            //                                       .currentQuestionIndex
            //                                       .value ==
            //                                       index
            //                                       ? Colors.white
            //                                       : Colors.black,
            //                                 ),
            //                               ),
            //                             );
            //                           }),
            //                         );
            //                       },
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Gap(10.h),
            //             Flexible(
            //               child: PageView.builder(
            //                 controller: controller.pageController,
            //                 itemCount: controller.questions.length,
            //                 physics: const NeverScrollableScrollPhysics(),
            //                 itemBuilder: (_, i) {
            //                   var question = controller.questions[i];
            //                   return _questionCard('${i + 1}', question);
            //                 },
            //               ),
            //             ),
            //             Gap(20.h),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 TextButton(
            //                   onPressed:
            //                   controller.currentQuestionIndex.value > 0
            //                       ? () =>
            //                       controller.jumpToQuestion(
            //                         controller.currentQuestionIndex.value - 1,
            //                       )
            //                       : null,
            //                   child: ReusableText(
            //                     '← Previous',
            //                     size: 18,
            //                     family: 'ferdoka',
            //                     color: Colors.blue,
            //                   ),
            //                 ),
            //                 TextButton(
            //                   onPressed:
            //                   controller.currentQuestionIndex.value <
            //                       controller.questions.length - 1
            //                       ? () =>
            //                       controller.jumpToQuestion(
            //                         controller.currentQuestionIndex.value + 1,
            //                       )
            //                       : null,
            //                   child: ReusableText(
            //                     'Next →',
            //                     size: 18,
            //                     color: Colors.blue,
            //                     family: 'ferdoka',
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Obx(() {
            //               if (controller.selectedAnswers.isEmpty) {
            //                 return SizedBox.shrink();
            //               }
            //               return Padding(
            //                 padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 0),
            //                 child: CupertinoButton(
            //                   onPressed: () {
            //                     controller.submitAnswer();
            //                   },
            //                   color: const Color(0xFF1d9279),
            //                   sizeStyle: CupertinoButtonSize.medium,
            //                   child: Obx(
            //                         () =>
            //                     controller.isSubmitting.value
            //                         ? Center(
            //                       child: CupertinoActivityIndicator(
            //                         color: CupertinoColors.white,
            //                       ),
            //                     )
            //                         : Center(
            //                       child: ReusableText(
            //                         'উত্তর সাবমিট করুন',
            //                         family: 'bn',
            //                         size: 18,
            //                         color: CupertinoColors.white,
            //                         weight: FontWeight.w600,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             }),
            //             Gap(20.h),
            //           ],
            //         ),
            //       );
            //     }
            //     else {
            //       return SliverFillRemaining(
            //         child: Center(
            //           child: Obx(() {
            //             return ReusableText(controller.message.value,color: Colors.black,);
            //           }),
            //         ),
            //       );
            //     }
            //   }
            // }),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.r),
                      // color: Colors.white,
                      border: Border.all(
                          color: CupertinoColors.systemGrey4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: ReusableText(
                            'Question List',
                            family: 'ferdoka',
                            weight: FontWeight.w600,
                            size: 19,
                          ),
                        ),
                        Gap(8.h),
                        SizedBox(
                          height: 34.h,
                          child: ListView.builder(
                            key: ValueKey(controller.questions.length),
                            controller: controller.scrollController,
                            // physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.questions.length,
                            itemBuilder: (context, index) {
                              int number = index + 1;
                              return GestureDetector(
                                onTap: () {
                                  controller.jumpToQuestion(index);
                                },
                                child: Obx(() {
                                  return Container(
                                    key: ValueKey(
                                      controller.currentQuestionIndex
                                          .value,
                                    ),
                                    // এখানে একটি ইউনিক কী ব্যবহার করুন
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                      controller
                                          .currentQuestionIndex
                                          .value ==
                                          index
                                          ? Colors.blue.shade300
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: CupertinoColors
                                            .systemGrey3,
                                        width: .9.w,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$number',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'ferdoka',
                                        color:
                                        controller
                                            .currentQuestionIndex
                                            .value ==
                                            index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10.h),
                  Flexible(
                    child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.questions.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index){
                        controller.currentQuestionIndex(index);
                        if (controller.scrollController.hasClients) {
                          double itemWidth = 40.w + 8.w * 2;
                          double scrollPosition = index * itemWidth;

                          controller.scrollController.animateTo(
                            scrollPosition,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        }
                      },
                      itemBuilder: (_, i) {
                        var question = controller.questions[i];
                        return _questionCard('${i + 1}', question);
                      },
                    ),
                  ),
                  Gap(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed:(){
                          if(controller.currentQuestionIndex.value > 0){
                            controller.jumpToQuestion(controller.currentQuestionIndex.value -1);
                          }
                        },
                        child: ReusableText(
                          '← Previous',
                          size: 18,
                          family: 'ferdoka',
                          color: Colors.blue,
                        ),
                      ),
                      TextButton(
                        onPressed:(){
                          if(controller.currentQuestionIndex.value <
                              controller.questions.length - 1){
                            controller.jumpToQuestion(controller.currentQuestionIndex.value+1);
                          }
                        },
                        child: ReusableText(
                          'Next →',
                          size: 18,
                          color: Colors.blue,
                          family: 'ferdoka',
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.selectedAnswers.isEmpty) {
                      return SizedBox.shrink();
                    }
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 0),
                      child: CupertinoButton(
                        onPressed: () {
                          controller.submitAnswer();
                        },
                        color: const Color(0xFF1d9279),
                        sizeStyle: CupertinoButtonSize.medium,
                        child: Obx(
                              () =>
                          controller.isSubmitting.value
                              ? Center(
                            child: CupertinoActivityIndicator(
                              color: CupertinoColors.white,
                            ),
                          )
                              : Center(
                            child: ReusableText(
                              'উত্তর সাবমিট করুন',
                              family: 'bn',
                              size: 18,
                              color: CupertinoColors.white,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  Gap(20.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _questionCard(String sl, Question question) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: SingleChildScrollView(
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
              textAlign: TextAlign.justify,
              family: 'bn',
              weight: FontWeight.w600,
            ),
            Gap(20.h),
            _optionBox(question.id!, 1, 'A', question.option1.toString()),
            _optionBox(question.id!, 2, 'B', question.option2.toString()),
            _optionBox(question.id!, 3, 'C', question.option3.toString()),
            _optionBox(question.id!, 4, 'D', question.option4.toString()),
            if (question.option5 != null)
              _optionBox(question.id!, 5, 'E', question.option5.toString()),
          ],
        ),
      ),
    );
  }

  Widget _optionBox(int questionId,
      int optionNumber,
      String serial,
      String option,) {
    return Obx(() {
      int? selected = controller.selectedAnswers[questionId];
      bool isSelected = selected == optionNumber;
      Color bgColor = isSelected ? Colors.blue : Colors.transparent;
      Color borderColor = isSelected ? Colors.blue : Colors.black12;
      Color fontColor = isSelected ? CupertinoColors.white : Colors.black;
      Color circularColor = isSelected ? CupertinoColors.white : Colors.black54;
      Color circularFontColor =
      isSelected ? Colors.black : CupertinoColors.white;

      return GestureDetector(
        onTap: () => controller.selectAnswer(questionId, optionNumber),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 11.h),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: circularColor,
                    radius: 15.r,
                    child: ReusableText(
                      serial,
                      family: 'ferdoka',
                      size: 15,
                      weight: FontWeight.w600,
                      color: circularFontColor,
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: ReusableText(
                      option,
                      size: 19,
                      color: fontColor,
                      family: 'bn',
                      weight: FontWeight.w600,
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
