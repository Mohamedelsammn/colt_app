import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({super.key, required this.name, required this.title});

  final String name;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8),
        height: 65.h(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: secondaryCal,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: "Circular",
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10.s(context)),
                Text(
                  title,
                  style: TextStyle(fontFamily: "Circular", fontSize: 16),
                ),
              ],
            ),
            Image.asset("assets/img/arrow_left.png", height: 20.h(context)),
          ],
        ),
      ),
    );
  }
}
