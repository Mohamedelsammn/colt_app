import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/logic/controller/main_controller.dart';
import 'package:colt_app/logic/controller/shop_controller.dart';
import 'package:colt_app/logic/controller/product_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Auth Controller
    Get.put<AuthController>(AuthController(), permanent: true);

    // Bottom Navigation Controller
    Get.put<BottomNavController>(BottomNavController(), permanent: true);
    Get.put<ProductsController>(ProductsController(), permanent: true);
    Get.put<ShopController>(ShopController(), permanent: true);
  }
}
