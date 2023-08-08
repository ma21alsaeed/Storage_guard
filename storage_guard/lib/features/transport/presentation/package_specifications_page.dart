import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/extensions/date_time_helper.dart';
import 'package:storage_guard/app/widgets/blue_title_text.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/app/widgets/error_occurred_widget.dart';
import 'package:storage_guard/app/widgets/loading_widget.dart';
import 'package:storage_guard/features/product/data/product_model.dart';
import 'package:storage_guard/features/product/presentation/cubit/product_cubit.dart';
import 'package:storage_guard/features/transport/services/transport_page_service.dart';
import 'package:storage_guard/features/warehouse/services/warehouse_page_service.dart';

class PackageSpecificationPage extends StatelessWidget {
  const PackageSpecificationPage({super.key, this.fromTransportPage = false});
  final bool fromTransportPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: BlocConsumer<ProductCubit, ProductState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          child: LoadingWidget());
                    } else if (state is GotProduct) {
                      ProductModel product = state.product;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Color(0xFF1E1E1E), fontSize: 18),
                              )),
                          const SizedBox(height: 38),
                          const BlueTitleText("Specifications"),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              Text("Product Name",
                                  style: TextStyles.regularTextStyle),
                              const SizedBox(width: 52),
                              Text(product.safeStatus(),
                                  style: TextStyles.regularTextStyle),
                              const SizedBox(width: 10),
                              SizedBox(
                                  width: 26,
                                  child: Image.asset(
                                      'assets/icons/shield_small.png')),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(product.name,
                              style: TextStyles.smallLightTextStyle),
                          const SizedBox(height: 16),
                          Text("Production Date",
                              style: TextStyles.regularTextStyle),
                          const SizedBox(height: 8),
                          Text(product.productionDate.formattedDate2,
                              style: TextStyles.smallLightTextStyle),
                          const SizedBox(height: 16),
                          Text("Expiration date",
                              style: TextStyles.regularTextStyle),
                          const SizedBox(height: 8),
                          Text(product.expiryDate.formattedDate2,
                              style: TextStyles.smallLightTextStyle),
                          const SizedBox(height: 22),
                          Text("Value Range",
                              style: TextStyles.regularTextStyle),
                          const Divider(
                            height: 40,
                            color: Colors.black54,
                          ),
                          _TableSection(product),
                          const SizedBox(height: 38),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                    "Do you want to add this package or not?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.textColor,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: GradientButton(
                                  title: "No",
                                  withArrow: false,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                                const SizedBox(width: 20),
                                Expanded(
                                    child: GradientButton(
                                  title: "Add",
                                  withArrow: false,
                                  onPressed: () {
                                    if (fromTransportPage) {
                                      Provider.of<TransportPageService>(context,
                                              listen: false)
                                          .addToPackagesIdList(product.id);
                                    } else {
                                      Provider.of<WarehousePageService>(context,
                                              listen: false)
                                          .addToPackagesIdList(product.id);
                                    }
                                    Navigator.pop(context);
                                  },
                                )),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: const Center(
                          child: ErrorOccurredTextWidget(
                              errorType: ErrorType.server),
                        ));
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

class _TableSection extends StatelessWidget {
  const _TableSection(this.product);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(),
      children: [
        const TableRow(
          decoration: BoxDecoration(border: Border.symmetric()),
          children: [
            TableCell(
              child: Text(''),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('Min'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('Max'),
              ),
            ),
            // TableCell(
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
            //     child: Text('AVG'),
            //   ),
            // ),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: const Border(
              top: BorderSide(width: 1, color: Colors.grey),
              bottom: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TableCell(
                child: Text('Temp'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(product.minTemp.toString()),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(product.maxTemp.toString()),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            //   child: TableCell(
            //     child: Text(product..toString()),
            //   ),
            // ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text('Humidity'),
              ),
            ),
            TableCell(
                child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(product.minHumidity.toString()),
            )),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(product.maxHumidity.toString()),
              ),
            ),
            // TableCell(
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            //     child: Text("20"),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
