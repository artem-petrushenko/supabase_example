import 'package:flutter/material.dart';

import 'package:supabase_example/src/feature/app/widget/material_context.dart';
import 'package:supabase_example/src/feature/initialization/model/dependencies.dart';
import 'package:supabase_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:supabase_example/src/feature/settings/widget/settings_scope.dart';
import 'package:supabase_example/src/feature/to_do/widget/to_do_scope.dart';

class App extends StatelessWidget {
  const App({required this.result, super.key});

  /// The result from the [CompositionRoot].
  final CompositionResult result;

  @override
  Widget build(BuildContext context) => DependenciesScope(
        dependencies: result.dependencies,
        child: SettingsScope(
          settingsBloc: result.dependencies.settingsBloc,
          child: ToDoScope(
            toDoCheckListBloc: result.dependencies.toDoCheckListBloc,
            toDoListBloc: result.dependencies.toDoListBloc,
            child: const MaterialContext(),
          ),
        ),
      );
}
