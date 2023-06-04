import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/di.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DI.welcomeService.setIsFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 200,child: Image.asset("assets/images/text_logo.png"))
                  ],
                ),
                const SizedBox(height: 45),
                Text("Welcome Message",style: TextStyles.semiTitleTextStyle),
                Card()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
