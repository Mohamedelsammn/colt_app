// category_widget.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    this.onTap,
    required this.categoryname,
    required this.slug,
    required this.selectedCategorySlug,
    required this.imageUrl,
  });

  final Function()? onTap;
  final String categoryname;
  final String slug;
  final RxString selectedCategorySlug;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = selectedCategorySlug.value == slug;
      return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: isSelected ? Color(0xff8E6CEF) : Colors.transparent,
                  ),
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                width: 70.w(context),
                height: 70.h(context),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 70.w(context),
                    height: 70.h(context),
                    fit: BoxFit.cover,
                    memCacheWidth: 150,
                    memCacheHeight: 150,
                    placeholder: (ctx, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (ctx, url, error) =>
                        Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.s(context)),
            Text(
              categoryname,
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }
}
