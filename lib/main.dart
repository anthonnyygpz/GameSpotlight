import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/app.dart';
import 'package:gamespotlight/core/providers/auth/token_storage.dart';
import 'package:gamespotlight/core/providers/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        tokenProvider.overrideWith((ref) => prefs.getString('auth_token')),
      ],
      child: App(),
    ),
  );
}
