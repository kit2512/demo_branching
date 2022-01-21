part of 'sql_bloc.dart';

abstract class SqlEvent {}

class SqlAddEvent extends SqlEvent {
  final Dog dog;

  SqlAddEvent({
    required this.dog,
  });
}

class SqlDeleteEvent extends SqlEvent {
  final Dog dog;

  SqlDeleteEvent({
    required this.dog,
  });
}

class SqlUpdateEvent extends SqlEvent {}
