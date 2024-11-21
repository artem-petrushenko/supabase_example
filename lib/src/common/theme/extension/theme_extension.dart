import 'package:flutter/material.dart';
import 'package:supabase_example/src/common/theme/extension/color/color_extension.dart';
import 'package:supabase_example/src/common/theme/extension/typography_extension.dart';
import 'package:supabase_example/src/common/theme/theme_helper.dart';

extension ThemeDataExtensions on ThemeData {
  ColorExtension get palette => extension<ColorExtension>() ?? lightColor;

  TypographyExtension get defaultTypography => extension<TypographyExtension>() ?? lightTypography;
}
