import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../widgets/auth_warning_dialogue.dart';
import '../controllers/data_deletion_controller.dart';

class DataDeletionView extends GetView<DataDeletionController> {
  const DataDeletionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: 'Data Deletion'),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: HtmlWidget(
                  '''
<body>
    <p class="justify"><strong>Only logged-in users can request to delete their account and all associated data.</strong></p>

    <h2 class="justify">Things to Know Before Requesting Data Deletion</h2>
    <ul class="justify">
        <li><strong>Complete Data Removal:</strong> Your account and all associated data will be permanently deleted. This action <strong>cannot be undone</strong>.</li>
        <li><strong>Processing Time:</strong> Data deletion requests are processed within <strong>7 business days</strong>. Once processed, your data will be permanently removed from our system.</li>
        <li><strong>Login Required:</strong> You must be logged in to submit a deletion request. </li>
        <li><strong>Alternative Options:</strong> If you want to keep your account but remove specific data, you can manually delete your content from your profile.</li>
    </ul>

    <p class="justify"><strong>If you understand and agree to the above terms, please fill out the form below to request data deletion.</strong></p>

</body>
            ''',
                  textStyle: TextStyle(fontSize: 16.5.sp),
                  customStylesBuilder: (element) {
                    if (element.classes.contains('justify')) {
                      return {
                        'text-align': 'justify',
                        'font-family': 'ferdoka',
                      };
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  spacing: 19.w,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        child: TextField(
                          minLines: 1,
                          maxLines: 5,
                          controller: controller.reason,
                          style: TextStyle(fontFamily: 'bn'),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: CupertinoColors.systemGrey5,
                            hintStyle: TextStyle(fontFamily: 'bn'),
                            hintText: 'Why you want to delete the account?',
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.box.hasData('token')) {
                          controller.deleteAccount();
                        } else {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AuthWarningDialogue(
                                  title:
                                      'ডেটা মুছে ফেলার জন্য, অনুগ্রহ করে প্রথমে আপনার অ্যাকাউন্টে লগ ইন করুন।',
                                ),
                          );
                        }
                      },
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return CupertinoActivityIndicator();
                        }
                        return Icon(
                          Icons.send_rounded,
                          color: const Color(0xFF1d9279),
                          size: 24.sp,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Gap(20.h),
            ]),
          ),
        ],
      ),
    );
  }
}
