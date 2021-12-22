import 'dart:convert';

class Author {
  // variables
  final String name;

  // constructors
  Author(
    this.name,
  );

  // overrides
  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Author && other.name == name;
  }

  @override
  String toString() => 'Author(name: $name)';

  // functions
  Author copyWith({String? name}) => Author(name ?? this.name);

  Map<String, dynamic> toMap() => {'name': name};

  factory Author.fromMap(Map<String, dynamic> map) => Author(map['name'] ?? '');

  String toJson() => json.encode(toMap());

  factory Author.fromJson(String source) => Author.fromMap(json.decode(source));
}
