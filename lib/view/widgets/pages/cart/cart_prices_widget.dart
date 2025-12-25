import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class CartPricesWidget extends StatelessWidget {
  const CartPricesWidget({super.key, required this.subtotal, required this.shipping, required this.tax, required this.total});

  final String subtotal;
  final String shipping;
  final String tax;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subtotal",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Circular",
                color: Colors.grey,
              ),
            ),
            Text(
              subtotal,
              style: TextStyle(fontSize: 16, fontFamily: "Circular"),
            ),
          ],
        ),
        SizedBox(height: 10.s(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Shipping Cost",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Circular",
                color: Colors.grey,
              ),
            ),
            Text(
             shipping,
              style: TextStyle(fontSize: 16, fontFamily: "Circular"),
            ),
          ],
        ),
        SizedBox(height: 10.s(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tax",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Circular",
                color: Colors.grey,
              ),
            ),
            Text(
              tax,
              style: TextStyle(fontSize: 16, fontFamily: "Circular"),
            ),
          ],
        ),
        SizedBox(height: 10.s(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Circular",
                color: Colors.grey,
              ),
            ),
            Text(
              total,
              style: TextStyle(fontSize: 16, fontFamily: "Circular"),
            ),
          ],
        ),
      ],
    );
    
  }
}
