import 'dart:convert';

class Conversation {
  // static constants
  static const conversationsCollection = 'conversations';
  static const uidField = 'uid';
  static const titleField = 'title';
  static const lastUpdateField = 'lastUpdate';

  // variables
  final String uid;
  final String title;
  final int lastUpdate;

  // constructors
  Conversation({
    required this.uid,
    required this.title,
    required this.lastUpdate,
  });

  // overrides
  @override
  int get hashCode => uid.hashCode ^ title.hashCode ^ lastUpdate.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Conversation &&
        other.uid == uid &&
        other.title == title &&
        other.lastUpdate == lastUpdate;
  }

  @override
  String toString() =>
      'Conversation($uidField: $uid, $titleField: $title, $lastUpdateField: $lastUpdate)';

  // functions
  Conversation copyWith({
    String? uid,
    String? title,
    int? lastUpdate,
  }) {
    return Conversation(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      uidField: uid,
      titleField: title,
      lastUpdateField: lastUpdate,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      uid: map[uidField] ?? '',
      title: map[titleField] ?? '',
      lastUpdate: map[lastUpdateField]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source));
}
