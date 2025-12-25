import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.addressName, this.addressFunction});
  final String addressName ;
  final Function()? addressFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                     addressName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Circular",
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: addressFunction,
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: mainCal,
                        fontSize: 16,
                        fontFamily: "Circular",
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}