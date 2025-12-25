import 'package:colt_app/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsContainer extends StatelessWidget {
  final String phoneNumber = "0123456789"; // الرقم
  final String whatsappNumber = "0123456789"; // رقم WhatsApp

  const ContactUsContainer({super.key});

  // فتح تطبيق الاتصال
  Future<void> _callPhone() async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Cannot launch phone dialer");
    }
  }

  // فتح WhatsApp
  Future<void> _openWhatsApp() async {
    final Uri url = Uri.parse("https://wa.me/$whatsappNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Cannot open WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.s(context)),
      height: 250.h(context),
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryCal,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Contact Us",
            style: TextStyle(
              fontFamily: "Circular",
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.s(context)),
          GestureDetector(
            onTap: _callPhone,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 12.s(context),
                horizontal: 20.s(context),
              ),
              decoration: BoxDecoration(
                color: mainCal,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: mainCal.withOpacity(0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                phoneNumber,
                style: const TextStyle(
                  fontFamily: "Circular",
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.s(context)),
          ElevatedButton.icon(
            onPressed: _openWhatsApp,
            icon: const Icon(Icons.chat),
            label: const Text(
              "Chat on WhatsApp",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: mainCal,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: 14.s(context),
                horizontal: 24.s(context),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: mainCal.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
