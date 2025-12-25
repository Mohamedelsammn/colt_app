import 'package:colt_app/logic/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CustomBottomNav extends StatelessWidget {
  CustomBottomNav({super.key});

  final BottomNavController controller = Get.find<BottomNavController>();

  final List<String> icons = [
    'assets/img/home.png',
    'assets/img/notification.png',
    'assets/img/order.png',
    'assets/img/profile.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 35.h(context),
        margin: EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            icons.length,
            (index) => GestureDetector(
              onTap: () => controller.changeIndex(index),
              child: AnimatedScale(
                scale: controller.currentIndex.value == index ? 1.2 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Image.asset(
                  icons[index],
                  height: 40.h(context),
                  width: 40.w(context),
                  color: controller.currentIndex.value == index
                      ? const Color.fromARGB(255, 94, 49, 217)
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
