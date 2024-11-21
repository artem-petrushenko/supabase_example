part of 'update_to_do_bloc.dart';

sealed class UpdateToDoEvent extends Equatable {
  const UpdateToDoEvent();

  const factory UpdateToDoEvent.update({
    bool? status,
    String? title,
    String? description,
  }) = _UpdateToDo;

  @override
  List<Object?> get props => [];
}

final class _UpdateToDo extends UpdateToDoEvent {
  const _UpdateToDo({
    this.status,
    this.title,
    this.description,
  });

  final bool? status;
  final String? title;
  final String? description;

  @override
  List<Object?> get props => [status, title, description];
}
