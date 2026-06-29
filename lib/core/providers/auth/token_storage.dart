import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Clave de almacenamiento ──────────────────────────────────────────────────

const _kTokenKey = 'auth_token';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError(
    'Inicializa sharedPreferencesProvider en main.dart',
  ),
);

// ─── Token storage ────────────────────────────────────────────────────────────

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TokenStorage(prefs);
});

class TokenStorage {
  TokenStorage(this._prefs);

  final SharedPreferences _prefs;

  String? read() => _prefs.getString(_kTokenKey);

  Future<void> save(String token) => _prefs.setString(_kTokenKey, token);

  Future<void> delete() => _prefs.remove(_kTokenKey);
}
