import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';
import 'package:supabase_example/src/feature/to_do/data/repository/to_do_repository.dart';

part 'fetch_to_do_list_event.dart';

part 'fetch_to_do_list_state.dart';

class FetchToDoListBloc extends Bloc<FetchToDoListEvent, FetchToDoListState> {
  FetchToDoListBloc({
    required ToDoRepository toDoRepository,
  })  : _toDoRepository = toDoRepository,
        super(const _FetchToDoListIdle()) {
    on<FetchToDoListEvent>((event, emit) => switch (event) {
          _ToDoListFetch() => _onToDoListFetch(event, emit),
          _RemoveToDo() => _onRemoveToDo(event, emit),
        });
  }

  final ToDoRepository _toDoRepository;

  Future<void> _onToDoListFetch(
    _ToDoListFetch event,
    Emitter<FetchToDoListState> emit,
  ) async {
    if (state.isLoading) {
      event.completer?.complete();
      return;
    }
    emit(const FetchToDoListState.processing());
    try {
      final toDos = await _toDoRepository.readAll();
      emit(FetchToDoListState.idle(toDos: toDos.toList()));
    } catch (e) {
      emit(FetchToDoListState.failure(message: e.toString()));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onRemoveToDo(
    _RemoveToDo event,
    Emitter<FetchToDoListState> emit,
  ) async {
    if (state.isLoading) return;
    final oldToDos = state.toDos;
    try {
      final toDos = oldToDos.where((element) => element.id != event.id).toList();
      emit(FetchToDoListState.processing(toDos: toDos));
      await _toDoRepository.delete(event.id);

      emit(FetchToDoListState.idle(toDos: toDos));
    } catch (e) {
      emit(FetchToDoListState.failure(message: e.toString(), toDos: oldToDos));
    } finally {
      emit(FetchToDoListState.idle(toDos: state.toDos));
    }
  }
}
