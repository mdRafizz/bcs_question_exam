import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../widgets/reusable_text.dart';
import '../controllers/home_controller.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    final List<List<String>> menuItems;
    final baseMenuItems = [
      ['About Us', 'assets/images/icon_svg/info.svg'],
      ['Contact Us', 'assets/images/icon_svg/at.svg'],
      ['Data Deletion', 'assets/images/icon_svg/delete-document.svg'],
      ['Disclaimer', 'assets/images/icon_svg/warning.svg'],
      ['Privacy Policy', 'assets/images/icon_svg/shield.svg'],
    ];

    if (homeController.box.hasData('token')) {
      menuItems = [
        ['Profile', 'assets/images/icon_svg/profile.svg'],
        ['Logout', 'assets/images/icon_svg/sign-out-alt.svg'],
        ...baseMenuItems,
      ];
    } else {
      menuItems = [
        ['Login', 'assets/images/icon_svg/login.svg'],
        ['Register', 'assets/images/icon_svg/sign-up.svg'],
        ...baseMenuItems,
      ];
    }

    return Column(
      children: [
        Container(
          height: 180.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: const Color(0xFF1d9279),
            image: DecorationImage(
              image: AssetImage('assets/images/bg/img.png'),
              opacity: .14,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              ReusableText(
                'BCS Prelim Prep',
                weight: FontWeight.bold,
                color: Colors.white,
                size: 28,
                family: 'ferdoka',
              ),
              ReusableText(
                'Version 0.1.0',
                color: Colors.white38,
                size: 17,
                family: 'bn',
              ),
            ],
          ),
        ),
        Gap(30.h),
        ...List.generate(
          menuItems.length,
          (i) => GestureDetector(
            onTap: () {
              Get.back();
              _drawerActions(context, menuItems[i][0], homeController);
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Gap(25.w),
                    SvgPicture.asset(
                      menuItems[i][1],
                      height: 18.h,
                      width: 18.w,
                    ),
                    Gap(15.w),
                    ReusableText(menuItems[i][0], size: 19, family: 'ferdoka',weight: FontWeight.w600,),
                  ],
                ),
                Gap(37.h),
                if (i == 1) ...[
                  Divider(color: CupertinoColors.systemGrey3, height: 1.h),
                  Gap(30.h),
                ],
                // if (i == 2 && homeController.box.hasData('token')) ...[
                //   Divider(color: CupertinoColors.systemGrey3, height: 1.h),
                //   Gap(30.h),
                // ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _drawerActions(
    BuildContext context,
    String title,
    HomeController controller,
  )
  {
    switch (title) {
      case 'Profile':
        Get.toNamed(Routes.PROFILE);
        break;
      case 'Data Deletion':
        Get.toNamed(Routes.DATA_DELETION);
        break;
      case 'Logout':
        controller.logout();
        break;
      case 'Login':
        Get.toNamed(Routes.LOGIN);
        break;
      case 'Register':
        Get.toNamed(Routes.REGISTER);
        break;
      case 'About Us':
        Get.toNamed(Routes.ADDITIONAL_INFO, arguments: 'About Us');
        break;
      case 'Contact Us':
        Get.toNamed(Routes.CONTACT_US);
        break;
      case 'Disclaimer':
        Get.toNamed(Routes.ADDITIONAL_INFO, arguments: 'Disclaimer');
        break;
      default:
        Get.toNamed(Routes.ADDITIONAL_INFO, arguments: 'Privacy Policy');
    }
  }
}
