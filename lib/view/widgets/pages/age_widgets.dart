import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class AgeRangeTile extends StatelessWidget {
  final String? selectedRange; // <-- النص المختار

  const AgeRangeTile({super.key, this.selectedRange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: secondaryCal,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedRange ?? 'Age Range',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
           Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 28.ic(context),
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
