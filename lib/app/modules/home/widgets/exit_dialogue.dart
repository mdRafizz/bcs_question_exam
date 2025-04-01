import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/reusable_text.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20),),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 41.h,
            bottom: 12.0,
            left: 14.w,
            right: 14.w,
          ),
          margin: EdgeInsets.only(top: 36.h),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20),),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ReusableText(
                'Exit App',
                size: 25.0,
                family: 'ferdoka',
                weight: FontWeight.bold,
              ),
              SizedBox(height: 10.h),
              const ReusableText(
                'Are you sure you want to exit the app?',
                size: 17.5,
                textAlign: TextAlign.center,
                family: 'ferdoka',
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 5,),
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const ReusableText(
                      'Yes',
                      color: Colors.red,
                      family: 'ferdoka',
                      size: 16.6,
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const ReusableText(
                      'No',
                      color: Colors.blue,
                      family: 'ferdoka',
                      size: 16.6,
                    ),
                  ),
                  const Spacer(flex: 1,),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 35.h,
            child: Icon(
              Icons.warning_rounded,
              color: Colors.white,
              size: 29.sp,
            ),
          ),
        ),
      ],
    );
  }
}
