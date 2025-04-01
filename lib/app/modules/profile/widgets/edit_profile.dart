import 'dart:ui';

import 'package:bcs_preli_preparation/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../widgets/reusable_text.dart';
import 'custom_text_field.dart';

class EditProfile extends StatelessWidget {
  final ProfileController controller;

  const EditProfile({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder:
              (context, scrollController) => Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ReusableText(
                        'Update Profile',
                        size: 17,
                        weight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 35),
                      Center(
                        child: GestureDetector(
                          onTap: controller.pickProfile,
                          child: Obx(
                                () => CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color(0xfff8f9fa),
                              backgroundImage: controller.selectedFileBytes.value != null
                                  ? MemoryImage(controller.selectedFileBytes.value!)
                                  : null,
                              child: controller.selectedFileBytes.value == null
                                  ? const Icon(Icons.add_photo_alternate_rounded, size: 50, color: Colors.grey)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        'Phone Number',
                        controller.phoneNumber,
                        keyboardType: TextInputType.phone,
                      ),
                      CustomTextField('University', controller.university),
                      CustomTextField('Address', controller.address),
                      const SizedBox(height: 20),
                      CupertinoButton(
                        onPressed: () {
                          controller.updateProfile();
                        },
                        borderRadius: BorderRadius.circular(50.r),
                        color: const Color(0xFF1d9279),
                        sizeStyle: CupertinoButtonSize.large,
                        child: Obx(
                          () =>
                              controller.isLoading.value
                                  ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                  : ReusableText(
                                    'Save Changes',
                                    color: Colors.white,
                                    size: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ],
    );
  }
}
