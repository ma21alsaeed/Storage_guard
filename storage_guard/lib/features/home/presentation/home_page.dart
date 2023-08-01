import 'package:flutter/material.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/features/home/presentation/widgets/last_update_bottom_operations_section.dart';
import 'package:storage_guard/features/home/presentation/widgets/last_update_devices_section.dart';
import 'package:storage_guard/features/operation/presentation/widgets/operation_widget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 200,
                        child: Image.asset("assets/images/text_logo.png"))
                  ],
                ),
                const SizedBox(height: 45),
                const _CurrentOperationsSection(),
                const SizedBox(height: 45),
                const _LastUpdateSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrentOperationsSection extends StatelessWidget {
  const _CurrentOperationsSection();

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
          itemCount: 2,
          separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
          itemBuilder: (context, index) => const OperationWidget(),
        ),
      ],
    );
  }
}

class _LastUpdateSection extends StatelessWidget {
  const _LastUpdateSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleDivider("Last Update"),
        SizedBox(height: 16),
        LastUpdateDevicesSection(),
        SizedBox(height: 35),
        LastUpdateBottomSection(),
        SizedBox(height: 45),
      ],
    );
  }
}
