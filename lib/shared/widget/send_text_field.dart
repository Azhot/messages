import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/styles.dart';

class SendTextField extends StatefulWidget {
  final String hintText;
  final int maxLines;
  final Function(String text) onSend;

  // constructors
  const SendTextField({
    required this.hintText,
    required this.maxLines,
    required this.onSend,
    Key? key,
  }) : super(key: key);

  @override
  State<SendTextField> createState() => _SendTextFieldState();
}

class _SendTextFieldState extends State<SendTextField> {
  // variables
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Theme(
        data: Styles.appTheme(primaryColor: Constants.secondaryColorLight),
        child: container(context),
      );

  Container container(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Constants.primaryColorLight,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset.fromDirection(-1, 0),
            ),
          ],
        ),
        child: textField(context),
      );

  TextField textField(BuildContext context) => TextField(
        controller: _controller,
        onChanged: (value) => setState(() {}),
        minLines: 1,
        onSubmitted: _controller.text.isNotEmpty ? (_) => sendAction() : null,
        maxLines: widget.maxLines,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        style: Styles.basicTextStyle(),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
            hintText: widget.hintText,
            hintStyle: Styles.hintTextStyle(),
            suffixIcon: iconButton(context)),
      );

  IconButton iconButton(BuildContext context) => IconButton(
        icon: const Icon(Icons.send),
        splashColor: Colors.green,
        splashRadius: 10,
        onPressed: _controller.text.isNotEmpty ? () => sendAction() : null,
      );

  void Function()? sendAction() {
    widget.onSend(_controller.text);
    setState(_controller.clear);
    FocusScope.of(context).previousFocus();
  }
}
