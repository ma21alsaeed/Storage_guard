import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:storage_guard/app/constants/text_styles.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LoadingWidget()],
        ),
      ),
    );
  }
}

class LoadingPageWithHandler extends StatefulWidget {
  const LoadingPageWithHandler(this.handler, {super.key, this.handlerText});
  final Future Function() handler;
  final String? handlerText;
  @override
  State<LoadingPageWithHandler> createState() => _LoadingPageWithHandlerState();
}

class _LoadingPageWithHandlerState extends State<LoadingPageWithHandler> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler();
  }

  Future handler() async {
    print("Entered Handler");
    await widget.handler();
    print("Finished Handler");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoadingWidget(),
            SizedBox(height: widget.handlerText != null ? 22 : 0),
            widget.handlerText != null
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                      widget.handlerText!,textAlign: TextAlign.center,
                      style: TextStyles.regularTextStyle,
                    ),
                )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/loading.json',
      width: 230,
      height: 230,
    );
  }
}
