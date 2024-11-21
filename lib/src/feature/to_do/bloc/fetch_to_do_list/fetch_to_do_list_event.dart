part of 'fetch_to_do_list_bloc.dart';

sealed class FetchToDoListEvent extends Equatable {
  const FetchToDoListEvent();

  const factory FetchToDoListEvent.fetch({
    Completer? completer,
  }) = _ToDoListFetch;

  const factory FetchToDoListEvent.remove({
    required int id,
  }) = _RemoveToDo;

  @override
  List<Object?> get props => [];
}

final class _ToDoListFetch extends FetchToDoListEvent {
  const _ToDoListFetch({
    this.completer,
  });

  final Completer? completer;
}

final class _RemoveToDo extends FetchToDoListEvent {
  const _RemoveToDo({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [id];
}
