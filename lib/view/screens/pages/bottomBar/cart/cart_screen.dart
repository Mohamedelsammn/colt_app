import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/view/screens/pages/bottomBar/cart/checkout_screen.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:colt_app/view/widgets/pages/empty_widget.dart';
import 'package:colt_app/view/widgets/pages/cart/cart_prices_widget.dart';
import 'package:colt_app/view/widgets/pages/cart/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final controller = Get.find<ShopController>();

  final double shipping = 5.0;
  final double tax = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BackButtonWidget(),
        toolbarHeight: 100.h(context),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: EmptyWidget(
              img: "assets/img/order_empty.png",
              message: "Your Cart is empty",
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.clearCart();
                      },
                      child: Text(
                        "Remove All",
                        style: TextStyle(fontSize: 16, fontFamily: "Circular"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.s(context)),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.cartItems[index];
                      return CartWidget(
                        image: item.image,
                        title: item.title,
                        size: item.size,
                        color: item.color,
                        price: item.price * item.quantity,
                        add: () {
                          item.quantity++;
                          controller.cartItems.refresh();
                        },
                        minus: () {
                          if (item.quantity > 1) {
                            item.quantity--;
                            controller.cartItems.refresh();
                          } else {
                            
                            controller.cartItems.removeAt(index);
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.s(context)),
                Obx(() {
                  final subtotal = controller.cartItems.fold<double>(
                    0,
                    (sum, item) => sum + item.price * item.quantity,
                  );
                  final total = subtotal + shipping + tax;
                  return CartPricesWidget(
                    subtotal: "\$${subtotal.toStringAsFixed(2)}",
                    shipping: "\$${shipping.toStringAsFixed(2)}",
                    tax: "\$${tax.toStringAsFixed(2)}",
                    total: "\$${total.toStringAsFixed(2)}",
                  );
                }),
              ],
            ),
          );
        }
      }),

      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) {
          return SizedBox.shrink();
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: AuthButton(
              buttonText: "Checkout",
              onPressed: () {
                final subtotal = controller.cartItems.fold<double>(
                  0,
                  (sum, item) => sum + item.price * item.quantity,
                );

                final total = subtotal + shipping + tax;

                Get.to(
                  CheckoutScreen(
                    suptotal: "\$${subtotal.toStringAsFixed(2)}",
                    shipping: "\$${shipping.toStringAsFixed(2)}",
                    tax: "\$${tax.toStringAsFixed(2)}",
                    total: "\$${total.toStringAsFixed(2)}",
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
