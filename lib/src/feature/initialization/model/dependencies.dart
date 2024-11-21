import 'package:supabase_example/src/feature/settings/bloc/settings_bloc.dart';
import 'package:supabase_example/src/feature/to_do/bloc/fetch_to_do_check_list/fetch_to_do_check_list_bloc.dart';
import 'package:supabase_example/src/feature/to_do/bloc/fetch_to_do_list/fetch_to_do_list_bloc.dart';
import 'package:supabase_example/src/feature/to_do/data/repository/to_do_repository.dart';

base class Dependencies {
  const Dependencies({
    required this.settingsBloc,
    required this.toDoRepository,
    required this.toDoCheckListBloc,
    required this.toDoListBloc,
  });

  final SettingsBloc settingsBloc;
  final ToDoRepository toDoRepository;
  final FetchToDoCheckListBloc toDoCheckListBloc;
  final FetchToDoListBloc toDoListBloc;
}

final class CompositionResult {
  const CompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  final Dependencies dependencies;

  final int msSpent;

  @override
  String toString() => '$CompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
