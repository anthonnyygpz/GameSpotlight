import 'package:dpad/dpad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/l10n/app_localizations.dart';
import 'package:gamespotlight/core/routes/router_provider.dart';
import 'package:gamespotlight/core/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(routerProvider);

    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // Inglés
        Locale('es', ''), // Español
      ],
      builder: Dpad.wrap(),
      title: "Game TV",
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
