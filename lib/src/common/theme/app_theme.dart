import 'package:flutter/material.dart';

import 'package:supabase_example/src/common/theme/colored_palette/colored_palette.dart';
import 'package:supabase_example/src/common/theme/extension/color/color_extension.dart';
import 'package:supabase_example/src/common/theme/extension/typography_extension.dart';


ThemeData createTheme(
  ColoredPalette palette, {
  required ColorExtension colors,
  required TypographyExtension typography,
}) =>
    ThemeData(
      useMaterial3: true,
      extensions: {
        colors,
        typography,
      },
    );
