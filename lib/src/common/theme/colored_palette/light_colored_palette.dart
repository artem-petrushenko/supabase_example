
import 'package:flutter/material.dart';
import 'package:supabase_example/src/common/theme/colored_palette/colored_palette.dart';

class LightColoredPalette implements ColoredPalette {
  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primary =>  Colors.red;

  @override
  Color get text => Colors.black;
}
