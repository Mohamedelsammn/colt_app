import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/screens/pages/bottomBar/main_screen.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class OrderPacedScreen extends StatelessWidget {
  const OrderPacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainCal,

      body: Center(
        child: Image.asset("assets/img/orderplaced.png", height: 250),
      ),
      bottomNavigationBar: Container(
        height: 390.h(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Order Placed\n Successfully",
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontFamily: "Gabarito",
                fontWeight: FontWeight.w900,
              ),
            ),

            SizedBox(height: 20.s(context)),

            Text(
              "You will recieve an email confirmation",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: "Gabarito",
                fontWeight: FontWeight.w900,
              ),
            ),

            SizedBox(height: 70.s(context)),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: AuthButton(
                buttonText: "See Order details",
                onPressed: () {
                  Get.offAll(MainScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
