import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';

class OtpCountdownTimer extends StatefulWidget {
  final Function onFinish;
  const OtpCountdownTimer({super.key, required this.onFinish,});

  @override
  State<OtpCountdownTimer> createState() => _CountState();
}

class _CountState extends State<OtpCountdownTimer> {
  int _start = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }


  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_start == 0) {
          _timer.cancel();
          // Timer has completed, trigger the onFinish callback
          widget.onFinish();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppTexts.smallText(text: '$_start''s',);
  }
}