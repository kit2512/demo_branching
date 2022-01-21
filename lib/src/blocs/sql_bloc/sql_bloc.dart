import 'dart:async';

import 'package:demo_branching/src/repositories/repositories.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sql_event.dart';
part 'sql_state.dart';

class SqlBloc extends Bloc<SqlEvent, SqlState> {
  final sqlRepository = SqliteRepository.instance;
  SqlBloc() : super(SqlUpdating()) {
    on<SqlAddEvent>(_add);
    on<SqlUpdateEvent>(_update);
    on<SqlDeleteEvent>(_delete);
    add(SqlUpdateEvent());
  }

  FutureOr<void> _add(SqlAddEvent event, Emitter<SqlState> emit) async {
    await sqlRepository.insertDog(event.dog);
    add(SqlUpdateEvent());
  }

  FutureOr<void> _update(SqlUpdateEvent event, Emitter<SqlState> emit) async {
    emit(SqlUpdating());
    await Future.delayed(Duration(seconds: 2));
    final dogs = await sqlRepository.getAllDogs();
    emit(SqlUpdated(dogs));
  }

  FutureOr<void> _delete(SqlDeleteEvent event, Emitter<SqlState> emit) async {
    await sqlRepository.deleteDog(event.dog);
    add(SqlUpdateEvent());
  }
}
