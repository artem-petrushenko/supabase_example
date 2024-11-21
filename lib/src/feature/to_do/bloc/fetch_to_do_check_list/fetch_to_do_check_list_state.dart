part of 'fetch_to_do_check_list_bloc.dart';

sealed class FetchToDoCheckListState extends Equatable {
  const FetchToDoCheckListState({
    this.toDos = const [],
    this.message = '',
  });

  final List<ToDoEntity> toDos;
  final String message;

  bool get hasData => toDos.isNotEmpty;

  bool get hasFailure => this is _FetchToDoCheckListFailure;

  bool get isLoading => this is _FetchToDoCheckListProcessing;

  const factory FetchToDoCheckListState.idle({
    List<ToDoEntity> toDos,
    String message,
  }) = _FetchToDoCheckListIdle;

  const factory FetchToDoCheckListState.processing({
    List<ToDoEntity> toDos,
    String message,
  }) = _FetchToDoCheckListProcessing;

  const factory FetchToDoCheckListState.failure({
    List<ToDoEntity> toDos,
    required String message,
  }) = _FetchToDoCheckListFailure;

  @override
  List<Object> get props => [toDos, message];
}

class _FetchToDoCheckListFailure extends FetchToDoCheckListState {
  const _FetchToDoCheckListFailure({
    super.toDos,
    required String message,
  });
}

class _FetchToDoCheckListIdle extends FetchToDoCheckListState {
  const _FetchToDoCheckListIdle({
    super.toDos,
    super.message = 'Idle',
  });
}

class _FetchToDoCheckListProcessing extends FetchToDoCheckListState {
  const _FetchToDoCheckListProcessing({
    super.toDos,
    super.message = 'Loading',
  });
}
