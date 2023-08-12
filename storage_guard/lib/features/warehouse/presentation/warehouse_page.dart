import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/app/extensions/dialog_build_context.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/app/widgets/custom_dialog.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/features/operation/presentation/cubit/create_operation_cubit.dart';
import 'package:storage_guard/features/transport/presentation/add_new_package_page.dart';
import 'package:storage_guard/features/transport/presentation/link_device_page.dart';
import 'package:storage_guard/features/transport/presentation/text_input_dialog_widget.dart';
import 'package:storage_guard/features/warehouse/services/warehouse_page_service.dart';
import 'package:storage_guard/features/operation/presentation/cubit/get_all_operations_cubit.dart'
    as getopscubit;

class WarehousePage extends StatelessWidget {
  const WarehousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 19),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleAppBar(),
                SizedBox(height: 45),
                _AddPackageSection(),
                SizedBox(height: 25),
                _AddDevicesSection(),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddPackageSection extends StatelessWidget {
  const _AddPackageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleDivider("Add Packages"),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Count    ${context.watch<WarehousePageService>().packagesIdList.length}",
                style: TextStyles.regularTextStyle,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Text(
                    "All Safe",
                    style: TextStyles.regularTextStyle,
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 26,
                    child: Image.asset("assets/icons/shield_small.png"),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GradientButton(
                      title: "Add",
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const AddNewPackagePage(
                                fromTransportPage: false),
                            withNavBar: false);
                      },
                      withArrow: false,
                    ),
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                      child: BlocConsumer<CreateOperationCubit,
                          CreateOperationState>(listener: (context, state) {
                    if (state is CreatedOperationState) {
                      Provider.of<WarehousePageService>(context, listen: false)
                          .setOperationId = state.operation.id;
                      Fluttertoast.showToast(
                          msg: "Created Operation Successfully");
                    }
                  }, builder: (context, state) {
                    if (state is LoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return GradientButton(
                      title: "Create",
                      onPressed: () {
                        context.read<WarehousePageService>().addedPackages()
                            ? context
                                .showDialog(const CustomDialog(TextInputDialog(
                                false,
                                title: "Enter Name",
                              )))
                                .then((name) async {
                                if (name != null) {
                                  List products = context
                                      .read<WarehousePageService>()
                                      .packagesIdList
                                      .map((id) => {"id": id.toString()})
                                      .toList();
                                  Map<String, dynamic> data = {
                                    "type": "storage",
                                    "name": name.toString(),
                                    "products": products
                                  };
                                  BlocProvider.of<CreateOperationCubit>(context)
                                      .createOperation(data);
                                  BlocProvider.of<
                                          getopscubit
                                              .GetAllOperationsCubit>(context)
                                      .getAllOperations();
                                }
                              })
                            : Fluttertoast.showToast(
                                msg: "Please add at least one package");
                      },
                      withArrow: false,
                    );
                  }))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _AddDevicesSection extends StatelessWidget {
  const _AddDevicesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleDivider("Link Device"),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.watch<WarehousePageService>().getConnectedDeviceName() !=
                      null
                  ? Column(
                      children: [
                        Text(
                          "Device Name",
                          style: TextStyles.regularTextStyle,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          context
                              .watch<WarehousePageService>()
                              .getConnectedDeviceName()!,
                          style: TextStyles.regularTextStyle,
                        ),
                      ],
                    )
                  : Text(
                      "No Connected Device",
                      style: TextStyles.regularTextStyle,
                    ),
              const SizedBox(height: 14),
              // Text(
              //   "Device Battery",
              //   style: TextStyles.regularTextStyle,
              // ),
              // const SizedBox(height: 14),
              // Text(
              //   "80%",
              //   style: TextStyles.regularTextStyle,
              // ),
              // const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GradientButton(
                    title: "Link",
                    onPressed: () {
                      String time =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      print("timestamp before cutting$time");
                      String timeStamp = time.substring(0, time.length - 4);
                      print("timestamp before cutting$timeStamp");
                      String warehouseData =
                          "${Provider.of<WarehousePageService>(context, listen: false).getOperationId},${DI.userService.getUser()!.token},$timeStamp";
                      context.read<WarehousePageService>().createdOperation()
                          ? PersistentNavBarNavigator.pushNewScreen(context,
                              screen: LinkDevicePage(
                                warehouseData: warehouseData,
                              ),
                              withNavBar: false)
                          : Fluttertoast.showToast(
                              msg:
                                  "Create an Operation first then link a device");
                    },
                    withArrow: false,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
