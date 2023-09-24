import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';

class LastUpdateBottomSection extends StatelessWidget {
  const LastUpdateBottomSection(this.operations, {super.key});
  final List<OperationModel> operations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Last Operations",
          style: TextStyles.regularTextStyle,
        ),
        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView.separated(
              itemCount: 2,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemBuilder: (context, index) => const _LastOperation(),
            ))
      ],
    );
  }
}

class _LastOperation extends StatelessWidget {
  const _LastOperation();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "add packages to Warehouse B1",
          style: TextStyles.bodyTitleTextStyle,
        ),
        Text(
          "30 min",
          style: TextStyles.smallLightTextStyle,
        ),
      ],
    );
  }
}
