import 'package:bcs_preli_preparation/app/modules/profile/widgets/edit_profile.dart';
import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:bcs_preli_preparation/app/widgets/app_loader.dart';
import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:bcs_preli_preparation/app/widgets/reusable_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.w, right: 3.h),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => EditProfile(controller: controller),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icon_svg/user-pen.svg',
                    height: 19.h,
                    width: 19.w,
                  ),
                ),
              ),
            ],
            title: 'Profile',
            // coloredText: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Obx(() {
                if (controller.isLoading.value) {
                  return AppLoader.defaultLoader(context);
                }
                if (controller.user.value == null) {
                  return Center(child: ReusableText('Server error!😔'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(30.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9.r)),
                        color: CupertinoColors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 21.h,
                      ),
                      child: Column(
                        spacing: 18.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.user.value!.profileImage != null)
                            Align(
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                imageUrl: controller.user.value!.profileImage!,
                                imageBuilder:
                                    (context, imageProvider) => Container(
                                      height: 120.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                        ),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                placeholder:
                                    (context, url) =>
                                        CupertinoActivityIndicator(),
                                errorWidget:
                                    (context, url, error) => Icon(Icons.error),
                              ),
                            )
                          else
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 88.h,
                                width: 88.w,
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/icon_png/user.png',
                                    ),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                          _userTextInfo('Name:', controller.user.value!.name),
                          _userTextInfo('Email:', controller.user.value!.email),
                          if (controller.user.value!.university != null)
                            _userTextInfo(
                              'University:',
                              controller.user.value!.university!,
                            ),
                          if (controller.user.value!.mobile != null)
                            _userTextInfo(
                              'Mobile:',
                              controller.user.value!.mobile!,
                            ),
                          if (controller.user.value!.address != null)
                            _userTextInfo(
                              'Address',
                              controller.user.value!.address!,
                            ),
                        ],
                      ),
                    ),
                    Gap(30.h),
                    Obx(() {
                      if (controller.isHistoryLoading.value) {
                        return Center(child: CupertinoActivityIndicator());
                      }
                      if (controller.examHistory.value == null ||
                          controller.examHistory.value!.data.isEmpty) {
                        return SizedBox.shrink();
                      }
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        padding: EdgeInsets.only(
                          left: 12.w,
                          top: 21.h,
                          bottom: 21.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9.r)),
                          color: CupertinoColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              'Exam History',
                              weight: FontWeight.w600,
                              family: 'ferdoka',
                              size: 18,
                            ),
                            Gap(15.h),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: _columns(),
                                rows: _rows(),
                                dividerThickness: .2,
                                headingRowColor: WidgetStateProperty.all(
                                  const Color(0xff128d70),
                                ),
                                dataRowColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Gap(30.h),
                    Row(
                      children: [
                        Gap(20.w),
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () {
                              controller.logout();
                            },
                            color: Colors.cyan,
                            child: Obx(() {
                              if (controller.isLoggingOut.value) {
                                return CupertinoActivityIndicator(
                                  color: Colors.white,
                                );
                              }
                              return ReusableText(
                                'Logout',
                                color: CupertinoColors.white,
                                family: 'ferdoka',
                                size: 18,
                                weight: FontWeight.w600,
                              );
                            }),
                          ),
                        ),
                        Gap(30.w),
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () {
                              Get.toNamed(Routes.DATA_DELETION);
                            },
                            color: Colors.red,
                            child: ReusableText(
                              'Delete Data',
                              color: CupertinoColors.white,
                              family: 'ferdoka',
                              size: 18,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Gap(20.w),
                      ],
                    ),
                    Gap(40.h),
                  ],
                );
              }),
            ]),
          ),
          // SliverToBoxAdapter(child: Gap(25.h),),
          // Obx((){
          //   if(controller.examHistoryList.isEmpty){
          //     return SizedBox.shrink();
          //   }
          //   return SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: DataTable(
          //       columns: _columns(),
          //       rows: _rows(),
          //       headingRowColor:
          //       WidgetStateProperty.all(
          //           Colors.blue.shade50),
          //     ),
          //   );
          // })
        ],
      ),
    );
  }

  Row _userTextInfo(String key, String value) {
    return Row(
      spacing: 12.w,
      children: [
        SizedBox(
          width: 85.w,
          child: ReusableText(
            key,
            size: 19,
            weight: FontWeight.w600,
            family: 'ferdoka',
          ),
        ),
        Expanded(child: ReusableText(value)),
      ],
    );
  }

  List<DataColumn> _columns() => [
    DataColumn(
      label: Flexible(
        child: ReusableText(
          'Exam Name',
          size: 15,
          color: CupertinoColors.white,
          weight: FontWeight.w600,
        ),
      ),
    ),
    DataColumn(
      label: Flexible(
        child: ReusableText(
          'Final Score',
          size: 15,
          color: CupertinoColors.white,
          weight: FontWeight.w600,
        ),
      ),
    ),
    // DataColumn(
    //   label: Flexible(
    //     child: ReusableText(
    //       'Negative Mark',
    //       size: 15,
    //       color: CupertinoColors.white,
    //       weight: FontWeight.w600,
    //     ),
    //   ),
    // ),
    // DataColumn(
    //   label: Flexible(
    //     child: ReusableText(
    //       'Negative Answer',
    //       size: 15,
    //       weight: FontWeight.w600,
    //     ),
    //   ),
    // ),
    DataColumn(
      label: Flexible(
        child: ReusableText(
          'Exam Date',
          color: CupertinoColors.white,
          size: 15,
          weight: FontWeight.w600,
        ),
      ),
    ),
  ];

  List<DataRow> _rows() {
    if (controller.examHistory.value == null ||
        controller.examHistory.value!.data.isEmpty) {
      return [];
    }

    return controller.examHistory.value!.data.map((exam) {
      return DataRow(
        cells: [
          DataCell(
            TextButton(
              onPressed: () {
                Get.toNamed(
                  Routes.RESULT_OVERVIEW,
                  arguments: {'response': exam.toJson()},
                );
              },
              child: ReusableText(exam.examName ?? '', size: 15),
            ),
          ),
          DataCell(ReusableText(exam.finalScore?.toString() ?? '', size: 15)),
          // DataCell(ReusableText(exam.negativeMarks?.toString() ?? '',size: 15,)),
          DataCell(
            ReusableText(
              DateFormat(
                "MMMM dd, yyyy",
              ).format(DateTime.parse(exam.startedAt.toString())),
              size: 15,
            ),
          ),
        ],
      );
    }).toList();
  }
}
