import 'package:animate_do/animate_do.dart';
import 'package:colt_app/utils/colors/colors.dart';
import 'package:colt_app/view/screens/auth/signin_screen.dart';
import 'package:colt_app/view/screens/pages/bottomBar/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_x_toolkit/responsive_x.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      final session = supabase.auth.currentSession;

      if (session != null) {
        Get.offAll(() => MainScreen());
      } else {
        Get.offAll(() => SigninScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainCal,
      body: BounceInDown(
        child: Center(child: Image.asset('assets/img/logo.png', height: 100.h(context))),
      ),
    );
  }
}
