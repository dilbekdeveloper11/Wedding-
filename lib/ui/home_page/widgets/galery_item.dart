import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GaleryItem extends StatelessWidget {
  final int? id;
  final String? name;
  final String? type;
  final String? description;
  final String? imageId;
  final String? imageUrl;

  GaleryItem({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.imageId,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        placeholder: (context, url) => Container(
              width: double.infinity,
              height: 334.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              color: Colors.black12,
              child: const Center(child: CircularProgressIndicator()),
            ),
        errorWidget: (context, url, error) => Container(
              width: double.infinity,
              height: 334.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              color: Colors.black12,
              child: const Center(child: Icon(Icons.error, color: Colors.red)),
            ),
        imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            )));
  }
}
