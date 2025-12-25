import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:colt_app/view/widgets/auth/textfield_widget.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final authController = Get.find<AuthController>();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 75.s(context)),
              BackButtonWidget(),

              SizedBox(height: 30.s(context)),
              Text(
                'Forget Password',
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20.s(context)),
              TextfieldWidget(
                validator: (email) {
                  if (GetUtils.isEmail(email!)) {
                    return null;
                  } else {
                    return "Please enter a valid email address";
                  }
                },
                hintText: "Enter Email Address",
                controller: emailController,
              ),

              SizedBox(height: 20.s(context)),
              AuthButton(
                buttonText: "Continue",
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    authController.resetPassword(emailController.text.trim());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
