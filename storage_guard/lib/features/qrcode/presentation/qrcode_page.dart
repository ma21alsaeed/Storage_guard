import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/widgets/button.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/features/product/presentation/cubit/product_cubit.dart';
import 'package:storage_guard/features/product/presentation/product_page.dart';
import 'package:storage_guard/features/qrcode/presentation/qr_view_page.dart';
import 'package:storage_guard/features/shop/presentation/cubit/shop_cubit.dart';
import 'package:storage_guard/features/shop/presentation/shop_page.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleAppBar(),
                const SizedBox(height: 60),
                Container(
                  width: double.infinity,
                  height: 170,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(18)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Scan Qr Code",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Press the Scan button to start capturing QR codes",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: Image.asset('assets/images/qr_background.png')),
                ),
                const SizedBox(height: 70),
                Center(
                  child: SizedBox(
                      width: 160,
                      child: CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const QRViewPage()))
                              .then((value) {
                            if (value.contains("StorageGuard") &&
                                value.contains("Product")) {
                              BlocProvider.of<ProductCubit>(context).getProduct(
                                  int.parse(value.substring(
                                      value.indexOf(":") + 1, value.length)));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductPage()));
                            }
                            if (value.contains("user")) {
                              BlocProvider.of<ShopCubit>(context)
                                  .getShop(value);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ShopPage()));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "This is not a storage guard QR Code");
                            }
                          });
                        },
                        title: "Scan",
                        borderRadius: 22,
                        buttonColor: AppColors.mainblue,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
