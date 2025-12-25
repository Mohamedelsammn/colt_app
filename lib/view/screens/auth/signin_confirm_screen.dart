import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/screens/auth/forget_password_screen.dart';

import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:colt_app/view/widgets/auth/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class SigninConfirmScreen extends StatelessWidget {
  final String email;
  SigninConfirmScreen({super.key, required this.email});

  final TextEditingController passwordController = TextEditingController();
  final authcontroller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 75.s(context)),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: secondaryCal,
                radius: 20,
                child: Image.asset(
                  "assets/img/arrow.png",
                  height: 15.s(context),
                ),
              ),
            ),
            SizedBox(height: 30.s(context)),
            Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.s(context)),
            TextfieldWidget(
              hintText: "Password",
              controller: passwordController,
              isPassword: true,
              validator: (password) {
                if (password == null || password.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 20.s(context)),
            Obx(
              () => AuthButton(
                buttonText: authcontroller.isloading.value
                    ? "Loading..."
                    : "Continue",
                onPressed: () {
                  if (passwordController.text.isNotEmpty) {
                    authcontroller.signIn(
                      email,
                      passwordController.text.trim(),
                    );
                  } else {
                    Get.snackbar("Error", "Please enter your password");
                  }
                },
              ),
            ),

            SizedBox(height: 20.s(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Forget Password? ",
                  style: TextStyle(fontFamily: 'Circular', fontSize: 12),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      ForgetPasswordScreen(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Circular',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
