import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  // static constants
  static const messagesCollection = 'messages';
  static const authorIdField = 'authorId';
  static const timeStampField = 'timeStamp';
  static const textField = 'text';

  // variables
  final String authorId;
  final int timeStamp;
  final String text;

  // constructors
  Message({
    required this.authorId,
    required this.timeStamp,
    required this.text,
  });

  // overrides
  @override
  int get hashCode => authorId.hashCode ^ timeStamp.hashCode ^ text.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.authorId == authorId &&
        other.timeStamp == timeStamp &&
        other.text == text;
  }

  @override
  String toString() =>
      'Message($authorIdField: $authorId, $timeStampField: $timeStamp, $textField: $text)';

  // functions
  Message copyWith({
    String? authorId,
    int? timeStamp,
    String? text,
  }) =>
      Message(
        authorId: authorId ?? this.authorId,
        timeStamp: timeStamp ?? this.timeStamp,
        text: text ?? this.text,
      );

  Map<String, dynamic> toMap() => {
        authorIdField: authorId,
        timeStampField: timeStamp,
        textField: text,
      };

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        authorId: map[authorIdField] ?? '',
        timeStamp: map[timeStampField]?.toInt() ?? 0,
        text: map[textField] ?? '',
      );

  factory Message.fromDocumentSnapshot(DocumentSnapshot doc) => Message(
        authorId: doc[authorIdField],
        timeStamp: doc[timeStampField],
        text: doc[textField],
      );

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
