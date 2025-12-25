import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.onPressed, required this.buttonText});
  final Function()? onPressed;
  final String buttonText ;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: mainCal,
      minWidth: double.infinity.w(context),
      height: 50.h(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(
      buttonText,
        style: TextStyle(
          fontFamily: 'Circular',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
