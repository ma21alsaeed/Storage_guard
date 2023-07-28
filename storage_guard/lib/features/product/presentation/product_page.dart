import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/widgets/error_occured_widget.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/features/product/data/product_model.dart';
import 'package:storage_guard/features/product/presentation/cubit/product_cubit.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingState) {
                return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              } else if (state is GotProduct) {
                ProductModel product = state.product;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleAppBar(),
                          const SizedBox(height: 60),
                          TitleDivider("Specifications"),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Product Name",
                                  style: TextStyles.regularTextStyle),
                              const Spacer(),
                              Text(
                                product.safe ? "Safe" : "Not Safe",
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 30,
                                child: Image.asset(
                                    "assets/icons/shield_small.png"),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.productName,
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                          Text("Manfactured by",
                              style: TextStyles.regularTextStyle),
                          const SizedBox(height: 8),
                          Text(product.manufacturedBy),
                          const SizedBox(height: 20),
                          Text("Production Date",
                              style: TextStyles.regularTextStyle),
                          const SizedBox(height: 8),
                          Text(product.productionDate,
                              style: TextStyle(fontSize: 15)),
                          const SizedBox(height: 20),
                          Text("Expiration Date",
                              style: TextStyles.regularTextStyle),
                          const SizedBox(height: 8),
                          Text(product.expirationDate,
                              style: TextStyle(fontSize: 15)),
                          const SizedBox(height: 50),
                          TitleDivider("Logs"),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 120,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: product.logs.length,
                        itemBuilder: (context, index) {
                          return LogWidget(
                            product.logs[index],
                            isFirst: index == 0,
                            isLast: index == product.logs.length - 1,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox.shrink(),
                      ),
                    )
                  ],
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

class LogWidget extends StatelessWidget {
  const LogWidget(this.log,
      {super.key, this.isLast = false, this.isFirst = false});
  final Log log;
  final bool isLast;
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isFirst ? const LineWidget() : const SizedBox.shrink(),
        Column(
          children: [
            Text(
              log.getDate(),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.mainblue),
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: SizedBox(
                      width: 40,
                      child: Image.asset(log.type == "storage"
                          ? "assets/icons/warehouse_small.png"
                          : "assets/icons/truck_small.png"))),
            ),
          ],
        ),
        !isLast ? const LineWidget() : const SizedBox(width: 20)
      ],
    );
  }
}

class LineWidget extends StatelessWidget {
  const LineWidget({super.key, this.isFirstLine = false});
  final bool isFirstLine;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFirstLine ? 25 : 35,
      height: 1.5,
      margin: isFirstLine
          ? EdgeInsets.only(right: 6)
          : EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(color: Colors.black87),
    );
  }
}
