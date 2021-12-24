import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/styles.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Constants.primaryLightColor,
        child: Center(
          child: Text(
            Strings.somethingWentWrong,
            textAlign: TextAlign.center,
            style: Styles.basicTextStyle(
              fontSize: 24,
              color: Constants.secondaryColor,
            ),
          ),
        ),
      );
}
