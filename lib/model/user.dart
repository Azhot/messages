import 'dart:convert';

class User {
  // variables
  final String uid;
  final String name;

  // constructors
  User(
    this.uid,
    this.name,
  );

  // overrides
  @override
  int get hashCode => uid.hashCode ^ name.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.uid == uid && other.name == name;
  }

  @override
  String toString() => 'User(uid: $uid, name: $name)';

  // functions
  User copyWith({
    String? uid,
    String? name,
  }) {
    return User(
      uid ?? this.uid,
      name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['uid'] ?? '',
      map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
