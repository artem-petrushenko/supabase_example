import 'package:flutter/material.dart';
import 'package:supabase_example/src/common/theme/colored_palette/colored_palette.dart';
import 'package:supabase_example/src/common/theme/colored_palette/light_colored_palette.dart';
import 'package:supabase_example/src/common/theme/extension/color/color_extension.dart';
import 'package:supabase_example/src/common/theme/extension/typography_extension.dart';

ColorExtension _colorExtension(ColoredPalette palette) => ColorExtension(
      primary: palette.primary,
  text: palette.text,
    );

TypographyExtension _typographyExtension(Color color) => const TypographyExtension(
      displayLarge: TextStyle(),
      displayMedium: TextStyle(),
      displaySmall: TextStyle(),
      headlineLarge: TextStyle(),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(),
      titleLarge: TextStyle(),
      titleMedium: TextStyle(
      ),
      titleSmall: TextStyle(),
      bodyLarge: TextStyle(
      ),
      bodyMedium: TextStyle(
      ),
      bodySmall: TextStyle(
      ),
      labelLarge: TextStyle(
      ),
      labelMedium: TextStyle(
      ),
      labelSmall: TextStyle(
      ),
    );

ColorExtension get lightColor => _colorExtension(LightColoredPalette());

ColorExtension get darkColor => _colorExtension(LightColoredPalette());

TypographyExtension get lightTypography => _typographyExtension(lightColor.text);

TypographyExtension get darkTypography => _typographyExtension(darkColor.text);
