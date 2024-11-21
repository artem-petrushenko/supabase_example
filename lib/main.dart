import 'dart:async';

import 'package:supabase_example/src/feature/app/logic/app_runner.dart';

void main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      (e, st) {},
    );
