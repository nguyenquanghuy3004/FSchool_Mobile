import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    const fptOrange = Color(0xFFF27024);
    const fptGradientStart = Color(0xFFF48545);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3ED),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(fptOrange),
                    const SizedBox(height: 40),
                    _buildFormCard(fptOrange, fptGradientStart),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color fptOrange) {
    return Column(
      children: [
        Text(
          'FPT School',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: fptOrange,
            shadows: [
              Shadow(
                color: fptOrange.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: fptOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'CỔNG THÔNG TIN HỌC TẬP',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: fptOrange,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(Color fptOrange, Color fptGradientStart) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Đăng ký',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: fptOrange,
            ),
          ),
          const SizedBox(height: 32),
          _buildPhoneField(fptOrange),
          const SizedBox(height: 20),
          _buildPasswordField(fptOrange),
          const SizedBox(height: 32),
          _buildContinueButton(fptOrange, fptGradientStart),
        ],
      ),
    );
  }

  Widget _buildPhoneField(Color focusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Số điện thoại', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Vui lòng nhập số điện thoại của bạn';
            if (!GetUtils.isPhoneNumber(value)) return 'Vui lòng nhập số điện thoại hợp lệ';
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Nhập số điện thoại của bạn',
            prefixIcon: const Icon(Icons.phone_outlined),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: focusColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(Color focusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mật khẩu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 8),
        Obx(() => TextFormField(
          controller: controller.passwordController,
          obscureText: controller.isPasswordObscured.value,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu của bạn';
            if (value.length < 6) return 'Mật khẩu phải có ít nhất 6 ký tự';
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Nhập mật khẩu của bạn',
            prefixIcon: const Icon(Icons.lock_outline),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: focusColor, width: 1.5),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordObscured.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.grey[400],
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildContinueButton(Color color1, Color color2) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: controller.handleSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Tiếp tục',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
