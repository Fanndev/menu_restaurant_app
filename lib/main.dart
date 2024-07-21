import 'package:flutter/material.dart';
import 'package:restauran_menu/ui/cart.dart';
import 'package:restauran_menu/ui/detailProduct.dart';
import 'package:restauran_menu/ui/login.dart';
import 'package:restauran_menu/ui/register_email.dart';
import 'package:restauran_menu/ui/register.dart';
import 'package:restauran_menu/ui/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RestauranApps());
}

class RestauranApps extends StatefulWidget {
  RestauranApps({super.key});

  @override
  State<RestauranApps> createState() => _RestauranAppsState();
}

class _RestauranAppsState extends State<RestauranApps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Restauran Menu",
      home: SplashPage(),
    );
  }
}
