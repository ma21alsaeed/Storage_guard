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
import 'package:storage_guard/features/operation/presentation/cubit/create_operation_cubit.dart';
import 'package:storage_guard/features/operation/presentation/cubit/get_all_operations_cubit.dart'
    as getOpsCubit;
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/features/transport/presentation/add_new_package_page.dart';
import 'package:storage_guard/features/transport/presentation/link_device_page.dart';
import 'package:storage_guard/features/transport/presentation/text_input_dialog_widget.dart';
import 'package:storage_guard/features/transport/services/transport_page_service.dart';

class TransportPage extends StatelessWidget {
  const TransportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleAppBar(),
                const SizedBox(height: 45),
                const _AddPackageSection(),
                const SizedBox(height: 25),
                const _AddDevicesSection(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocConsumer<CreateOperationCubit, CreateOperationState>(
                        listener: (context, state) {
                      if (state is CreatedOperationState) {
                        Provider.of<TransportPageService>(context,
                                listen: false)
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
                          context.read<TransportPageService>().addedPackages()
                              ? context
                                  .showDialog(
                                      const CustomDialog(TextInputDialog(
                                  true,
                                  title: "Enter Name",
                                )))
                                  .then((name) async {
                                  if (name != null) {
                                    List products = context
                                        .read<TransportPageService>()
                                        .packagesIdList
                                        .map((id) => {"id": id.toString()})
                                        .toList();
                                    Map<String, dynamic> data = {
                                      "type": "transport",
                                      "name": name.toString(),
                                      "products": products
                                    };
                                    BlocProvider.of<CreateOperationCubit>(
                                            context)
                                        .createOperation(data);
                                    BlocProvider.of<
                                            getOpsCubit
                                                .GetAllOperationsCubit>(context)
                                        .getAllOperations();
                                  }
                                })
                              : Fluttertoast.showToast(
                                  msg: "Please add at least one package");
                        },
                        withArrow: false,
                      );
                    })
                  ],
                ),
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
                "Count    ${context.watch<TransportPageService>().packagesIdList.length}",
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
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GradientButton(
                    title: "Add",
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const AddNewPackagePage(), withNavBar: false);
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
              context.watch<TransportPageService>().getConnectedDeviceName() !=
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
                              .watch<TransportPageService>()
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
                      DI.bluetoothService.requestBluetoothPermission();
                      context.read<TransportPageService>().createdOperation()
                          ? PersistentNavBarNavigator.pushNewScreen(context,
                              screen: const LinkDevicePage(), withNavBar: false)
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
