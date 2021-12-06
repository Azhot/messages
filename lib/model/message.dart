import 'package:messages/model/author.dart';

class Message {
  final Author author;
  late final int date;
  final String text;

  Message(this.author, this.text) {
    date = DateTime.now().millisecondsSinceEpoch;
  }
}
