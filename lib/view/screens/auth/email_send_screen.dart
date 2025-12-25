import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/screens/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class EmailSendScreen extends StatelessWidget {
  const EmailSendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("assets/img/forget_password.png", height: 120.h(context)),
            ),

            SizedBox(height: 20.s(context),),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                'We Sent you an Email to reset your password.',
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20.s(context)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainCal,
                minimumSize: Size(159, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Get.offAll(SigninScreen(), transition: Transition.fadeIn);
              },
              child: Text(
                "Return to Login",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Circular',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
