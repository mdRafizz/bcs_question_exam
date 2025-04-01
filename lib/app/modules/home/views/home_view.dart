import 'dart:ui';

import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:bcs_preli_preparation/app/widgets/app_loader.dart';
import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:bcs_preli_preparation/app/widgets/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/drawer_content.dart';
import '../widgets/exit_dialogue.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<dynamic>> featureShortcut = {
      'Written question bank': ['wqb', Color(0xff3e8af1), Routes.COMMING_SOON, ''],
      'Subject wise quick exam': [
        'swqe',
        Color(0xfff48da0),
        Routes.EXAM_CUSTOMIZATION,
        'subjectWiseExam',
      ],
      'Monthly current affairs': [
        'mca',
        Color(0xffb071fc),
        Routes.COMMING_SOON,
        '',
      ],
    };

    final Map<String, List<dynamic>> additionalInfoShortcut = {
      'About BCS': ['about', Color(0xff3e8af1), Routes.ADDITIONAL_INFO, 'About BCS'],
      // 'Notice & Circular': ['notice', Color(0xfff48da0), Routes.COMMING_SOON, ''],
    };

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        showDialog(
          context: context,
          builder: (_) {
            return const ExitDialog();
          },
        );
      },
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: const Color(0xfff8f9fa),
        drawer: Drawer(
          backgroundColor: CupertinoColors.white,
          child: const DrawerContent(),
        ),
        body: Stack(
          children: [
            // Positioned(
            //   bottom: 50.h,
            //   left: 0,
            //   right: 0,
            //   child: Image.asset('assets/images/bg/art2.png',height: 650.h,fit: BoxFit.fitHeight,),
            // ),
            // Positioned.fill(
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            //     child: Container(
            //       color: const Color(0xfff8f9fa).withValues(
            //         alpha: .7,
            //       ),
            //     ),
            //   ),
            // ),
            CustomScrollView(
              slivers: [
                CustomAppBar(
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.w, right: 3.h),
                      child: IconButton(
                        onPressed: () {
                          if (controller.box.hasData('token')) {
                            Get.toNamed(Routes.PROFILE);
                          } else {
                            Get.toNamed(Routes.LOGIN);
                          }
                        },
                        icon: SvgPicture.asset(
                          controller.box.hasData('token')
                              ? 'assets/images/icon_svg/profile.svg'
                              : 'assets/images/icon_svg/login.svg',
                          height: 19.h,
                          width: 19.w,
                        ),
                      ),
                    ),
                  ],
                  title: 'Dashboard',
                  coloredText: true,
                ),
                // CupertinoSliverNavigationBar(
                //   leading: Icon(Icons.menu_rounded),
                //   largeTitle: Text('Dashboard'),
                //   trailing: SizedBox(),
                //   stretch: true,
                // ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Gap(20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        height: 190.h,
                        child: Row(
                          spacing: 20.w,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.BCS_YEARS,
                                    arguments: {'feature': 'questionBank'},
                                  );
                                },
                                child: _boxShortcutButton(
                                  Color(0xff3e8af1),
                                  'pqb',
                                  'BCS Preli Question Bank',
                                  21,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                spacing: 8.h,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.BCS_YEARS,
                                          arguments: {'feature': 'modelTest'},
                                        );
                                      },
                                      child: _boxShortcutButton(
                                        Color(0xfff48da0),
                                        'qmt',
                                        'Preli Model Test',
                                        15,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.EXAM_CUSTOMIZATION,arguments: 'customizedExam');
                                      },
                                      child: _boxShortcutButton(
                                        Color(0xffb071fc),
                                        'cme',
                                        'Customized Exam',
                                        15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(35.h),
                    Gap(35.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ReusableText(
                        'Shortcut',
                        color: Colors.black87,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Gap(20.h),
                    ...featureShortcut.entries.map(
                      (entry) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(entry.value[2],arguments: entry.value[3]);
                              },
                              child: _listShortcutButton(
                                entry.value[1],
                                entry.value[0],
                                entry.key,
                              ),
                            ),
                            Gap(20.h),
                          ],
                        ),
                      ),
                    ),
                    Gap(35.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ReusableText(
                        'Additional Info',
                        color: Colors.black87,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Gap(20.h),
                    ...additionalInfoShortcut.entries.map(
                      (entry) => GestureDetector(
                        onTap: () {
                          Get.toNamed(entry.value[2],arguments: entry.value[3]);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              _listShortcutButton(
                                entry.value[1],
                                entry.value[0],
                                entry.key,
                              ),
                              Gap(20.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Obx(() {
              if (controller.isLoading.value) {
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
              }
              else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }

  Container _boxShortcutButton(
    Color color,
    String imgName,
    String btnTitle,
    double fontSize,
  ) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16.sp)),
      color: color,
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black38,
              child: SvgPicture.asset(
                'assets/images/icon_svg/$imgName.svg',
                height: 18.h,
                width: 18.h,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            SvgPicture.asset(
              'assets/images/icon_svg/forward.svg',
              height: 19.h,
              width: 19.h,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ReusableText(
              btnTitle,
              color: Colors.white,
              weight: FontWeight.w600,
              size: fontSize,
            ),
          ),
        ),
      ],
    ),
  );

  Container _listShortcutButton(Color color, String imgName, String btnTitle) =>
      Container(
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
                'assets/images/icon_svg/$imgName.svg',
                height: 18.h,
                width: 18.h,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            ReusableText(
              btnTitle,
              weight: FontWeight.normal,
              size: 15,
              color: Colors.black,
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
      );
}
