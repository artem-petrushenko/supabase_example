part of 'fetch_to_do_check_list_bloc.dart';

sealed class FetchToDoCheckListEvent extends Equatable {
  const FetchToDoCheckListEvent();

  const factory FetchToDoCheckListEvent.fetch({
    Completer? completer,
  }) = _ToDoCheckListFetch;

  const factory FetchToDoCheckListEvent.update({
    required ToDoEntity toDoEntity,
  }) = _ToDoCheckListUpdate;

  @override
  List<Object?> get props => [];
}

final class _ToDoCheckListFetch extends FetchToDoCheckListEvent {
  const _ToDoCheckListFetch({
    this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

final class _ToDoCheckListUpdate extends FetchToDoCheckListEvent {
  const _ToDoCheckListUpdate({
    required this.toDoEntity,
  });

  final ToDoEntity toDoEntity;

  @override
  List<Object?> get props => [toDoEntity];
}