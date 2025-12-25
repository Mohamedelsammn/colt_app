import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class ColorWidget extends StatelessWidget {
  ColorWidget({super.key});

  final Map<String, Color> colorList = {
    "Orange": const Color(0xFFFF9800),
    "Black": Colors.black,
    "Red": Colors.red,
    "Yellow": Colors.yellow,
    "Blue": Colors.blue,
  };

  final controller = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 500.h(context),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),

                /// HEADER
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Circular",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),

                /// COLORS LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: colorList.length,
                    itemBuilder: (context, i) {
                      final entry = colorList.entries.elementAt(i);
                      final colorName = entry.key;
                      final colorValue = entry.value;

                      return Obx(() {
                        final isSelected = controller.color.value == colorValue;

                        return InkWell(
                          onTap: () {
                            controller.color.value = colorValue;
                          },
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            height: 56,
                            decoration: BoxDecoration(
                              color: isSelected ? mainCal : secondaryCal,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  colorName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Circular",
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),

                                Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorValue,
                                        border: Border.all(
                                          color: isSelected == true
                                              ? Colors.white
                                              : colorValue,
                                          width: 5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.s(context)),
                                    if (isSelected)
                                      Image.asset(
                                        "assets/img/done.png",
                                        height: 20,
                                        color: Colors.white,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },

      /// BUTTON
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 60,
        decoration: BoxDecoration(
          color: secondaryCal,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Color",
              style: TextStyle(fontSize: 16, fontFamily: "Circular"),
            ),
            Row(
              children: [
                Obx(() {
                  return CircleAvatar(
                    radius: 10,
                    backgroundColor: controller.color.value,
                  );
                }),
                const SizedBox(width: 20),
                Image.asset("assets/img/arrowdown.png", height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
