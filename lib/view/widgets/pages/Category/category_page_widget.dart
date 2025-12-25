import 'package:cached_network_image/cached_network_image.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CategoryPageWidget extends StatelessWidget {
  const CategoryPageWidget({
    super.key,
    required this.categoryName,
    required this.categoryImg,
    this.ontap,
  });
  final String categoryName;
  final String categoryImg;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.white,
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(16),
        height: 67.h(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: secondaryCal,
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: categoryImg,
              height: 70.h(context),
              width: 70.w(context),
              fit: BoxFit.cover,
              memCacheWidth: 200, 
              memCacheHeight: 200,
              placeholder: (ctx, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (ctx, url, error) => Icon(Icons.image_not_supported),
            ),
            SizedBox(width: 20.s(context)),
            Text(
              categoryName,
              style: TextStyle(fontSize: 16, fontFamily: "Circular"),
            ),
          ],
        ),
      ),
    );
  }
}
