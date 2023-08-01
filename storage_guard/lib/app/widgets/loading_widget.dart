import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/loading.json',
      width: 100,
      height: 100,
    );
  }
}
