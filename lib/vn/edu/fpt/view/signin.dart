import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signin_controller.dart';

class SigninView extends GetView<SignInController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    const fptOrange = Color(0xFFF26F21);
    
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: Text(
            '@2026 thuộc sở hữu Wowy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                // Logo
                Center(
                  child: Image.asset(
                    'assets/images/fpt_logo.png',
                    height: 110,
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        children: [
                          Icon(Icons.image_not_supported, size: 60, color: Colors.grey[300]),
                          const SizedBox(height: 8),
                          const Text('Logo Image', style: TextStyle(color: Colors.grey)),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                
                // Phone Field
                const Text(
                  'Tài khoản',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
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
                    hintText: 'Số điện thoại hoặc email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: fptOrange),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Password Field
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mật khẩu',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.handleForgotPassword,
                      child: Text(
                        'quên mật khẩu?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
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
                    hintText: 'Mật khẩu',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordObscured.value 
                            ? Icons.visibility_off_outlined 
                            : Icons.visibility_outlined,
                        color: Colors.grey[400],
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: fptOrange),
                    ),
                  ),
                )),
                const SizedBox(height: 24),
                
                // Remember me Checkbox
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 4),
                    Obx(() => SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: controller.isRememberMe.value,
                        onChanged: controller.toggleRememberMe,
                        activeColor: fptOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        side: BorderSide(color: Colors.grey[400]!),
                      ),
                    )),
                    const SizedBox(width: 12),
                    const Text(
                      'ghi nhớ đăng nhập',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                
                // Login Button
                ElevatedButton(
                  onPressed: controller.handleSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fptOrange,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
