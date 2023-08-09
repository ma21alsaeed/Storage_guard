import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorOccurredTextWidget extends StatelessWidget {
  const ErrorOccurredTextWidget(
      {Key? key,
      this.message,
      this.textErrorMessage,
      this.fun,
      required this.errorType})
      : super(
          key: key,
        );
  final String? message;
  final String? textErrorMessage;
  final ErrorType errorType;
  final Future<void> Function()? fun;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            errorType == ErrorType.message
                ? textError()
                : errorType == ErrorType.server
                    ? serverError()
                    : emptyError()
          ],
        ),
      ),
    );
  }

  Widget textError() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message ?? "Unknown Error",
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1), fontSize: 28),
          ),
          fun != null
              ? InkWell(
                  onTap: fun,
                  child: Text(
                    textErrorMessage ?? "Try Again",
                    style: const TextStyle(color: Colors.indigo, fontSize: 25),
                  ),
                )
              : const SizedBox.shrink()
        ],
      );
  Widget serverError() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fun != null
              ? InkWell(
                  onTap: fun,
                  child: Lottie.asset('assets/error.json', fit: BoxFit.contain))
              : Lottie.asset('assets/error.json', fit: BoxFit.contain),
          Text(
            message ?? "Server Error",textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black87, fontSize: 22, fontFamily: "Poppins"),
          ),
        ],
      );
  Widget emptyError() => Column(
        children: [
          Text(
            message ?? "No Trips Found",
            style: const TextStyle(
                color: Colors.black87, fontSize: 22, fontFamily: "Poppins"),
          ),
          fun != null
              ? InkWell(
                  onTap: fun,
                  child: Lottie.asset('assets/empty.json', fit: BoxFit.contain))
              : Lottie.asset('assets/empty.json', fit: BoxFit.contain),
        ],
      );
}

enum ErrorType { message, server, empty }
