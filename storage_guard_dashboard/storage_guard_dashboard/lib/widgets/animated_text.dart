import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedTextChange extends StatefulWidget {
  const AnimatedTextChange({Key? key}) : super(key: key);

  @override
  _AnimatedTextChangeState createState() => _AnimatedTextChangeState();
}

class _AnimatedTextChangeState extends State<AnimatedTextChange> {
  int _index = 0;
  static const listString = [
    "Welcome to Storage Guard",
    "Your storage is secure with us",
    "Secure storage at your service",
    "We're watching over your items",
    "Your safety is our top priority",
    "Trust us to keep your storage secure",
    "Keeping your valuables safe and sound",
    "Welcome to the Storage Guard family"
  ];
  static const _duration = Duration(seconds: 1);
  static const _delay = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _changeText();
  }

  void _changeText() async {
    while (true) {
      await Future.delayed(_delay);
      setState(() {
        _index = (_index + 1) % listString.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _duration,
      child: Text(
        listString[_index],
        key: ValueKey(_index),
        style: TextStyle(fontSize: 18.sp, color: Colors.white),
      ),
    );
  }
}
