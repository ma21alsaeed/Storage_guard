import 'package:flutter/material.dart';

class ErrorOccuredTextWidget extends StatelessWidget {
  const ErrorOccuredTextWidget(
      {Key? key, this.message = "Error occured try again", this.fun})
      : super(
          key: key,
        );
  final String message;
  final Future<void> Function()? fun;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 28),
            ),
            InkWell(
              onTap: () {
                if (fun != null) fun!();
              },
              child: const Text(
                "Try Again",
                style: TextStyle(color: Colors.indigo, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
