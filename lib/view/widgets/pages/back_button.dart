import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: secondaryCal,
              radius: 20,
              child: Image.asset("assets/img/arrow.png", height: 15.s(context)),
            ),
          ),
        );
  }
}