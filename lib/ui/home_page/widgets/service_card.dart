import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_popup_card.dart';

class ServiceCard extends StatelessWidget {
  final VoidCallback onTap;
  final List serviceIdList;
  int? id;
  String? name;
  String? type;
  int? price;
  String? image;
  String? description;
  ServiceCard({
    Key? key,
    this.id,
    this.name,
    this.type,
    this.price,
    this.image,
    this.description,
    required this.onTap,
    required this.serviceIdList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: GestureDetector(
        onTap: () {
          _showDialog(context, onTap, id, serviceIdList, name, price, image,
              description);
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Row(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: image ?? '',
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      height: 146.h,
                      color: Colors.black12,
                      child: const Center(
                          child: Icon(Icons.error, color: Colors.red)),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 146.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(4.r)),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 146.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name ?? '',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            description ?? '',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Price:  $price \$',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 86.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: !serviceIdList.contains(id)
                                  ? const Color(0xFFEFF0F2)
                                  : const Color(0xFF5785A9),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: TextButton(
                              onPressed: onTap,
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0.r),
                                  ),
                                ),
                              ),
                              child: Text(
                                serviceIdList.contains(id)
                                    ? 'Выбрано'
                                    : 'Выбрать',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                        color: !serviceIdList.contains(id)
                                            ? Colors.grey
                                            : Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_showDialog(
    BuildContext context,
    VoidCallback onTap,
    int? id,
    List? serviceIdList,
    String? name,
    int? price,
    String? image,
    String? description) {
  return showDialog(
    context: context,
    builder: (context) {
      return CardPopupCard(
        onTap: onTap,
        serviceIdList: serviceIdList ?? [],
        description: description,
        id: id,
        price: price,
        name: name,
        image: image,
      );
    },
  );
}
