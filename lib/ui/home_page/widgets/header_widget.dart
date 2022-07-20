import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/base.dart';
import '../../../main.dart';

class HeaderWidget extends StatelessWidget {
  final List<Base> baseList;
  const HeaderWidget({
    Key? key,
    required this.baseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: baseList.length,
      itemBuilder: (context, index) {
        final base = baseList[index];
        return CachedNetworkImage(
          imageUrl: base.image ?? '',
          placeholder: (context, url) =>
               Container(
                width: 50,
                height: 50,
                color: Colors.grey[400],
                child:const Center(child:  CircularProgressIndicator())),
          errorWidget: (context, url, error) => Container(
            width: double.infinity,
            color: Colors.black12,
            child: const Center(child: Icon(Icons.error, color: Colors.red)),
          ),
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  base.title.toString(),
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: 22.sp,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 135.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60.h,
                    child: OutlinedButton(
                      onPressed: () {
                        Scrollable.ensureVisible(
                          dataKey.currentContext!,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.white)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 18.h)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all(
                          const Color(0xFF5785A9),
                        ),
                      ),
                      child: Text(
                        'Выбрать',
                        style: Theme.of(context).textTheme.button?.copyWith(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
