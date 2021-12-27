import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:messages/shared/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Material(
        color: Constants.primaryColor,
        child: Center(
          child: SpinKitChasingDots(
            color: Constants.primaryDarkColor,
            size: 48,
          ),
        ),
      );
}
