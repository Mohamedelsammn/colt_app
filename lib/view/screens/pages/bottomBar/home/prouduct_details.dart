import 'package:cached_network_image/cached_network_image.dart';
import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/logic/controller/product_controller.dart';
import 'package:colt_app/model/cart_model.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:colt_app/view/widgets/pages/home/color_widget.dart';
import 'package:colt_app/view/widgets/pages/home/quantity_widget.dart';
import 'package:colt_app/view/widgets/pages/home/size_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

// ignore: must_be_immutable
class ProuductDetails extends StatelessWidget {
  final int productId;
  final String imageUrl;
  final String title;
  final double price;
  final String heroTag;

  ProuductDetails({
    super.key,
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.heroTag,
  });

  final controller = Get.find<ProductsController>();
  final shopcontroller = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        toolbarHeight: 150,
        leading: BackButtonWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30, top: 20),
            child: Obx(() {
              bool isFav = shopcontroller.favoriteProductIds.contains(
                productId,
              );
              return InkWell(
                onTap: () => shopcontroller.toggleFavorite(productId),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 190,
                child: Obx(() {
                  if (controller.products.isEmpty) {
                    return CircularProgressIndicator();
                  } else {
                    final product = controller.products.firstWhere(
                      (p) => p.id == productId,
                    );
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10, top: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: secondaryCal,
                          ),
                          child: index == 0
                              ? Hero(
                                  tag: heroTag,
                                  child: CachedNetworkImage(
                                    imageUrl: product.images[index],
                                    fit: BoxFit.cover,
                                    height: 190.h(context),
                                    width: 200.w(context),
                                    memCacheWidth: 300,
                                    memCacheHeight: 300,
                                    placeholder: (ctx, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (ctx, url, error) =>
                                        Icon(Icons.image_not_supported),
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: product.images[index],
                                  fit: BoxFit.cover,
                                  memCacheWidth: 300,
                                  memCacheHeight: 300,
                                  placeholder: (ctx, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (ctx, url, error) =>
                                      Icon(Icons.image_not_supported),
                                ),
                        );
                      },
                    );
                  }
                }),
              ),
              SizedBox(height: 20.s(context)),
              Text(
                "Men's Harrington Jacket",
                style: TextStyle(
                  fontFamily: "Gabarito",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20.s(context)),
              Text(
                "\$$price",
                style: TextStyle(
                  fontFamily: "Gabarito",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: mainCal,
                ),
              ),
              SizedBox(height: 30.s(context)),
              SizeWidget(),
              SizedBox(height: 15.s(context)),
              ColorWidget(),
              SizedBox(height: 15.s(context)),
              QuantityWidget(),
              SizedBox(height: 30.s(context)),
              Text(
                "Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you plenty of room to layer underneath, while the soft corduroy keeps it casual and timeless.",
                style: TextStyle(
                  fontFamily: "Gabarito",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
        child: Obx(
          () => MaterialButton(
            height: 56,
            color: mainCal,
            onPressed: () {
              final item = CartItem(
                image: imageUrl,
                productId: productId,
                title: title,
                price: price,
                color:
                    '#${shopcontroller.color.value.value.toRadixString(16).substring(2)}',
                size: shopcontroller.size.value,
                quantity: shopcontroller.quantity.value,
              );

              shopcontroller.addToCart(item);
              Get.back();

              Get.snackbar(
                "Added to cart",
                "$title added to your cart",
                snackPosition: SnackPosition.TOP,
              );
            },

            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${shopcontroller.quantity * price}",
                  style: TextStyle(
                    fontFamily: "Gabarito",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Add to Bag",
                  style: TextStyle(
                    fontFamily: "Gabarito",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
