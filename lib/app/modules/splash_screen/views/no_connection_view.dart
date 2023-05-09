import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: LottieBuilder.asset('lottie/no-internet.json'),
      ),
    );
  }
}
