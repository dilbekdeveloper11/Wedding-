import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GaleryGroup extends StatelessWidget {
  final String urlOne;
  final String urlTwo;
  final String urlThree;
  const GaleryGroup({
    Key? key,
    required this.urlOne,
    required this.urlTwo,
    required this.urlThree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 335.h,
            child: Image.asset(
              urlOne,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: Image.asset(
                    urlTwo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    urlThree,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
