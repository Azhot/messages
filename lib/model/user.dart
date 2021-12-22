import 'dart:convert';

class User {
  // variables
  final String uid;

  // constructors
  User(
    this.uid,
  );

  // overrides
  @override
  int get hashCode => uid.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.uid == uid;
  }

  @override
  String toString() => 'User(uid: $uid)';

  // functions
  User copyWith({String? uid}) => User(uid ?? this.uid);

  Map<String, dynamic> toMap() => {'uid': uid};

  factory User.fromMap(Map<String, dynamic> map) => User(map['uid'] ?? '');

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
