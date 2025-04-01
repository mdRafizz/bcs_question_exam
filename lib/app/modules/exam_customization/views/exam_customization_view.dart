import 'dart:ui';

import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:bcs_preli_preparation/app/widgets/auth_warning_dialogue.dart';
import 'package:bcs_preli_preparation/app/widgets/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_app_bar.dart';
import '../controllers/exam_customization_controller.dart';

class ExamCustomizationView extends GetView<ExamCustomizationController> {
  const ExamCustomizationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CustomAppBar(title: 'Set Exam'),

              SliverList(
                delegate: SliverChildListDelegate([
                  Gap(25.h),
                  _examInfo(
                    'পরীক্ষার নাম',
                    'e.g.: customized test 1',
                    controller.examName,
                    keyboardType: TextInputType.text,
                  ),
                  Gap(30.h),
                  _examInfo(
                    'প্রশ্নের সংখ্যা',
                    'e.g.: 100',
                    controller.numberOfQuestions,
                  ),
                  Gap(30.h),
                  _examInfo('সময় (মিনিট)', 'e.g.: 120', controller.time),
                  Gap(30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ReusableText(
                      'বিষয়',
                      size: 20,
                      family: 'bn',
                      weight: FontWeight.w600,
                    ),
                  ),
                  if (Get.arguments == 'subjectWiseExam') Gap(8.h),
                  if (Get.arguments == 'subjectWiseExam')
                    Obx(
                      () => Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        ),
                        child: DropdownButton<String>(
                          value:
                              controller.selectedSingleSubject.value.isNotEmpty
                                  ? controller.selectedSingleSubject.value
                                  : null,
                          hint: ReusableText(
                            'Select Subject',
                            size: 15.2,
                            family: 'bn',
                          ),
                          underline: const SizedBox.shrink(),
                          dropdownColor: CupertinoColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18.r)),
                          icon: const SizedBox.shrink(),
                          items:
                              controller.subjects.map((subject) {
                                return DropdownMenuItem<String>(
                                  value: subject.value,
                                  child: ReusableText(
                                    subject.name,
                                    size: 15.2,
                                    family: 'bn',
                                  ),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectSingleSubject(value);
                            }
                          },
                        ),
                      ),
                    ),
                ]),
              ),
              if (Get.arguments == 'customizedExam')
                Obx(() {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final subject = controller.subjects[index];

                      return ExpansionTile(
                        key: ValueKey(subject.value),
                        tilePadding: EdgeInsets.only(right: 20.w),
                        title: Obx(
                          () => CheckboxListTile(
                            title: ReusableText(
                              subject.name,
                              size: 16,
                              weight: FontWeight.w600,
                            ),
                            value: controller.selectedSubjects.containsKey(
                              subject.value,
                            ),
                            onChanged:
                                (value) => controller.toggleSubject(subject),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        children:
                            subject.subSubjects.map((subSubject) {
                              return Obx(
                                () => Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: CheckboxListTile(
                                    key: ValueKey(subSubject.value),
                                    title: ReusableText(
                                      subSubject.name,
                                      size: 14.9,
                                    ),
                                    value: subSubject.isSelected.value,
                                    onChanged:
                                        (value) => controller.toggleSubSubject(
                                          subject,
                                          subSubject,
                                        ),
                                    // controlAffinity: ListTileControlAffinity.leading,
                                  ),
                                ),
                              );
                            }).toList(),
                      );
                    }, childCount: controller.subjects.length),
                  );
                }),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 35.h, 20.w, 15.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      onPressed: () {
                        if (controller.box.hasData('token')) {
                          if (controller.examName.text.isEmpty) {
                            AppSnack.errorSnack(
                              'অনুগ্রহপূর্বক পরীক্ষার নাম লিখুন',
                            );
                          } else if (controller.selectedSubjects.isEmpty &&
                              Get.arguments == 'customizedExam') {
                            AppSnack.errorSnack(
                              'অনুগ্রহপূর্বক নূন্যতম একটি বিষয় সিলেক্ট করুন।',
                            );
                          } else if (controller
                                  .selectedSingleSubject
                                  .value
                                  .isEmpty &&
                              Get.arguments == 'subjectWiseExam') {
                            AppSnack.errorSnack(
                              'অনুগ্রহপূর্বক বিষয় নির্বাচন করুন।',
                            );
                          } else {
                            // Get.offNamed(
                            //   Routes.EXAM_ROOM,
                            //   arguments: {
                            //     'title': controller.examName.text,
                            //     'data': controller.getSelectedData(),
                            //   },
                            // );
                            controller.loadQuestion();
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AuthWarningDialogue(),
                          );
                        }
                      },
                      color: const Color(0xFF1d9279),
                      sizeStyle: CupertinoButtonSize.large,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return CupertinoActivityIndicator(
                            color: Colors.white,
                          );
                        }
                        return ReusableText(
                          'পরীক্ষা শুরু করুন',
                          color: Colors.white,
                          size: 19,
                          family: 'bn',
                          weight: FontWeight.bold,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(() {
            if (controller.isLoading.value) {
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black45,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xffffffff),
                        ),
                        backgroundColor: const Color(
                          0xFFffffff,
                        ).withValues(alpha: .2),
                        strokeWidth: 6.5,
                        strokeAlign: 2.5,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Column _examInfo(
    String name,
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.number,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: ReusableText(
            name,
            family: 'bn',
            size: 20,
            weight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(fontFamily: 'bn'),
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CupertinoColors.systemGrey5,
                filled: true,
                hintText: hint,
                hintStyle: TextStyle(fontFamily: 'bn'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
