import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/screens/pages/bottomBar/settings/payment_screen_add.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:colt_app/view/widgets/pages/empty_widget.dart';
import 'package:colt_app/view/widgets/pages/payment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120.h(context),
        leadingWidth: 65.w(context),
        leading: BackButtonWidget(),
        centerTitle: true,
        title: const Text(
          "Payment",
          style: TextStyle(
            fontFamily: "Gabarito",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Cards",
              style: TextStyle(
                fontFamily: "Gabarito",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.cards.isEmpty) {
                return const EmptyWidget(
                  img: "assets/img/order_empty.png",
                  message: "No cards available",
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.cards.length,
                itemBuilder: (context, index) {
                  final card = controller.cards[index];

                  return PaymentCardWidget(cardNum: "**** ${card.last4}");
                },
              );
            }),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.to(PaymentScreenAdd());
        },
        backgroundColor: mainCal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
