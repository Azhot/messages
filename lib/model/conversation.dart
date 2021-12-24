import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:messages/model/message.dart';
import 'package:messages/model/user.dart';

class Conversation {
  // variables
  final User author;
  final List<Message> messages;

  // constructors
  Conversation({
    required this.author,
    required this.messages,
  });

  // overrides
  @override
  int get hashCode => author.hashCode ^ messages.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Conversation &&
        other.author == author &&
        listEquals(other.messages, messages);
  }

  @override
  String toString() => 'Conversation(author: $author, messages: $messages)';

  // functions
  Conversation copyWith({
    User? author,
    List<Message>? messages,
  }) {
    return Conversation(
      author: author ?? this.author,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author.toMap(),
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      author: User.fromMap(map['author']),
      messages:
          List<Message>.from(map['messages']?.map((x) => Message.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source));
}
