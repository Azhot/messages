import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class User {
  // static constants
  static const usersCollection = 'users';
  static const uidField = 'uid';
  static const emailField = 'email';
  static const nameField = 'name';

  // variables
  final String uid;
  final String email;
  final String name;

  // constructors
  User({
    required this.uid,
    required this.email,
    required this.name,
  });

  // overrides
  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ name.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other)
      ? true
      : other is User &&
          other.uid == uid &&
          other.email == email &&
          other.name == name;

  @override
  String toString() =>
      'User($uidField: $uid, $emailField: $email, $nameField: $name)';

  // functions
  User copyWith({
    String? uid,
    String? email,
    String? name,
  }) =>
      User(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
      );

  Map<String, dynamic> toMap() => {
        uidField: uid,
        emailField: email,
        nameField: name,
      };

  factory User.fromMap(Map<String, dynamic> map) => User(
        uid: map[uidField] ?? '',
        email: map[emailField] ?? '',
        name: map[nameField] ?? '',
      );

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromAuthUser(auth.User user) => User(
        uid: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );

  factory User.empty() => User(uid: '', email: '', name: '');
}
