import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';
import 'package:supabase_example/src/feature/to_do/data/repository/to_do_repository.dart';

part 'update_to_do_event.dart';

part 'update_to_do_state.dart';

class UpdateToDoBloc extends Bloc<UpdateToDoEvent, UpdateToDoState> {
  UpdateToDoBloc(
    this._toDoEntity, {
    required ToDoRepository toDoRepository,
  })  : _toDoRepository = toDoRepository,
        super(const UpdateToDoState.idle()) {
    on<UpdateToDoEvent>((event, emit) => switch (event) {
          _UpdateToDo() => _onUpdateToDo(event, emit),
        });
  }

  final ToDoEntity _toDoEntity;
  final ToDoRepository _toDoRepository;

  Future<void> _onUpdateToDo(
    _UpdateToDo event,
    Emitter<UpdateToDoState> emit,
  ) async {
    if (state.isLoading) return;
    emit(const UpdateToDoState.processing());
    try {
      await _toDoRepository.update(
        id: _toDoEntity.id,
        status: event.status,
        title: event.title,
        description: event.description,
      );
      emit(const UpdateToDoState.success());
    } catch (e) {
      emit(UpdateToDoState.failure(message: e.toString()));
    } finally {
      emit(const UpdateToDoState.idle());
    }
  }
}
