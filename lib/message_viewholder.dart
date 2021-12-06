import 'package:messages/shared/constants.dart';
import 'package:messages/model/message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageViewholder extends StatelessWidget {
  // variables
  final Message message;
  final Color messageColor;

  //construcors
  const MessageViewholder(
    this.message,
    this.messageColor, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: messageColor,
        borderRadius: const BorderRadius.all(Radius.elliptical(8, 16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset.fromDirection(1, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.author.name,
            style: GoogleFonts.aBeeZee(
              color: Constants.secondaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message.text,
            style: GoogleFonts.aBeeZee(
              color: Constants.messageTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
