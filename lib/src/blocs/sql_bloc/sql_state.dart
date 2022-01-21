part of 'sql_bloc.dart';

@immutable
abstract class SqlState {}

class SqlInitial extends SqlState {}

class SqlUpdating extends SqlState {}

class SqlUpdated extends SqlState {
  final List<Dog> dogs;

  SqlUpdated(this.dogs);
}
