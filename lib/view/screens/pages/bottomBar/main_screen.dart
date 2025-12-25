import 'package:colt_app/logic/controller/main_controller.dart';
import 'package:colt_app/view/screens/pages/bottomBar/home/home_screen.dart';
import 'package:colt_app/view/screens/pages/bottomBar/notification_screen.dart';
import 'package:colt_app/view/screens/pages/bottomBar/order_screen.dart';
import 'package:colt_app/view/screens/pages/bottomBar/settings/profile_screen.dart';
import 'package:colt_app/view/widgets/pages/navBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final BottomNavController controller = Get.find<BottomNavController>();
  final List<Widget> pages = [
    HomeScreen(),
    NotificationScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
