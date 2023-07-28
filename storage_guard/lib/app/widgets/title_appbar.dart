import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({this.withReturn = false, super.key});
  final bool withReturn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        withReturn
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: SizedBox(
                        width: 180,
                        child: Image.asset("assets/images/text_logo.png")),
                  ),
                  const SizedBox()
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 200,
                      child: Image.asset("assets/images/text_logo.png"))
                ],
              ),
      ],
    );
  }
}
