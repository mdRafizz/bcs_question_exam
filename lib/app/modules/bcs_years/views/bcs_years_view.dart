import 'dart:ui';

import 'package:bcs_preli_preparation/app/widgets/auth_warning_dialogue.dart';
import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/app_loader.dart';
import '../../../widgets/reusable_text.dart';
import '../controllers/bcs_years_controller.dart';

class BcsYearsView extends GetView<BcsYearsController> {
  const BcsYearsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CustomAppBar(title: 'Preli Questions'),

              SliverToBoxAdapter(child: Gap(30.h)),

              Obx(() {
                if (controller.isLoading.value) {
                  return SliverToBoxAdapter(
                    child: Center(child: AppLoader.defaultLoader(context)),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    return GestureDetector(
                      onTap: () {
                        if (Get.arguments['feature'] == 'questionBank') {
                          Get.toNamed(
                            Routes.PRACTICE_QUESTION,
                            arguments: {
                              'title': controller.categories[i].name
                                  .toString()
                                  .replaceAll('Preliminary', ''),
                              'categoryId':
                                  controller.categories[i].id.toString(),
                            },
                          );
                        } else {
                          if (controller.box.hasData('token')) {
                            // Get.toNamed(
                            //   Routes.EXAM_ROOM,
                            //   arguments: {
                            //     'title':
                            //         controller.categories[i].name.toString(),
                            //     'categoryId': controller.categories[i].id,
                            //   },
                            // );
                            controller.loadQuestion(
                              controller.categories[i].id!,
                              controller.categories[i].name.toString(),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AuthWarningDialogue(),
                            );
                          }
                        }
                      },
                      child: _bcsYearsButton(
                        controller.colors[i],
                        controller.categories[i].name.toString(),
                        controller.categories[i].examType.toString(),
                        controller.categories[i].examDate != null
                            ? formatDate(controller.categories[i].examDate!)
                            : null,
                      ),
                    );
                  }, childCount: controller.categories.length),
                );
              }),
            ],
          ),
          Obx(() {
            if (controller.isQLoading.value) {
              return BackdropFilter(
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
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Padding _bcsYearsButton(
    Color color,
    String title,
    String type,
    String? date,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
        child: Row(
          spacing: 15.w,
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: SvgPicture.asset(
                'assets/images/icon_svg/hastag.svg',
                height: 13.h,
                width: 13.h,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  title,
                  weight: FontWeight.w600,
                  size: 16,
                  color: Colors.black,
                ),
                Gap(9.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 10.w,
                  children: [
                    ReusableText(type, weight: FontWeight.normal, size: 13.5),
                    if (date != null)
                      ReusableText('|', weight: FontWeight.bold, size: 17),
                    if (date != null)
                      ReusableText(date, color: Colors.black, size: 13.5),
                  ],
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/images/icon_svg/forward.svg',
              height: 19.h,
              width: 19.h,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String examDate) {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(examDate);

    String formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    return formattedDate;
  }
}
