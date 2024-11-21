import 'package:flutter/material.dart';

class ColorExtension extends ThemeExtension<ColorExtension> {
  const ColorExtension({
    required this.primary,
    required this.text,
  });

  final Color primary;
  final Color text;

  @override
  ThemeExtension<ColorExtension> copyWith({
    Color? primary,
    Color? text,
  }) =>
      ColorExtension(
        primary: primary ?? this.primary,
        text: text ?? this.text,
      );

  @override
  ThemeExtension<ColorExtension> lerp(
    covariant ThemeExtension<ColorExtension>? other,
    double t,
  ) {
    if (other == null || other is! ColorExtension) {
      return this;
    }

    return ColorExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      text: Color.lerp(text, other.text, t)!,
    );
  }
}
