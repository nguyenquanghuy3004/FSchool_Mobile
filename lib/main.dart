import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/signin_binding.dart';
import 'vn/edu/fpt/view/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FPT University',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEB844F)),
        useMaterial3: true,
      ),
      initialBinding: SigninBinding(),
      home: const SigninView(),
    );
  }
}

