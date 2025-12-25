import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/widgets/pages/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final controller = Get.find<ShopController>();

  final List<String> orderStatus = [
    "Processing",
    "Shipping",
    "Delivered",
    "Returned",
    "Cancelled",
  ];

  final RxInt selectedStatusIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 150.h(context),
        title: const Text(
          "Orders",
          style: TextStyle(
            fontFamily: "Gabarito",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return EmptyWidget(
            img: "assets/img/cart_empty.png",
            message: "No Orders yet",
          );
        }

        return Column(
          children: [
            /// ---------- FILTER ----------
            SizedBox(
              height: 30.h(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: orderStatus.length,
                itemBuilder: (context, i) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () => selectedStatusIndex.value = i,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: selectedStatusIndex.value == i
                              ? mainCal
                              : secondaryCal,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          orderStatus[i],
                          style: TextStyle(
                            fontSize: 12,
                            color: selectedStatusIndex.value == i
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20.s(context)),

            /// ---------- ORDERS LIST ----------
            Obx(
              () => Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      height: 75.h(context),
                      decoration: BoxDecoration(
                        color: secondaryCal,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/img/order_card.png",
                                height: 40,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Order #${order.id.toString().substring(0, 6)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "${order.items.length} items",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/img/arrow_left.png",
                            height: 18.h(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
