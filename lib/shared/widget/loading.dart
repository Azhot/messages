import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:messages/shared/constants.dart';

class Loading extends StatelessWidget {
  // constructors
  const Loading({Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => const Material(
        color: Constants.primaryColorLight,
        child: Center(
          child: SpinKitChasingDots(
            color: Constants.primaryColorDark,
            size: 48,
          ),
        ),
      );
}
