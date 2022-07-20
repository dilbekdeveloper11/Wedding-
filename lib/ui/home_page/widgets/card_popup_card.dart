import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPopupCard extends StatelessWidget {
  final VoidCallback onTap;
  final List serviceIdList;
  int? id;
  String? name;
  int? price;
  String? image;
  String? description;

  CardPopupCard({
    Key? key,
    required this.onTap,
    required this.serviceIdList,
    this.price,
    this.image,
    this.description,
    this.id,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Row(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: image ?? '',
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    height: 200.h,
                    color: Colors.black12,
                    child: const Center(
                        child: Icon(Icons.error, color: Colors.red)),
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    height: 200.h,
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
                  height: 200.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? '',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          description ?? '',
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.h),
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
    );
  }
}


















//  Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 200.h,
//                   decoration: BoxDecoration(
//                       image: const DecorationImage(
//                         image: AssetImage('assets/images/service.png'),
//                         fit: BoxFit.cover,
//                       ),
//                       borderRadius: BorderRadius.circular(5.r)),
//                 ),
//               ),
//               Expanded(
//                 child: SizedBox(
//                   height: 200.h,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.w),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Кейтеринг',
//                           style: Theme.of(context).textTheme.headline3,
//                         ),
//                         SizedBox(height: 5.h),
//                         Text(
//                           'Персонал обеспечит сервис высокого класса, эффектную подачу блюд, элегантное оформление столов.',
//                           style: Theme.of(context).textTheme.bodyText1,
//                           maxLines: 4,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'Sem nullam malesuada risus commodo sed pharetra viverra. Sit sodales ipsum lorem placerat justo.',
//                           style: Theme.of(context).textTheme.bodyText1,
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                      
//                         Text(
//                           'Price:  100 \$',
//                           style: Theme.of(context).textTheme.bodyText1,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                        
//                         Container(
//                       
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFEFF0F2),
//                             borderRadius: BorderRadius.circular(30.r),
//                           ),
//                           child: TextButton(
//                             onPressed: () {},
//                             style: ButtonStyle(
//                               shape: MaterialStateProperty.all(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30.0.r),
//                                 ),
//                               ),
//                             ),
//                             child: Text(
//                               'Выбрать',
//                               style: Theme.of(context).textTheme.button,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),