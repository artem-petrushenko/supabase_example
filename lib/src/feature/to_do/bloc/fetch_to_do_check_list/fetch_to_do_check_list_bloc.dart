import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';
import 'package:supabase_example/src/feature/to_do/data/repository/to_do_repository.dart';

part 'fetch_to_do_check_list_event.dart';

part 'fetch_to_do_check_list_state.dart';

class FetchToDoCheckListBloc extends Bloc<FetchToDoCheckListEvent, FetchToDoCheckListState> {
  FetchToDoCheckListBloc({
    required ToDoRepository toDoRepository,
  })  : _toDoRepository = toDoRepository,
        super(const FetchToDoCheckListState.idle()) {
    on<FetchToDoCheckListEvent>(
      (event, emit) => switch (event) {
        _ToDoCheckListFetch() => _onToDoCheckListFetch(event, emit),
        _ToDoCheckListUpdate() => _onToDoCheckListUpdate(event, emit),
      },
    );
  }

  final ToDoRepository _toDoRepository;

  Future<void> _onToDoCheckListFetch(
    _ToDoCheckListFetch event,
    Emitter<FetchToDoCheckListState> emit,
  ) async {
    if (state.isLoading) {
      event.completer?.complete();
      return;
    }
    emit(const FetchToDoCheckListState.processing());
    try {
      final toDos = await _toDoRepository.readAll(
        status: true,
      );
      emit(FetchToDoCheckListState.idle(toDos: toDos.toList()));
    } catch (e) {
      emit(FetchToDoCheckListState.failure(message: e.toString()));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onToDoCheckListUpdate(
      _ToDoCheckListUpdate event,
      Emitter<FetchToDoCheckListState> emit,
      ) async {
    if (state.isLoading) return;
    final oldToDos = state.toDos;
    try {
      final toDos = oldToDos.where((toDo) => toDo.id != event.toDoEntity.id).toList();
      if (event.toDoEntity.status) {
        toDos.add(event.toDoEntity);
      }
      emit(FetchToDoCheckListState.idle(toDos: toDos));
    } catch (e) {
      emit(FetchToDoCheckListState.failure(message: e.toString(), toDos: oldToDos));
    }
  }
}
