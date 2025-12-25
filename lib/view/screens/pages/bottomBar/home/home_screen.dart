import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/logic/controller/product_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/screens/pages/bottomBar/home/categories_screen.dart';
import 'package:colt_app/view/screens/pages/bottomBar/home/category_details.dart';
import 'package:colt_app/view/screens/pages/bottomBar/home/prouduct_details.dart';
import 'package:colt_app/view/screens/pages/bottomBar/cart/cart_screen.dart';
import 'package:colt_app/view/widgets/pages/empty_widget.dart';
import 'package:colt_app/view/widgets/pages/Category/category_widget.dart';
import 'package:colt_app/view/widgets/pages/Category/catergory_selector.dart';
import 'package:colt_app/view/widgets/pages/home/prouduct_widget.dart';
import 'package:colt_app/view/widgets/pages/home/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as badges show Badge;
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final productsController = Get.find<ProductsController>();
  final shopController = Get.find<ShopController>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
   
        leadingWidth: 70.w(context),
        toolbarHeight: 100.h(context),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundColor: Colors.grey[400],
            radius: 30,
            child: Image.asset("assets/img/logo.png", height: 20.h(context)),
          ),
        ),
        centerTitle: true,
        title: CategoryDropdown(),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => CartScreen());
            },
            borderRadius: BorderRadius.circular(50),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Obx(() {
                final count = shopController.cartItems.length;

                return badges.Badge( 
                  offset: Offset(2, 0),
                  alignment: Alignment.topRight,
                  label: Text(
                    count.toString(),
                    style: const TextStyle(
                      fontFamily: "Circular",
                      color: Colors.white,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: mainCal,
                    radius: 25,
                    child: Image.asset("assets/img/cart.png", height: 20),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          final isSearching = productsController.searchQuery.value.isNotEmpty;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              SearchWidget(onchange: productsController.searchProducts),
              SizedBox(height: 20.s(context)),

              if (isSearching)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${productsController.filteredProducts.length.toString()} Result Found",
                    style: TextStyle(fontFamily: "Circular"),
                  ),
                ),
              if (isSearching)
                Expanded(
                  child: productsController.filteredProducts.isEmpty
                      ? Center(
                          child: EmptyWidget(
                            img: "assets/img/search_empty.png",
                            message:
                                "Sorry, we couldn't find any matching result for your Search.",
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                childAspectRatio: .6,
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: productsController.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product =
                                productsController.filteredProducts[index];
                            return ProuductWidget(
                              imageUrl: product.images.first,
                              title: product.title,
                              price: '\$${product.price.toStringAsFixed(2)}',
                              productId: product.id,
                              controller: productsController,
                              ontap: () {
                                Get.to(
                                  ProuductDetails(
                                    productId: product.id,
                                    imageUrl: product.images.first,
                                    title: product.title,
                                    price: product.price,
                                    heroTag: 'search_${product.id}_$index',
                                  ),
                                  duration: Duration(seconds: 1),
                                );
                              },
                              heroTag: 'search_${product.id}_$index',
                            );
                          },
                        ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(
                                  CategoriesScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontFamily: 'Circular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.s(context)),
                        SizedBox(
                          height: 120.s(context),
                          child: Obx(() {
                            if (productsController.isCategoriesLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productsController
                                  .categoriesWithProducts
                                  .length,
                              itemBuilder: (context, index) {
                                final category = productsController
                                    .categoriesWithProducts[index];
                                return CategoryWidget(
                                  slug: category.slug,
                                  categoryname: category.name,
                                  selectedCategorySlug:
                                      productsController.selectedCategorySlug,
                                  imageUrl: category.imageUrl,
                                  onTap: () {
                                    productsController.filterByCategory(
                                      category,
                                    );
                                  },
                                );
                              },
                            );
                          }),
                        ),

                        // Top Selling
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top Selling',
                              style: TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                final selectedCategory = productsController
                                    .categories
                                    .firstWhere(
                                      (cat) =>
                                          cat.slug ==
                                          productsController
                                              .selectedCategorySlug
                                              .value,
                                    );

                                Get.to(
                                  CategoryDetails(
                                    categoryName: selectedCategory.name,
                                    categorySlug: selectedCategory.slug,
                                  ),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontFamily: 'Circular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.s(context)),
                        SizedBox(
                          height: 281.s(context),
                          child: Obx(() {
                            if (productsController.isProductsLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              reverse: false,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  productsController.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product =
                                    productsController.filteredProducts[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: ProuductWidget(
                                    imageUrl: product.images.last,
                                    title: product.title,
                                    price:
                                        '\$${product.price.toStringAsFixed(2)}',
                                    productId: product.id,
                                    controller: productsController,
                                    ontap: () {
                                      Get.to(
                                        ProuductDetails(
                                          productId: product.id,
                                          imageUrl: product.images.first,
                                          title: product.title,
                                          price: product.price,
                                          heroTag: 'top_${product.id}_$index',
                                        ),
                                        duration: Duration(seconds: 1),
                                      );
                                    },
                                    heroTag: 'top_${product.id}_$index',
                                  ),
                                );
                              },
                            );
                          }),
                        ),

                        // New In
                        SizedBox(height: 20.s(context)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'New In',
                              style: TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 16,
                                color: mainCal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                final selectedCategory = productsController
                                    .categories
                                    .firstWhere(
                                      (cat) =>
                                          cat.slug ==
                                          productsController
                                              .selectedCategorySlug
                                              .value,
                                    );

                                Get.to(
                                  CategoryDetails(
                                    categoryName: selectedCategory.name,
                                    categorySlug: selectedCategory.slug,
                                  ),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontFamily: 'Circular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 281.s(context),
                          child: Obx(() {
                            if (productsController.isProductsLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productsController.products.length,
                              itemBuilder: (context, index) {
                                final product =
                                    productsController.products[index];

                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: ProuductWidget(
                                    imageUrl: product.images.first,
                                    title: product.title,
                                    price:
                                        '\$${product.price.toStringAsFixed(2)}',
                                    productId: product.id,
                                    controller: productsController,
                                    ontap: () {
                                      Get.to(
                                        ProuductDetails(
                                          productId: product.id,
                                          imageUrl: product.images.first,
                                          title: product.title,
                                          price: product.price,
                                          heroTag:
                                              'product_${product.id}_$index',
                                        ),
                                        duration: Duration(seconds: 1),
                                      );
                                    },
                                    heroTag: 'product_${product.id}_$index',
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
