part of 'fetch_to_do_list_bloc.dart';

sealed class FetchToDoListState extends Equatable {
  const FetchToDoListState({
    this.toDos = const [],
    this.message = '',
  });

  final List<ToDoEntity> toDos;
  final String message;

  bool get hasData => toDos.isNotEmpty;

  bool get hasFailure => this is _FetchToDoListFailure;

  bool get isLoading => this is _FetchToDoListProcessing;

  const factory FetchToDoListState.idle({
    List<ToDoEntity> toDos,
    String message,
  }) = _FetchToDoListIdle;

  const factory FetchToDoListState.processing({
    List<ToDoEntity> toDos,
    String message,
  }) = _FetchToDoListProcessing;

  const factory FetchToDoListState.failure({
    List<ToDoEntity> toDos,
    required String message,
  }) = _FetchToDoListFailure;

  @override
  List<Object> get props => [toDos, message];
}

class _FetchToDoListIdle extends FetchToDoListState {
  const _FetchToDoListIdle({
    super.toDos,
    super.message = 'Idle',
  });
}

class _FetchToDoListProcessing extends FetchToDoListState {
  const _FetchToDoListProcessing({
    super.toDos,
    super.message = 'Loading',
  });
}

class _FetchToDoListFailure extends FetchToDoListState {
  const _FetchToDoListFailure({
    super.toDos,
    required String message,
  });
}
