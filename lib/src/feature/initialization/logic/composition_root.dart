import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_example/src/feature/initialization/model/dependencies.dart';
import 'package:supabase_example/src/feature/settings/bloc/settings_bloc.dart';
import 'package:supabase_example/src/feature/settings/data/locale_datasource.dart';
import 'package:supabase_example/src/feature/settings/data/locale_repository.dart';
import 'package:supabase_example/src/feature/settings/data/text_scale_datasource.dart';
import 'package:supabase_example/src/feature/settings/data/text_scale_repository.dart';
import 'package:supabase_example/src/feature/settings/data/theme_datasource.dart';
import 'package:supabase_example/src/feature/settings/data/theme_mode_codec.dart';
import 'package:supabase_example/src/feature/settings/data/theme_repository.dart';
import 'package:supabase_example/src/feature/to_do/data/provider/to_do_provider.dart';
import 'package:supabase_example/src/feature/to_do/data/repository/to_do_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class CompositionRoot {
  const CompositionRoot();

  Future<CompositionResult> compose() async {
    final stopwatch = Stopwatch()..start();

    final dependencies = await _initDependencies();

    stopwatch.stop();
    final result = CompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
    return result;
  }

  Future<Dependencies> _initDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    final supabase = await Supabase.initialize(
      url: 'https://tcuftsddmyaivqmrpxxc.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjdWZ0c2RkbXlhaXZxbXJweHhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1MjU0MDUsImV4cCI6MjA0NzEwMTQwNX0.zdiUrh2pkk5yjRzNplLGX9-CyftvRcTQXVeKkv3PpMc',
    );
    final toDoDatabase = supabase.client.from('to_do');
    final toDoProvider = ToDoProviderRemoteDataNetwork(
      client: toDoDatabase,
    );
    final toDoRepository = ToDoRepositoryImpl(
      toDoProvider: toDoProvider,
    );
    final settingsBloc = _initSettingsBloc(prefs);

    return Dependencies(
      settingsBloc: settingsBloc,
      toDoRepository: toDoRepository,
    );
  }

  SettingsBloc _initSettingsBloc(SharedPreferences prefs) {
    final localeRepository = LocaleRepositoryImpl(
      localeDataSource: LocaleDataSourceLocal(sharedPreferences: prefs),
    );

    final themeRepository = ThemeRepositoryImpl(
      themeDataSource: ThemeDataSourceLocal(
        sharedPreferences: prefs,
        codec: const ThemeModeCodec(),
      ),
    );

    final textScaleRepository = TextScaleRepositoryImpl(
      textScaleDataSource: TextScaleDatasourceLocal(sharedPreferences: prefs),
    );

    final localeFuture = localeRepository.getLocale();
    final theme = themeRepository.getTheme();
    final locale = localeFuture;
    final textScale = textScaleRepository.getScale();

    final initialState = SettingsState.idle(
      appTheme: theme,
      locale: locale,
      textScale: textScale,
    );

    final settingsBloc = SettingsBloc(
      localeRepository: localeRepository,
      themeRepository: themeRepository,
      textScaleRepository: textScaleRepository,
      initialState: initialState,
    );
    return settingsBloc;
  }
}
