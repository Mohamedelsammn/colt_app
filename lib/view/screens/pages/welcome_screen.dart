import 'package:colt_app/view/screens/pages/bottomBar/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/widgets/pages/age_widgets.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';

enum Gender { men, women }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Gender? selectedGender;
  String? selectedAgeRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 150.s(context)),
            const Text(
              'Tell us About yourself',
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60.s(context)),
            const Text(
              'Who do you shop for ?',
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.s(context)),
            Row(
              children: [
                _genderButton(
                  text: 'Men',
                  isSelected: selectedGender == Gender.men,
                  onTap: () {
                    setState(() {
                      selectedGender = Gender.men;
                    });
                  },
                ),
                SizedBox(width: 20.s(context)),
                _genderButton(
                  text: 'Women',
                  isSelected: selectedGender == Gender.women,
                  onTap: () {
                    setState(() {
                      selectedGender = Gender.women;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30.s(context)),
            const Text(
              'How Old are you?',
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.s(context)),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _ageOption('18 - 25'),
                      _ageOption('26 - 35'),
                      _ageOption('36 - 45'),
                      _ageOption('45 - 100'),
                    ],
                  ),
                );
              },
              child: AgeRangeTile(selectedRange: selectedAgeRange),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
        child: MaterialButton(
          elevation: 0,
          onPressed: () {
            Get.offAll(MainScreen());
          },
          color: mainCal,
          height: 52.h(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Text(
            'Finish',
            style: TextStyle(
              fontFamily: 'Circular',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _ageOption(String range) {
    return ListTile(
      title: Text(
        range,
        style: const TextStyle(fontFamily: 'Circular', fontSize: 18),
      ),
      onTap: () {
        setState(() {
          selectedAgeRange = range;
        });
        Navigator.pop(context); // اغلاق الـ BottomSheet بعد الاختيار
      },
    );
  }

  Expanded _genderButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: MaterialButton(
        elevation: 0,
        height: 52.h(context),
        onPressed: onTap,
        color: isSelected ? mainCal : secondaryCal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Circular',
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
