import 'package:bcs_preli_preparation/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/comming_soon_controller.dart';

class CommingSoonView extends GetView<CommingSoonController> {
  const CommingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: 'Coming Soon'),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(25.w),
              child: Center(
                child: Text(
                  'This feature will be available soon!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontFamily: 'ferdoka',
                    fontWeight: FontWeight.w600,
                    foreground:
                        Paint()
                          ..shader = LinearGradient(
                            colors: const <Color>[
                              Color(0xff3e8af1),
                              Color(0xfff48da0),
                              Color(0xffb071fc),
                            ],
                          ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
