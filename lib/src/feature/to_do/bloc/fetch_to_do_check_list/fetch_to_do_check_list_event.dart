part of 'fetch_to_do_check_list_bloc.dart';

sealed class FetchToDoCheckListEvent extends Equatable {
  const FetchToDoCheckListEvent();

  const factory FetchToDoCheckListEvent.fetch({
    Completer? completer,
  }) = _ToDoCheckListFetch;

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
