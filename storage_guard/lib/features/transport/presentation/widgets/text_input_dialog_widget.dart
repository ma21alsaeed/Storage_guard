import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/app/widgets/text_form_field.dart';
import 'package:storage_guard/features/operation/presentation/cubit/create_operation_cubit.dart';
import 'package:storage_guard/features/transport/services/transport_page_service.dart';

class TextInputDialog extends StatefulWidget {
  const TextInputDialog({super.key, this.title = "Text Dialog"});
  final String title;

  @override
  State<TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  final TextEditingController _fieldCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_sharp)),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                widget.title,
                style: TextStyles.mediumTextStyle,
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(14),
            child: CustomTextFormField(
              controller: _fieldCon,
              fillColor: AppColors.textFieldColor,
              hintText: "Warehouse/Truck Name",
              textDirection: TextDirection.ltr,
              hintColor: Colors.grey,
              borderRadius: 14,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
              textColor: AppColors.textColor,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: BlocConsumer<CreateOperationCubit, CreateOperationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const CircularProgressIndicator();
                  }
                  return GradientButton(
                    title: "Submit",
                    onPressed: () async {
                      if (_fieldCon.text.isNotEmpty) {
                        List products = context
                            .read<TransportPageService>()
                            .packagesIdList
                            .map((id) => {"id": id.toString()})
                            .toList();
                        Map<String, dynamic> data = {
                          "type": "transport",
                          "name": _fieldCon.text.toString(),
                          "products": products
                        };
                        await DI
                            .createOperationCubitFactory()
                            .createOperations(data);
                        DI.getAllOperationsCubitFactory().getAllOperations();
                      } else {
                        Fluttertoast.showToast(msg: "Please Fill the Field");
                      }
                    },
                    withArrow: false,
                  );
                })),
        const SizedBox(height: 26),
      ],
    );
  }
}
