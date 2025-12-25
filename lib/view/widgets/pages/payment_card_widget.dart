import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({super.key, required this.cardNum});
  final String cardNum ;

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 70.h(context),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                             cardNum,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Circular",
                              ),
                            ),
                            SizedBox(width: 10.s(context)),

                            Image.asset(
                              "assets/img/payment.png",
                              height: 20.s(context),
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/img/arrow_left.png",
                          height: 20.s(context),
                        ),
                      ],
                    ),
                  );
  }
}