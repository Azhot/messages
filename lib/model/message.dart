import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  // static constants
  static const messagesCollection = 'messages';
  static const authorIdField = 'authorId';
  static const dateField = 'date';
  static const textField = 'text';

  // variables
  final String authorId;
  final int date;
  final String text;

  // constructors
  Message({
    required this.authorId,
    required this.date,
    required this.text,
  });

  // overrides
  @override
  int get hashCode => authorId.hashCode ^ date.hashCode ^ text.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.authorId == authorId &&
        other.date == date &&
        other.text == text;
  }

  @override
  String toString() =>
      'Message($authorIdField: $authorId, $dateField: $date, $textField: $text)';

  // functions
  Message copyWith({
    String? authorId,
    int? date,
    String? text,
  }) =>
      Message(
        authorId: authorId ?? this.authorId,
        date: date ?? this.date,
        text: text ?? this.text,
      );

  Map<String, dynamic> toMap() => {
        authorIdField: authorId,
        dateField: date,
        textField: text,
      };

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        authorId: map[authorIdField] ?? '',
        date: map[dateField]?.toInt() ?? 0,
        text: map[textField] ?? '',
      );

  factory Message.fromDocumentSnapshot(DocumentSnapshot doc) => Message(
        authorId: doc[authorIdField],
        date: doc[dateField],
        text: doc[textField],
      );

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
