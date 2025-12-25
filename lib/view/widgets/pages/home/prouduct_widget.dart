import 'package:cached_network_image/cached_network_image.dart';
import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/logic/controller/product_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class ProuductWidget extends StatelessWidget {
  ProuductWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
    required this.controller,
    this.ontap,
    required this.heroTag, // اضفنا الـ heroTag
  });

  final String imageUrl;
  final String title;
  final String price;
  final int productId;
  final ProductsController controller;
  final Function()? ontap;
  final String heroTag;
  final shopController = Get.put(ShopController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 281.h(context),
        width: 150.w(context),
        decoration: BoxDecoration(
          color: secondaryCal,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Hero(
                    tag: heroTag,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 200.h(context),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        memCacheWidth: 300, // تقليل الـ resolution للذاكرة
                        memCacheHeight: 300,
                        placeholder: (ctx, url) => Container(
                          height: 200.h(context),
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (ctx, url, error) => Container(
                          height: 200.h(context),
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      bool isFav = shopController.favoriteProductIds.contains(
                        productId,
                      );
                      return InkWell(
                        onTap: () => shopController.toggleFavorite(productId),
                        child: Image.asset(
                          isFav
                              ? "assets/img/fav_icon_cal.png"
                              : "assets/img/fav-icon.png",
                          height: 30.h(context),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 5.s(context)),
                    Text(
                      price,
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
