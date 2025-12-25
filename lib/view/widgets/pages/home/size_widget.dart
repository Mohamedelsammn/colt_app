import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

// ignore: must_be_immutable
class SizeWidget extends StatelessWidget {
  SizeWidget({super.key});
  var sizesList = <String>["S", "M", "L", "XL", "2XL"];
  final controller = Get.put(ShopController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 500.h(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30.s(context)),
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        "Size",
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

                  SizedBox(
                    height: 550.h(context),
                    child: ListView.builder(
                      itemCount: sizesList.length,
                      itemBuilder: (context, i) {
                        final size = sizesList[i];

                        return Obx(() {
                          final isSelected = controller.size.value == size;

                          return InkWell(
                            onTap: () {
                              controller.size.value = size;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              margin: const EdgeInsets.all(16),
                              height: 56.h(context),
                              decoration: BoxDecoration(
                                color: isSelected ? mainCal : secondaryCal,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    size,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Circular",
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  if (isSelected)
                                    Image.asset(
                                      "assets/img/done.png",
                                      height: 20.h(context),
                                      color: Colors.white,
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
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        height: 60,
        decoration: BoxDecoration(
          color: secondaryCal,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Size",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Circular",
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    controller.size.value,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Circular",
                      fontWeight: FontWeight.normal,
                    ),
                  );
                }),

                SizedBox(width: 30.s(context)),
                Image.asset("assets/img/arrowdown.png", height: 20.h(context)),
                SizedBox(width: 10.s(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
