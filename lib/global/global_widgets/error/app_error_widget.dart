import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;

  const AppErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTexts.smallText(
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                text: message,
              ),
            ],
          ),
        ),
      ),
    );
  }
}