import 'package:supabase_example/src/core/utils/persisted_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template text_scale_datasource}
/// [TextScaleDatasource] is a data source that provides text scale data.
///
/// This is used to set and get text scale.
/// {@endtemplate}
abstract interface class TextScaleDatasource {
  /// Get current text scale from cache
  Future<void> setScale(double scale);

  /// Set text scale
  double? getScale();
}

/// {@macro text_scale_datasource}
final class TextScaleDatasourceLocal implements TextScaleDatasource {
  /// {@macro text_scale_datasource}
  TextScaleDatasourceLocal({required this.sharedPreferences});

  /// The instance of [SharedPreferences] used to read and write values.
  final SharedPreferences sharedPreferences;

  late final _textScale = DoublePreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: 'settings.textScale',
  );

  @override
  Future<void> setScale(double scale) async => _textScale.set(scale);

  @override
  double? getScale() => _textScale.read();
}
