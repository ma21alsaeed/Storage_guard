import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/button.dart';
import 'package:storage_guard/app/widgets/link_text.dart';
import 'package:storage_guard/app/widgets/text_form_field.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/authentication/presentation/signup_page.dart';
import 'package:storage_guard/features/authentication/presentation/widgets/email_text_field.dart';
import 'package:storage_guard/features/authentication/presentation/widgets/pass_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Image.asset(
                            'assets/images/text_logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          "Login",
                          style: TextStyles.semiTitleTextStyle,
                        ),
                        const SizedBox(height: 22),
                        Text(
                          "Please Sign In To Continue",
                          style: TextStyles.lightTextStyle,
                        ),
                        const SizedBox(height: 42),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  EmailTextField(emailCon: emailCon),
                                  const SizedBox(height: 18),
                                  PassTextField(passCon: passCon),
                                  const SizedBox(height: 32),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.0, 1.0],
                                            colors: [
                                              Color(0xBD233A8E),
                                              AppColors.mainblue,
                                            ],
                                          ),
                                        ),
                                        child: CustomElevatedButton(
                                          buttonColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          textColor: AppColors.background,
                                          borderRadius: 90,
                                          onPressed: () {
                                            Map<String, dynamic> data = {
                                              "identifier":
                                                  emailCon.text.trim(),
                                              "password": passCon.text.trim()
                                            };
                                            if (_formKey.currentState!
                                                .validate()) {
                                              emailCon.text.isEmpty;
                                              passCon.text.isEmpty;
                                              Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
                                                msg:
                                                    getTextFieldValidationInfoLogin(emailCon.text.trim(),passCon.text.trim()),
                                                backgroundColor: Colors.red,
                                              );
                                              // BlocProvider.of<AuthCubit>(context).login(data);
                                            }
                                          },
                                          verticalPadding: 12,
                                          horizantalPadding: 28,
                                          child: Row(
                                            children: const [
                                              Text(
                                                'Login',
                                                style: TextStyle(
                                                    height: 1,
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(width: 8),
                                              Icon(
                                                CupertinoIcons.arrow_right,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // BlocConsumer<AuthCubit, AuthState>(
                                  //     listener: (context, state) {
                                  //   if (state is AuthenticatedState) {
                                  //     context.showSuccessSnackBar('Login Successful');
                                  //   } else if (state is ErrorState) {
                                  //     Fluttertoast.showToast(msg: state.message);
                                  //   }
                                  // }, builder: (context, state) {
                                  //   if (state is LoadingState) {
                                  //     return const Center(child: CircularProgressIndicator());
                                  //   }
                                  //   return Row(
                                  //     children: [
                                  //       Expanded(
                                  //         child: CustomElevatedButton(
                                  //           buttonColor: AppColors.mainorange,
                                  //           title: "Login",
                                  //           textColor: AppColors.background,
                                  //           onPressed: () {
                                  //             Map<String, dynamic> data = {
                                  //               "identifier": emailCon.text.trim(),
                                  //               "password": passCon.text.trim()
                                  //             };
                                  //             if (_formKey.currentState!.validate()) {
                                  //               BlocProvider.of<AuthCubit>(context).login(data);
                                  //             }
                                  //           },
                                  //           verticalPadding: 13,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   );
                                  // }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyles.smallLightTextStyle,
                            ),
                            LinkText(
                              "Sign up",
                              fontSize: 16,
                              color: AppColors.mainblue,
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
