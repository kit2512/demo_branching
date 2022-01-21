import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? photoUrl;

  User({
    String? id,
    this.email,
    this.name,
    this.photoUrl,
  }) : id = id ?? const Uuid().v4();

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  static final User empty = User(id: "");

  bool get isEmpty => this == empty;

  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [id, email, name, photoUrl];
}
