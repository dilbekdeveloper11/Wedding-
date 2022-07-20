import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'social_button.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 216.h,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      color: const Color(0xFFF2F2F2),
      child: Column(
        children: [
          Image.asset('assets/images/logo.png'),
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SocialButton(
                    url: 'assets/images/instagram.png'),
                SizedBox(width: 25.w),
                const SocialButton(url: 'assets/images/telegram.png'),
                SizedBox(width: 25.w),
                const SocialButton(url: 'assets/images/facebook.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}