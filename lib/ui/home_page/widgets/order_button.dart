import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderButton extends StatelessWidget {
  final VoidCallback onTap;
  const OrderButton({
    Key? key, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF7E92AA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextButton(
        onPressed:onTap,      
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        child: Text(
          'Оформить',
          style: Theme.of(context).textTheme.button?.copyWith(
                fontSize: 17.sp,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}