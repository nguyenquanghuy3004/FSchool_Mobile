import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordObscured = true.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void handleSignUp() {
    if (formKey.currentState?.validate() ?? true) {

      
      Get.snackbar(
        'Success',
        'Sign up successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF27024).withOpacity(0.2),
        colorText: Colors.black,
      );
    }
  }

  void navigateToSignIn() {
    Get.back();
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
