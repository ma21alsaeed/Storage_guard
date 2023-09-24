import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storage_guard_dashboard/constant/colors.dart';
import 'package:storage_guard_dashboard/widgets/storage_guard_title.dart';
import 'package:storage_guard_dashboard/widgets/text_fields.dart';
import '../constant/textstyle.dart';
import '../controllers/auth_controller.dart';
import '../widgets/animated_text.dart';
import '../widgets/password_field.dart';
import '../widgets/text_button.dart';


class SignUpPage extends StatelessWidget {
  final AuthController userController = Get.put(AuthController());

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyController = TextEditingController();
    final locationController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 120.w, vertical: 100.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Material(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20.r)),
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 80.h),
                        StorageGuardTitle(),
                        SizedBox(height: 20.h),
                        Text('Create Account',
                            style: TextStyles.semiTitleTextStyle),
                        SizedBox(height: 20.h),
                        CircularTextField(
                          hintText: 'Username',
                          controller: nameController,
                        ),
                        SizedBox(height: 12.h),
                        CircularTextField(
                          hintText: 'Email',
                          controller: emailController,
                        ),
                        SizedBox(height: 12.h),
                        PasswordCircularTextField(
                          hintText: 'Password',
                          controller: passwordController,
                        ),
                        SizedBox(height: 12.h),
                        PasswordCircularTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.fromLTRB(330.w, 0, 0, 0),
                          child: CircularTextButton(
                            label: 'Sign Up →',
                            onPressed: () {
                              userController.createUser(
                                emailController,
                                passwordController,
                                nameController,
                                phoneController,
                                companyController,
                                locationController,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainblue,
                        borderRadius: BorderRadius.circular(20.r)),
                    padding: EdgeInsets.all(12.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200.h,
                          width: 200.w,
                          child: Image.asset(
                            "assets/images/logo_without_title.png",
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 32.h),
                        AnimatedTextChange()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}