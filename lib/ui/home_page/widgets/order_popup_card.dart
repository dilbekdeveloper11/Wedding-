import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPopupCard extends StatelessWidget {
  const OrderPopupCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:const [
                 Icon(
                  Icons.close,
                  size: 30,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Text(
              'Ваша заявка принята',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(fontSize: 17),
            ),
            SizedBox(height: 15.h),
            Text(
              'Мы вам позвоним, спасибо что пользуетесь нашими услугами.',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(fontSize: 17),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Container(
              width: 50.w,
              height: 50.h,
              decoration: const BoxDecoration(
                color: Color(0xFF5785A9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
