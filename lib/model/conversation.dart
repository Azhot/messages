import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:messages/model/message.dart';

class Conversation {
  // variables
  final String title;
  final List<Message> messages;

  // constructors
  Conversation(
    this.title,
    this.messages,
  );

  // overrides
  @override
  int get hashCode => title.hashCode ^ messages.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Conversation &&
        other.title == title &&
        listEquals(other.messages, messages);
  }

  @override
  String toString() => 'Conversation(title: $title, messages: $messages)';

  // functions
  Conversation copyWith({
    String? title,
    List<Message>? messages,
  }) =>
      Conversation(
        title ?? this.title,
        messages ?? this.messages,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'messages': messages.map((message) => message.toMap()).toList(),
      };

  factory Conversation.fromMap(Map<String, dynamic> map) => Conversation(
        map['title'] ?? '',
        List<Message>.from(
            map['messages']?.map((message) => Message.fromMap(message))),
      );

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source));
}
