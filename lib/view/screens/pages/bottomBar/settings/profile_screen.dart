import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/screens/pages/bottomBar/settings/address_screen.dart';
import 'package:colt_app/view/screens/pages/bottomBar/settings/payment_screen.dart';
import 'package:colt_app/view/screens/pages/bottomBar/settings/wishlist_screen.dart';
import 'package:colt_app/view/widgets/contact_us_widget.dart';
import 'package:colt_app/view/widgets/pages/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.s(context)),

              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  radius: 40,
                  child: Image.asset(
                    "assets/img/logo.png",
                    height: 30.h(context),
                  ),
                ),
              ),

              SizedBox(height: 20.s(context)),

              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: secondaryCal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authController.fullName.isEmpty
                          ? "No Name"
                          : authController.fullName,
                      style: const TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          authController.email,
                          style: const TextStyle(
                            fontFamily: 'Circular',
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              fontFamily: 'Circular',
                              fontSize: 14,
                              color: mainCal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "+01555075289",
                      style: const TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.s(context)),
              ProfileWidget(
                title: "Address",
                onTap: () {
                  Get.to(AddressScreen());
                },
              ),
              SizedBox(height: 20.s(context)),
              ProfileWidget(
                title: "Wishlist",
                onTap: () {
                  Get.to(WishlistScreen());
                },
              ),
              SizedBox(height: 20.s(context)),
              ProfileWidget(
                title: "Payment",
                onTap: () {
                  Get.to(PaymentScreen());
                },
              ),
              SizedBox(height: 20.s(context)),
              ProfileWidget(title: "Help", onTap: () {}),
              SizedBox(height: 20.s(context)),
              ProfileWidget(
                title: "Support",
                onTap: () {
                  Get.bottomSheet(
                   ContactUsContainer()
                  );
                },
              ),

              SizedBox(height: 30.s(context)),

              Center(
                child: InkWell(
                  onTap: authController.signOut,
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
