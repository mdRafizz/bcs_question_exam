import 'package:bcs_preli_preparation/app/modules/auth/controllers/login_controller.dart';
import 'package:bcs_preli_preparation/app/widgets/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/user_info_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                    Get.toNamed(Routes.REGISTER);
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icon_svg/sign-up.svg',
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
            ],
            title: "Login",
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Gap(35.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Continue your practice with our extensive question bank.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'ferdoka',
                    foreground:
                        Paint()
                          ..shader = LinearGradient(
                            colors: const <Color>[
                              Color(0xff17B169),
                              Color(0xff1CAC78),
                              Color(0xff00693E),
                            ],
                          ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(19.h),
              Padding(
                padding: EdgeInsets.only(right: 20.w, left: 10.w),
                child: SizedBox(
                  height: 482.h,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 450.h,
                          width: MediaQuery.sizeOf(context).width,
                          margin: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(4, 4),
                                color: Colors.grey.shade300,
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                offset: Offset(-4, -4),
                                color: const Color(0xfff8f9fa),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade200,
                                Colors.grey.shade300,
                                Colors.grey.shade400,
                                // Colors.grey.shade500,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(25.h),
                                UserInfoField(
                                  title: 'Email',
                                  controller: controller.email,
                                  hintText: 'Your email',
                                  prefixIcon: Icons.email_rounded,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                Gap(35.h),
                                Obx(() {
                                  return UserInfoField(
                                    obscureText: controller.obscureText.value,
                                    maxLines: 1,
                                    title: 'Password',
                                    controller: controller.password,
                                    hintText: 'Your password',
                                    prefixIcon: Icons.lock_rounded,
                                    keyboardType: TextInputType.visiblePassword,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.obscureText.value =
                                            !controller.obscureText.value;
                                      },
                                      child: Icon(
                                        controller.obscureText.value
                                            ? Icons.visibility_rounded
                                            : Icons.visibility_off_rounded,
                                        size: 17,
                                      ),
                                    ),
                                  );
                                }),
                                Gap(15.h),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.FORGET_PASSWORD);
                                    },
                                    child: ReusableText(
                                      'Forget Password?',
                                      size: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Gap(20.h),
                                // Gap(50.h),
                                Align(
                                  alignment: Alignment.center,
                                  child: CupertinoButton(
                                    onPressed: () {
                                      controller.logIn();
                                    },
                                    sizeStyle: CupertinoButtonSize.large,
                                    color: const Color(0xFF1d9279),
                                    child: Obx(
                                      () =>
                                          controller.isLoading.value
                                              ? const CupertinoActivityIndicator(
                                                color: Colors.white,
                                              )
                                              : const ReusableText(
                                                'Login',
                                                size: 15.5,
                                                family: 'ferdoka',
                                                color: Colors.white,
                                                weight: FontWeight.normal,
                                              ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Color(0xff1f4037), Color(0xff99f2c8)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcIn,
                          child: SvgPicture.asset(
                            'assets/images/icon_svg/password-email.svg',
                            width: 67.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
