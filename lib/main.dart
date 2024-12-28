import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyperpay/controller/binding_controller.dart';
import 'package:hyperpay/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingController(),
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: const Home(),
    );
  }
}

