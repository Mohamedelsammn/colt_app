import 'package:colt_app/logic/controller/product_controller.dart';
import 'package:colt_app/view/screens/pages/bottomBar/home/category_details.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:colt_app/view/widgets/pages/Category/category_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final productController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 75.s(context)),
           BackButtonWidget(),
            SizedBox(height: 30.s(context)),
            Text(
              'Shop by Categories',
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: Obx(() {
                if (productController.categories.isEmpty) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemExtent: 100,
                    scrollDirection: Axis.vertical,
                    itemCount: productController.categoriesWithProducts.length,
                    itemBuilder: (context, i) {
                      final category =
                          productController.categoriesWithProducts[i];
                      return CategoryPageWidget(
                        ontap: () {
                          Get.to(
                            CategoryDetails(
                              categoryName: category.name,
                              categorySlug: category.slug,
                            ),
                            transition: Transition.rightToLeft,
                          );
                        },
                        categoryName: category.name,
                        categoryImg: category.imageUrl,
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
