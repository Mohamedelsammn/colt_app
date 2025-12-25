import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:colt_app/view/widgets/auth/textfield_widget.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authcontroller = Get.find<AuthController>();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 75.s(context)),
                BackButtonWidget(),
                SizedBox(height: 30.s(context)),
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                SizedBox(height: 20.s(context)),
                TextfieldWidget(
                  validator: (fname) {
                    if (fname == null || fname.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                  hintText: "Firstname",
                  controller: firstNameController,
                ),
                SizedBox(height: 20.s(context)),
                TextfieldWidget(
                  validator: (lname) {
                    if (lname == null || lname.isEmpty) {
                      return "Please enter your Last name";
                    }
                    return null;
                  },
                  hintText: "Lastname",
                  controller: lastNameController,
                ),
                SizedBox(height: 20.s(context)),
                TextfieldWidget(
                  validator: (email) {
                    if (email == null || !GetUtils.isEmail(email)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  hintText: "Email Address",
                  controller: emailController,
                ),
                SizedBox(height: 20.s(context)),
                TextfieldWidget(
                  validator: (password) {
                    if (password == null || password.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  hintText: "Password",
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 50.s(context)),
                Obx(
                  () => AuthButton(
                    buttonText: authcontroller.isloading.value
                        ? "Loading..."
                        : "Sign Up",
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        authcontroller.signUp(
                          firstNameController.text.trim(),
                          lastNameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
