import 'package:flutter/material.dart';

import 'package:supabase_example/src/feature/settings/widget/locale/locale_widget.dart';
import 'package:supabase_example/src/feature/settings/widget/text_scale/text_scale_widget.dart';
import 'package:supabase_example/src/feature/settings/widget/text_scale/theme_selector_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          TextScaleWidget(),
          ThemeSelectorWidget(),
          LocaleWidget(),
        ],
      ),
    );
  }
}
