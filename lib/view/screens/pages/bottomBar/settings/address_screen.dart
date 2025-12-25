import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/screens/pages/bottomBar/settings/address_screen_add.dart';
import 'package:colt_app/view/widgets/pages/address_widget.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:colt_app/view/widgets/pages/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});

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
          "Address",
          style: TextStyle(
            fontFamily: "Gabarito",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoadingAddress.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.addresses.isEmpty) {
          return const EmptyWidget(
            img: "assets/img/order_empty.png",
            message: "The address is empty",
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.addresses.length,
          itemBuilder: (context, index) {
            final address = controller.addresses[index];

            return AddressWidget(
              addressName:
                  "${address['street']}, ${address['city']}, ${address['state']}"
                      .capitalize!,
              addressFunction: () {
                final addr = controller.addresses[index];
                Get.to(
                  () => AddressScreenAdd(
                    addressId: addr['id'],
                    initialStreet: addr['street'],
                    initialCity: addr['city'],
                    initialState: addr['state'],
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.to(() => AddressScreenAdd(), transition: Transition.rightToLeft);
        },
        backgroundColor: mainCal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
