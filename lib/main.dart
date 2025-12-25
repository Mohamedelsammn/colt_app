import 'package:colt_app/logic/bin/app_binding.dart';
import 'package:colt_app/view/screens/pages/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحميل env
  await dotenv.load(fileName: ".env");

  // Supabase من env
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    
  );
  print(dotenv.env['SUPABASE_URL']);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Colt app',
      theme: ThemeData(
        applyElevationOverlayColor: true,
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          foregroundColor: Colors.white,
          shadowColor: Colors.white,

          backgroundColor: Colors.white,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
    );
  }
}
