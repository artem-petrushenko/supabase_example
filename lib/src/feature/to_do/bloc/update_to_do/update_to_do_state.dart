part of 'update_to_do_bloc.dart';

sealed class UpdateToDoState extends Equatable {
  const UpdateToDoState({
    this.message = '',
    this.toDoEntity,
  });

  final String message;
  final ToDoEntity? toDoEntity;

  bool get isLoading => this is _UpdateToDoProcessing;

  bool get hasFailure => this is _UpdateToDoFailure;

  bool get isSuccess => this is _UpdateToDoSuccess;

  const factory UpdateToDoState.idle() = _UpdateToDoIdle;

  const factory UpdateToDoState.processing() = _UpdateToDoProcessing;

  const factory UpdateToDoState.failure({
    required String message,
  }) = _UpdateToDoFailure;

  const factory UpdateToDoState.success({
    required ToDoEntity toDoEntity,
  }) = _UpdateToDoSuccess;

  @override
  List<Object?> get props => [message];
}

final class _UpdateToDoIdle extends UpdateToDoState {
  const _UpdateToDoIdle({
    super.message = 'Idle',
  });
}

final class _UpdateToDoProcessing extends UpdateToDoState {
  const _UpdateToDoProcessing({
    super.message = 'Loading',
  });
}

final class _UpdateToDoFailure extends UpdateToDoState {
  const _UpdateToDoFailure({
    super.message = 'Failed',
  });
}

final class _UpdateToDoSuccess extends UpdateToDoState {
  const _UpdateToDoSuccess({
    required super.toDoEntity,
    super.message = 'Success',
  });
}
