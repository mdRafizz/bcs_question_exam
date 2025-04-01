import 'package:bcs_preli_preparation/app/modules/auth/controllers/forget_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/reusable_text.dart';
import '../../../widgets/user_info_field.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: "Forget Password"),
          SliverList(
            delegate: SliverChildListDelegate([
              Gap(35.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Please provide the email address associated with your account. A password recovery link will be sent to this address.',
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
                  height: 350.h,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 318.h,
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
                                Align(
                                  alignment: Alignment.center,
                                  child: CupertinoButton(
                                    onPressed: () {
                                      controller.forgetPassword();
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
                                                'Send Email',
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
                            'assets/images/icon_svg/access-control.svg',
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
