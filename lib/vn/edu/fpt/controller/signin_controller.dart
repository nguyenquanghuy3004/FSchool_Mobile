import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/signup.dart';
import '../view/home.dart';
import '../../../../bindings/signup_binding.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordObscured = true.obs;
  var isRememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void toggleRememberMe(bool? value) {
    if (value != null) {
      isRememberMe.value = value;
    }
  }

  void handleSignIn() {
    if (formKey.currentState?.validate() ?? true) {
      // String phone = phoneController.text.trim();
      // String pass = passwordController.text;

      // Chuyển hướng tới trang chủ
      Get.offAll(() => const HomeView());
    }
  }

  void handleGoogleSignIn() {
    Get.snackbar('Info', 'Google Sign In clicked', snackPosition: SnackPosition.BOTTOM);
  }

  void handleFacebookSignIn() {
    Get.snackbar('Info', 'Facebook Sign In clicked', snackPosition: SnackPosition.BOTTOM);
  }

  void handleForgotPassword() {
    Get.snackbar('Info', 'Forgot Password clicked', snackPosition: SnackPosition.BOTTOM);
  }

  void handleSignUp() {
    Get.to(() => const SignUpView(), binding: SignUpBinding());
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}