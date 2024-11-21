import 'dart:ui';

abstract interface class ColoredPalette {
  const ColoredPalette({
    required this.brightness,
    required this.primary,
    required this.text,
  });

  final Brightness brightness;
  final Color primary;
  final Color text;
}
