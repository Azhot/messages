import 'package:messages/model/message.dart';

class Conversation {
  final String title;
  final List<Message> messages;

  Conversation(this.title, this.messages);
}
