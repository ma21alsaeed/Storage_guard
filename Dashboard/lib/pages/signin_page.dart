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

class SignInPage extends StatelessWidget {
  final AuthController userController = Get.put(AuthController());

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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
                        SizedBox(height: 100.h),
                        const StorageGuardTitle(),
                        SizedBox(height: 40.h),
                        Text('Login', style: TextStyles.semiTitleTextStyle),
                        SizedBox(height: 32.h),
                        Text('Please sign in to continue',
                            style: TextStyles.smallLightTextStyle),
                        SizedBox(height: 32.h),
                        CircularTextField(
                          hintText: 'Email',
                          controller: emailController,
                        ),
                        SizedBox(height: 16.h),
                        PasswordCircularTextField(
                          hintText: 'Password',
                          controller: passwordController,
                        ),
                        SizedBox(height: 32.h),
                        Padding(
                          padding: EdgeInsets.fromLTRB(350.w, 0, 0, 0),
                          child: CircularTextButton(
                            label: 'Login →',
                            onPressed: () {
                              userController.loginUser(emailController,passwordController);
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
                        const AnimatedTextChange()
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
