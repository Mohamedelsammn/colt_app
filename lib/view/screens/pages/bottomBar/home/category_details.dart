import 'package:colt_app/logic/controller/product_controller.dart';
import 'package:colt_app/view/screens/pages/bottomBar/home/prouduct_details.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:colt_app/view/widgets/pages/home/prouduct_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CategoryDetails extends StatelessWidget {
  final String categorySlug;
  final String categoryName;

  const CategoryDetails({
    super.key,
    required this.categorySlug,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductsController>();

    // فلترة المنتجات حسب categorySlug
    final categoryProducts = productController.products
        .where((p) => p.category == categorySlug)
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 75.s(context)),
            BackButtonWidget(),
            SizedBox(height: 30.s(context)),
            Text(
              '$categoryName (${categoryProducts.length})',
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 281,
                  mainAxisSpacing: 20,
                ),
                itemCount: categoryProducts.length,
                itemBuilder: (context, index) {
                  final product = categoryProducts[index];
                  return ProuductWidget(
                    imageUrl: product.images.first,
                    title: product.title,
                    price: '\$${product.price.toStringAsFixed(2)}',
                    productId: product.id,
                    controller: productController,
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
            ),
          ],
        ),
      ),
    );
  }
}
