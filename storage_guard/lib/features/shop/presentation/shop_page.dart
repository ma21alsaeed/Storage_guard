import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/error_occured_widget.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/features/shop/data/shop_model.dart';
import 'package:storage_guard/features/shop/presentation/cubit/shop_cubit.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocConsumer<ShopCubit, ShopState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingState) {
                return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              } else if (state is GotShop) {
                ShopModel shop = state.shop;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleAppBar(),
                      const SizedBox(height: 60),
                      TitleDivider(shop.shopName),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Temperature",
                              style: TextStyles.regularTextStyle),
                          const Spacer(),
                          Text(
                            shop.safe ? "Safe" : "Not Safe",
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 30,
                            child: Image.asset("assets/icons/shield_small.png"),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        shop.temperature + " Celsius",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 20),
                      Text("Humidity", style: TextStyles.regularTextStyle),
                      const SizedBox(height: 8),
                      Text(shop.humidity),
                      const SizedBox(height: 60),
                      const TitleDivider("Market Information"),
                      const SizedBox(height: 10),
                      Text("Location", style: TextStyles.regularTextStyle),
                      const SizedBox(height: 8),
                      Text(
                        shop.location,
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text("Phone", style: TextStyles.regularTextStyle),
                      const SizedBox(height: 8),
                      Text(
                        shop.phone,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: Center(
                    child: ErrorOccuredTextWidget(),
                  ));
            }),
      )),
    );
  }
}
