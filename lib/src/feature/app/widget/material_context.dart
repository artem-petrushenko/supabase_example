import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:supabase_example/src/feature/settings/widget/settings_scope.dart';
import 'package:supabase_example/src/feature/to_do/bloc/fetch_to_do_list/fetch_to_do_list_bloc.dart';
import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';
import 'package:supabase_example/src/feature/to_do/widget/to_do_list.dart';
import 'package:supabase_example/src/feature/to_do/widget/update_to_do.dart';
import 'package:supabase_example/src/common/widget/scaffold/scaffold_with_navigation_bar.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;
    final textScale = SettingsScope.textScaleOf(context).textScale;

    final mediaQueryData = MediaQuery.of(context);

    return MaterialApp(
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.mode,
      locale: locale,
      // localizationsDelegates: Localization.localizationDelegates,
      // supportedLocales: Localization.supportedLocales,
      // routerConfig: AppRouter.router,
      builder: (context, child) => MediaQuery(
        key: _globalKey,
        data: mediaQueryData.copyWith(
          textScaler: TextScaler.linear(
            mediaQueryData.textScaler.scale(textScale).clamp(0.5, 2),
          ),
        ),
        child: child!,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ScaffoldWithNavigationBar(),
        '/to_do': (context) => const ToDoList(),
        '/to_do/update': (context) => UpdateToDo(toDoEntity: ModalRoute.of(context)!.settings.arguments as ToDoEntity),
      },
    );
  }
}