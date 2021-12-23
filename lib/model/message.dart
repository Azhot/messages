import 'dart:convert';

import 'package:messages/model/user.dart';

class Message {
  // variables
  final User author;
  final int date;
  final String text;

  // constructors
  Message(
    this.author,
    this.date,
    this.text,
  );

  Message.now(
    this.author,
    this.text,
  ) : date = DateTime.now().millisecondsSinceEpoch;

  // overrides
  @override
  int get hashCode => author.hashCode ^ date.hashCode ^ text.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.author == author &&
        other.date == date &&
        other.text == text;
  }

  @override
  String toString() => 'Message(author: $author, date: $date, text: $text)';

  // functions
  Message copyWith({
    User? user,
    int? date,
    String? text,
  }) =>
      Message(
        user ?? this.author,
        date ?? this.date,
        text ?? this.text,
      );

  Map<String, dynamic> toMap() => {
        'author': author,
        'date': date,
        'text': text,
      };

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        User.fromMap(map['user']),
        map['date'] ?? DateTime.now().millisecondsSinceEpoch,
        map['text'] ?? '',
      );

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
