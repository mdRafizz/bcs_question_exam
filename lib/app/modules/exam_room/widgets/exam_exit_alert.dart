import 'dart:ui';

import 'package:bcs_preli_preparation/app/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ExamExitAlert extends StatelessWidget {
  const ExamExitAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: const Color(0xffe9d502),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(15.h),
            SvgPicture.asset(
              'assets/images/icon_svg/warning.svg',
              height: 22.h,
            ),
            Gap(15.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              alignment: Alignment.center,
              child: Column(
                spacing: 18.h,
                children: [

                  ReusableText(
                    'আপনি কি পরিক্ষা বাতিল করতে চান?',
                    color: Colors.black,
                    family: 'bn',
                    weight: FontWeight.w600,
                    size: 18,
                  ),
                  Row(
                    spacing: 20.w,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: ReusableText(
                          'না',
                          family: 'bn',
                          weight: FontWeight.w600,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: ReusableText(
                          'হ্যা',
                          family: 'bn',
                          weight: FontWeight.w600,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
