import 'package:colt_app/view/screens/pages/bottomBar/home/categories_screen.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.img, required this.message});

  final String img;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(img, height: 120),
        SizedBox(height: 20.s(context)),

        Text(
          textAlign: TextAlign.center,
          message,
          style: TextStyle(
            fontFamily: "Gabarito",
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 20.s(context)),
        Padding(
          padding: const EdgeInsets.only(left: 70, right: 70, bottom: 80),
          child: AuthButton(
            buttonText: "Explore Categories",
            onPressed: () {
              Get.to(CategoriesScreen());
            },
          ),
        ),
      ],
    );
  }
}
