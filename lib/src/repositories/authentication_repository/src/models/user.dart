import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? photo;
  final String? email;
  final String? name;

  const User({
    required this.id,
    this.email,
    this.photo,
    this.name,
  });

  static const User empty = User(id: "");

  User copyWith({
    String? id,
    String? email,
    String? photo,
    String? name,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      email: email ?? this.email,
    );
  }

  bool get isEmpty => this == empty;

  bool get isNotEmpty => this != empty;

  @override
  List<Object?> get props => [id, name, photo, email];
}
