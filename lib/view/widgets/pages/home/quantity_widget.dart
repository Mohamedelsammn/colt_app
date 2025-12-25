import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class QuantityWidget extends StatelessWidget {
  QuantityWidget({super.key});

  final controller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 60.h(context),
      decoration: BoxDecoration(
        color: secondaryCal,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Quantity",
            style: TextStyle(
              fontFamily: "Gabarito",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.quantity.value++;
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: mainCal,
                  child: Image.asset(
                    "assets/img/add.png",
                    height: 25.h(context),
                  ),
                ),
              ),
              SizedBox(width: 20.s(context)),
              Obx(() {
                return Text(
                  controller.quantity.value.toString(),
                  style: const TextStyle(
                    fontFamily: "Gabarito",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
              SizedBox(width: 20.s(context)),

              InkWell(
                onTap: () {
                  if (controller.quantity.value > 1) {
                    controller.quantity.value--;
                  }
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: mainCal,
                  child: Image.asset("assets/img/minus.png", height: 25),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
