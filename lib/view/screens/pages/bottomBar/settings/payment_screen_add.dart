import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:colt_app/view/widgets/auth/textfield_widget.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class PaymentScreenAdd extends StatelessWidget {
  PaymentScreenAdd({
    super.key,
    this.cardNumber,
    this.cvv,
    this.exp,
    this.name,
    this.cardId,
  });

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  final String? cardNumber;
  final String? cvv;
  final String? exp;
  final String? name;
  final String? cardId; // null = add, not null = edit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        leadingWidth: 65,
        leading: BackButtonWidget(),
        centerTitle: true,
        title: Text(
          "Add Payment",
          style: TextStyle(
            fontFamily: "Gabarito",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextfieldWidget(
                hintText: "Card Number",
                controller: cardNumberController,
                validator: (s) {
                  if (s!.isEmpty) {
                    return "Enter Card Number";
                  } else {
                    return null;
                  }
                },
              ),

              SizedBox(height: 10.s(context)),

              Row(
                children: [
                  Expanded(
                    child: TextfieldWidget(
                      hintText: "Exp",
                      controller: expController,
                      validator: (st) {
                        if (st!.isEmpty) {
                          return "Enter Exp";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20.s(context)),
                  Expanded(
                    child: TextfieldWidget(
                      hintText: "CCV",
                      controller: cvvController,
                      validator: (c) {
                        if (c!.isEmpty) {
                          return "Enter CCV";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.s(context)),

              SizedBox(height: 10.s(context)),
              TextfieldWidget(
                validator: (cn) {
                  if (cn!.isEmpty) {
                    return "Enter CardHolder Name";
                  } else {
                    return null;
                  }
                },
                hintText: "CardHolder Name",
                controller: nameController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 30, left: 30),
        child: AuthButton(
          buttonText: "Save",
          onPressed: () async {
            if (!formkey.currentState!.validate()) return;

            final expText = expController.text.trim();

            if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(expText)) {
              Get.snackbar('Error', 'Expiry must be MM/YY');
              return;
            }

            final parts = expText.split('/');
            final month = int.parse(parts[0]);
            final year = 2000 + int.parse(parts[1]);

            if (month < 1 || month > 12) {
              Get.snackbar('Error', 'Invalid month');
              return;
            }

            if (cardId == null) {
              await controller.addCard(
                name: nameController.text,
                number: cardNumberController.text,
                cvv: cvvController.text,
                month: month,
                year: year,
              );
            } else {
              await controller.editCard(
                cardId: cardId!,
                name: nameController.text,
                number: cardNumberController.text,
                cvv: cvvController.text,
                month: month,
                year: year,
              );
            }

            Get.back();
          },
        ),
      ),
    );
  }
}
