import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/view/widgets/auth/auth_button.dart';
import 'package:colt_app/view/widgets/auth/textfield_widget.dart';
import 'package:colt_app/view/widgets/pages/back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

class AddressScreenAdd extends StatelessWidget {
  AddressScreenAdd({
    super.key,
    this.addressId,
    this.initialStreet,
    this.initialCity,
    this.initialState,
  });
  final TextEditingController streetAdress = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  final String? addressId; // لو موجود يبقى تعديل
  final String? initialStreet;
  final String? initialCity;
  final String? initialState;

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
          "Add Address",
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
                hintText: "Street Adderss",
                controller: streetAdress,
                validator: (s) {
                  if (s!.isEmpty) {
                    return "Enter Street Adderss";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10.s(context)),
              TextfieldWidget(
                hintText: "City",
                controller: city,
                validator: (c) {
                  if (c!.isEmpty) {
                    return "Enter City";
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
                      hintText: "State",
                      controller: state,
                      validator: (st) {
                        if (st!.isEmpty) {
                          return "Enter State";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20.s(context)),
                  Expanded(
                    child: TextfieldWidget(
                      hintText: "Zip Code",
                      controller: TextEditingController(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 30, left: 30),
        child: AuthButton(
          buttonText: "Save",
          onPressed: () {
            if (formkey.currentState!.validate()) {
              if (addressId != null) {
                // تعديل
                controller.editAddress(
                  addressId: addressId!,
                  street: streetAdress.text,
                  city: city.text,
                  state: state.text,
                );
              } else {
                // إضافة جديد
                controller.addUserAddress(
                  street: streetAdress.text,
                  city: city.text,
                  state: state.text,
                );
              }
              Get.back(); // العودة للقائمة
            }
          },
        ),
      ),
    );
  }
}
