import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/logic/controller/product_controller.dart';
import 'package:colt_app/view/screens/pages/bottomBar/home/prouduct_details.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:colt_app/view/widgets/pages/empty_widget.dart';
import 'package:colt_app/view/widgets/pages/home/prouduct_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final shopController = Get.find<ShopController>();
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120.h(context),
        leadingWidth: 65.w(context),
        leading: BackButtonWidget(),
        centerTitle: true,
        title: Text(
          "My Favorites (${shopController.favoriteProductIds.length})",
          style: TextStyle(
            fontFamily: "Gabarito",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Obx(() {
        if (shopController.favoriteProductIds.isEmpty) {
          return EmptyWidget(
            img: "assets/img/empty_favorite.png",
            message: "Empty Favorite List",
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 20,
                mainAxisExtent: 281,
                mainAxisSpacing: 20,
              ),
              itemCount: shopController.favoriteProductIds.length,
              itemBuilder: (context, index) {
                final productId = shopController.favoriteProductIds
                    .toList()[index];
                final product = productsController.products.firstWhere(
                  (p) => p.id == productId,
                );

                return ProuductWidget(
                  imageUrl: product.images.first,
                  title: product.title,
                  price: '\$${product.price.toStringAsFixed(2)}',
                  productId: product.id,
                  controller: productsController,
                  heroTag: 'product_${product.id}_$index',
                  ontap: () {
                    Get.to(
                      ProuductDetails(
                        productId: product.id,
                        imageUrl: product.images.first,
                        title: product.title,
                        price: product.price,
                        heroTag: 'product_${product.id}_$index',
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
