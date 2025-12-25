import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    this.onPressed,
    required this.imagePath,
    required this.buttonText,
  });
  final Function()? onPressed;
  final String imagePath;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      color: const Color(0xffF4F4F4),
      minWidth: double.infinity.w(context),
      height: 50.h(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: [
          Image.asset(imagePath, height: 30),
          SizedBox(width: 80.s(context)),
          Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'Circular',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
