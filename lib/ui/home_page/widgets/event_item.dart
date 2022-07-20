import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;
  final String name;
  final String text;
  final int id;
  final String imageUrl;

  const EventItem({
    Key? key,
    required this.onTap,
    this.isSelected = false,
    required this.name,
    required this.text,
    required this.id,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Container(
            width: 230.w,
            color: Colors.black12,
            child: const Center(child: Icon(Icons.error, color: Colors.red)),
          ),
          imageBuilder: (context, imageProvider) => Container(
            width: 230.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15.w, top: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? const Color(0xFF5785A9)
                              : Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFF5785A9),
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10),
                    child: Container(
                      height: 67.0.h,
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.15)),
                      child: Center(
                        child: Text(
                          name,
                          style:
                              Theme.of(context).textTheme.headline3?.copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap ?? () {},
          ),
        )
      ],
    );
  }
}
