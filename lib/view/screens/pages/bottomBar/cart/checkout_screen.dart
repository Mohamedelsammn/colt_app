import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/view/screens/pages/bottomBar/settings/address_screen_add.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:colt_app/view/widgets/pages/address_widget.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:colt_app/view/widgets/pages/cart/cart_prices_widget.dart';
import 'package:colt_app/view/widgets/pages/cart/checkout_widget.dart';
import 'package:colt_app/view/widgets/pages/payment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({
    super.key,
    required this.suptotal,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  final String suptotal;
  final String shipping;
  final String tax;
  final String total;

  final controller = Get.find<ShopController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        leading: BackButtonWidget(),
        title: Text(
          "Checkout",
          style: TextStyle(
            fontFamily: "Circular",
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Obx(() {
                  if (authController.addresses.isEmpty) {
                    return CheckoutWidget(
                      name: "Shipping Address",
                      title: "Add Shipping Address",
                    );
                  } else {
                    final address = authController.addresses.first;
                    return AddressWidget(
                      addressName:
                          "${address['street']}, ${address['city']}, ${address['state']}",
                      addressFunction: () {
                        // فتح شاشة تعديل العنوان
                        Get.to(
                          () => AddressScreenAdd(
                            addressId: address['id'],
                            initialStreet: address['street'],
                            initialCity: address['city'],
                            initialState: address['state'],
                          ),
                        );
                      },
                    );
                  }
                }),

                SizedBox(height: 20.s(context)),

                Obx(() {
                  if (authController.cards.isEmpty) {
                    return CheckoutWidget(
                      name: "Payment Method",
                      title: "Add Payment Method",
                    );
                  } else {
                    final card = authController.cards.first;
                    return PaymentCardWidget(cardNum: "**** ${card.last4}");
                  }
                }),
              ],
            ),

            CartPricesWidget(
              subtotal: suptotal,
              shipping: shipping,
              tax: tax,
              total: total,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 30,
          top: 50,
        ),
        child: AuthButton(
          buttonText: "Checkout",
          onPressed: () {
            controller.createOrderFromCart();
          },
        ),
      ),
    );
  }
}
