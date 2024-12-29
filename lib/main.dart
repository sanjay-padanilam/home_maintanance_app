import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/firebase_options.dart';
import 'package:home_maintanance_app/view/homescreen/homescreen.dart';
import 'package:home_maintanance_app/view/registration_screen/registration_screen.dart';
import 'package:home_maintanance_app/view/service_Details_Screen/service_details_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ServiceDetailsScreen(),
    );
  }
}
