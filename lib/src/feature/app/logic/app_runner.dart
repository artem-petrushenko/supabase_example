import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:supabase_example/src/feature/app/widget/app.dart';
import 'package:supabase_example/src/feature/initialization/logic/composition_root.dart';
import 'package:supabase_example/src/feature/initialization/widget/initialization_failed_app.dart';

final class AppRunner {
  const AppRunner();

  /// Start the initialization and in case of success run application
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    debugRepaintRainbowEnabled = false;

    binding.deferFirstFrame();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // FlutterError.onError = (details) => Logger.handle(details.exception, details.stack);
    // WidgetsBinding.instance.platformDispatcher.onError = Logger.logPlatformDispatcherError;

    const initializationProcessor = CompositionRoot();
    Future<void> initializeAndRun() async {
      try {
        final result = await initializationProcessor.compose();

        binding.allowFirstFrame();

        runApp(App(result: result));
      } catch (e, stackTrace) {
        runApp(
          InitializationFailedApp(
            error: e,
            stackTrace: stackTrace,
            retryInitialization: initializeAndRun,
          ),
        );
      }
    }

    await initializeAndRun();
  }
}
