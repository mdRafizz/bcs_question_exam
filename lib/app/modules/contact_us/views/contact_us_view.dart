import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../widgets/reusable_text.dart';
import '../../../widgets/user_info_field.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: 'Contact Us'),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: HtmlWidget(
                  '''
<body>

    <p class="justify"><strong>Get in Touch with Us</strong></p>
    <p class="justify">If you have any questions, feedback, or concerns, we’re here to help! Whether you need assistance with our app, want to report an issue, or have suggestions for improvement, feel free to reach out.</p>

    <h2 class="justify">How Can We Help?</h2>
    <ul class="justify">
        <li><strong>General Inquiries</strong> – Have questions about our app features or services? Let us know!</li>
        <li><strong>Technical Support</strong> – Facing any issues while using the app? We’re happy to assist.</li>
        <li><strong>Feedback & Suggestions</strong> – Your opinions matter! Share your thoughts to help us improve.</li>
        <li><strong>Data Deletion Requests</strong> – If you wish to delete your account or personal data, please submit a request through the form.</li>
    </ul>

    <p class="justify">We strive to respond to all inquiries as quickly as possible. Please provide accurate details to help us address your request efficiently.</p>

    <p class="justify"><strong>Fill out the form below, and we’ll get back to you soon!</strong></p>

</body>
            ''',
                  textStyle: TextStyle(fontSize: 16.5.sp),
                  customStylesBuilder: (element) {
                    if (element.classes.contains('justify')) {
                      return {
                        'text-align': 'justify',
                        'font-family': 'ferdoka bn',
                      };
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 30,
                  children: [
                    UserInfoField(
                      controller: controller.name,
                      hintText: 'Your name',
                      prefixIcon: Icons.person_rounded,
                      keyboardType: TextInputType.name,
                      iconSize: 19,
                      filledColor: CupertinoColors.systemGrey5,
                    ),
                    UserInfoField(
                      controller: controller.email,
                      hintText: 'Your email',
                      prefixIcon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      filledColor: CupertinoColors.systemGrey5,
                    ),
                    UserInfoField(
                      controller: controller.subject,
                      hintText: 'Enter the subject',
                      prefixIcon: Icons.subject_rounded,
                      keyboardType: TextInputType.text,
                      filledColor: CupertinoColors.systemGrey5,
                    ),
                    UserInfoField(
                      controller: controller.message,
                      hintText: 'Enter your message here',
                      prefixIcon: Icons.message_rounded,
                      keyboardType: TextInputType.text,
                      filledColor: CupertinoColors.systemGrey5,
                    ),
                    CupertinoButton(
                      onPressed: () {
                        controller.contactUs();
                      },
                      color: const Color(0xFF1d9279),
                      sizeStyle: CupertinoButtonSize.large,
                      child: Obx(
                        () =>
                            controller.isLoading.value
                                ? CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                                : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(10),
                                    ReusableText(
                                      'Send Mail',
                                      size: 15.5,
                                      family: 'ferdoka',
                                      color: Colors.white,
                                      weight: FontWeight.normal,
                                    ),
                                    Gap(10),
                                    Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 19,
                                    ),
                                    Gap(10),
                                  ],
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30.h),
            ]),
          ),
        ],
      ),
    );
  }
}
