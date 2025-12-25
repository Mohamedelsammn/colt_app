import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/view/screens/auth/signin_confirm_screen.dart';
import 'package:colt_app/view/screens/auth/signup_screen.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:colt_app/view/widgets/auth/social_button.dart';
import 'package:colt_app/view/widgets/auth/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();
final authcontroller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 120.h(context), backgroundColor: Colors.white),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign in',
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.s(context)),
              TextfieldWidget(
                validator: (email) {
                  if (email == null || !GetUtils.isEmail(email)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
                hintText: "Email Address",
                controller: _emailController,
              ),

              SizedBox(height: 20.s(context)),

              Obx(
                () => AuthButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Get.to(
                        () => SigninConfirmScreen(
                          email: _emailController.text.trim(),
                        ),
                        transition: Transition.rightToLeft,
                      );
                    }
                  },
                  buttonText: authcontroller.isloading.value
                      ? "Loading..."
                      : "Continue",
                ),
              ),

              SizedBox(height: 20.s(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        SignupScreen(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Text(
                      "Create one",
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.s(context)),
              SocialButton(
                imagePath: "assets/img/apple.png",
                buttonText: "Continue with Apple",
                onPressed: () {},
              ),
              SizedBox(height: 20.s(context)),
              SocialButton(
                imagePath: "assets/img/google.png",
                buttonText: "Continue with Google",
                onPressed: () {},
              ),
              SizedBox(height: 20.s(context)),
              SocialButton(
                imagePath: "assets/img/facebook.png",
                buttonText: "Continue with Facebook",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
