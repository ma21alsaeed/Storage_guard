import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/error_occurred_widget.dart';
import 'package:storage_guard/app/widgets/loading_widget.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';
import 'package:storage_guard/features/product/presentation/product_page.dart';
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
                    child: const LoadingWidget());
              } else if (state is GotShop) {
                ShopModel shop = state.shop;
                List<OperationModel> shopOperations = state.shop.operations;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleAppBar(),
                      
                      const SizedBox(height: 30),
                      TitleDivider(shop.user.name),const SizedBox(height: 8),Row(
                        children: [
                          Text(
                            shop.getIsSafe() ? "Safe" : "Not Safe",
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 30,
                            child: Image.asset("assets/icons/shield_small.png"),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text("Location", style: TextStyles.regularTextStyle),
                      const SizedBox(height: 8),
                      Text(
                        shop.user.location,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text("Phone", style: TextStyles.regularTextStyle),
                      const SizedBox(height: 8),
                      Text(
                        shop.user.phone.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 30),
                      shopOperations.isEmpty
                          ? const SizedBox.shrink()
                          : const TitleDivider("Operations"),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: 120,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: shopOperations.length,
                          itemBuilder: (context, index) {
                            return LogWidget(
                              shopOperations[index],
                              isFirst: index == 0,
                              isLast: index == shopOperations.length - 1,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: const Center(
                    child: ErrorOccurredTextWidget(errorType: ErrorType.server),
                  ));
            }),
      )),
    );
  }
}
