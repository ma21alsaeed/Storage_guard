import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/app/widgets/error_occurred_widget.dart';
import 'package:storage_guard/app/widgets/loading_widget.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/features/home/presentation/widgets/last_update_bottom_operations_section.dart';
import 'package:storage_guard/features/home/presentation/widgets/last_update_devices_section.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';
import 'package:storage_guard/features/operation/presentation/cubit/get_all_operations_cubit.dart';
import 'package:storage_guard/features/operation/presentation/widgets/operation_widget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => BlocProvider.of<GetAllOperationsCubit>(context)
              .getAllOperations(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: BlocConsumer<GetAllOperationsCubit, GetAllOperationsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.9,
                        width: MediaQuery.sizeOf(context).width,
                        child: const Center(
                          child: LoadingWidget(),
                        ),
                      );
                    }
                    if (state is GotOperationsState) {
                      List<OperationModel> operations = state.operations
                          .where((element) => (element.finishedAt == null))
                          .toList();
                      // List<OperationModel> operations = [];

                      bool isAllSafe = true;
                      for (OperationModel operation in operations) {
                        if (operation.safetyStatus == 0) {
                          isAllSafe = false;
                          break;
                        }
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 200,
                                  child: Image.asset(
                                      "assets/images/text_logo.png"))
                            ],
                          ),
                          SizedBox(height: operations.isEmpty ? 0 : 45),
                          operations.isEmpty
                              ? const SizedBox()
                              : _CurrentOperationsSection(operations),
                          const SizedBox(height: 45),
                          _LastUpdateSection(operations, isAllSafe)
                        ],
                      );
                    } else if (state is ErrorState) {
                      return SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          child: Center(
                            child: ErrorOccurredTextWidget(
                              errorType: ErrorType.server,
                              message: state.message,
                              fun: () => BlocProvider.of<GetAllOperationsCubit>(
                                      context)
                                  .getAllOperations(),
                            ),
                          ));
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

class _CurrentOperationsSection extends StatelessWidget {
  const _CurrentOperationsSection(this.operations);
  final List<OperationModel> operations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleDivider("Current Operations"),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: operations.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
          itemBuilder: (context, index) => OperationWidget(operations[index]),
        )
      ],
    );
  }
}

class _LastUpdateSection extends StatelessWidget {
  const _LastUpdateSection(this.operations, this.isAllSafe);
  final List<OperationModel> operations;
  final bool isAllSafe;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleDivider("Last Update"),
        const SizedBox(height: 16),
        LastUpdateDevicesSection(operations, isAllSafe),
        const SizedBox(height: 35),
        LastUpdateBottomSection(operations),
        const SizedBox(height: 45),
      ],
    );
  }
}
