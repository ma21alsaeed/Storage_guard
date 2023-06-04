import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;
  final bool draggable;
  final EdgeInsetsGeometry? padding;
  const BottomSheetContainer({
    super.key,
    required this.child,
    this.draggable = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: child,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BottomSheetHandle(),
        draggable ? Flexible(child: widget) : widget,
      ],
    );
  }
}

class BottomSheetHandle extends StatelessWidget {
  final Color? backgroundColor;
  const BottomSheetHandle({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        color: backgroundColor,
        margin: const EdgeInsets.only(top: 12),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}
