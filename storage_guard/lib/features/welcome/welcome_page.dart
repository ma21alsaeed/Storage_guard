import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/features/welcome/widgets/app_sections_row.dart';
import 'package:storage_guard/main_page.dart';

const String truckpath = "assets/icons/truck_fill_small.png";
const String homepath = "assets/icons/home_small.png";
const String warehousepath = "assets/icons/warehouse_fill_small.png";
const String qrpath = "assets/icons/qr_code.png";

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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 200,
                        child: Image.asset("assets/images/text_logo.png"))
                  ],
                ),
                const SizedBox(height: 45),
                Text("Welcome Message", style: TextStyles.semiTitleTextStyle),
                const SizedBox(height: 35),
                Material(
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(40)),
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                        "\"Welcome to our application! We are thrilled that you have chosen to join us. Our user-friendly platform is designed to provide you with a seamless experience. Whether you are here to connect with others, learn something new, or simply enjoy our features, we are committed to making your time with us both enjoyable and productive. Thank you for choosing us!\"",
                        style: TextStyles.lightTextStyle),
                  ),
                ),
                const SizedBox(height: 20),
                const TitleDivider("App Sections"),
                const SizedBox(height: 20),
                const AppSectionsRow(homepath,
                    "The main section displays the currently running processes and the latest updates"),
                const SizedBox(height: 20),
                const AppSectionsRow(truckpath,
                    "The transport section enables you to add new transfer process"),
                const SizedBox(height: 20),
                const AppSectionsRow(warehousepath,
                    "warehouse section enable you to add new storage process "),
                const SizedBox(height: 20),
                const AppSectionsRow(qrpath,
                    "The QR Code section through which you can read any code issued by our company"),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GradientButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
                      },
                      title:"Next",
                    )
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
