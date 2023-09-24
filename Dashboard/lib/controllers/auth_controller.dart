import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storage_guard_dashboard/pages/create_product.dart';
import '../models/user.dart';
import '../pages/signin_page.dart';
import '../services/auth_services.dart';

class AuthController extends GetxController {
  Future<void> createUser(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController nameController,
    TextEditingController phoneController,
    TextEditingController companyController,
    TextEditingController locationController,
  ) async {
    try {
      final user = User(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone:
            phoneController.text.isNotEmpty ? phoneController.text : "09123456789",
        company: companyController.text.isNotEmpty
            ? companyController.text
            : "nestlee",
        location: locationController.text.isNotEmpty
            ? locationController.text
            : "Damascus",
      );
      var response = await AuthService.createUser(user);
       Get.to(() => SignInPage());
      Get.snackbar(
        'Success',
        'User registration successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Registration successful
      // Navigate to the next screen or show a success message
    } catch (e) {
            Get.snackbar(
        'Error',
        'User registration failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // Registration failed
      // Show an error message
      print('Error creating user: $e');
    }
  }

  Future<void> loginUser(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      String email = emailController.text;
      String password = passwordController.text;

      var response = await AuthService.loginUser(email, password);
            Get.snackbar(
        'Success',
        'User registration successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(()=>CreateQRCode());

      // Registration successful
      // Navigate to the next screen or show a success message
    } catch (e) {
      Get.snackbar(
        'Error',
        'User registration failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // Registration failed
      // Show an error message
      print('Error creating user: $e');
    }
  }
}
