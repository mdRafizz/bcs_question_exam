import 'package:bcs_preli_preparation/app/widgets/app_snack.dart';
import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/additional_info_controller.dart';

class AdditionalInfoView extends GetView<AdditionalInfoController> {
  const AdditionalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: Get.arguments),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: HtmlWidget(
                controller.loadHtmlContent(Get.arguments),
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
                onTapUrl: (url) async {
                  final Uri uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    AppSnack.errorSnack("Could not launch $url");
                  }
                  return true;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
