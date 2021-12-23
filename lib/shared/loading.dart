import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:messages/shared/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.primaryColor,
      child: const Center(
        child: SpinKitChasingDots(
          color: Constants.primaryDarkColor,
          size: 50,
        ),
      ),
    );
  }
}
