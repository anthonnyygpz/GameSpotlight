import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/app_routes.dart';
import 'package:game_tv/core/providers/dio_client.dart';
import 'package:game_tv/features/auth/views/auth_screen.dart';
import 'package:game_tv/features/home/views/home_screen.dart';
import 'package:go_router/go_router.dart';

const _publicRoutes = {AppRoutes.auth};

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.auth,
    refreshListenable: notifier,
    redirect: (context, state) {
      final token = ref.read(tokenProvider);
      final isAuthenticated = token != null && token.isNotEmpty;
      final isOnPublicRoute = _publicRoutes.contains(state.matchedLocation);

      // Sin sesión intentando entrar a ruta protegida → auth
      if (!isAuthenticated && !isOnPublicRoute) return AppRoutes.auth;

      // Con sesión intentando entrar a auth → home
      if (isAuthenticated && isOnPublicRoute) return AppRoutes.home;

      // Sin redirección necesaria
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      // GoRoute(
      //   path: AppRoutes.upcomingReleases,
      //   builder: (context, state) => const UpcomingReleasesScreen(),
      // ),
      // GoRoute(
      //   path: AppRoutes.exclusiveTrailers,
      //   builder: (context, state) => const ExclusiveTrailersScreen(),
      // ),
      // GoRoute(
      //   path: '${AppRoutes.gameDetails}/:id',
      //   builder: (context, state) {
      //     final id = state.pathParameters['id'];
      //     return GameDetailsScreen(id: id);
      //   },
      // ),
      // GoRoute(
      //   path: AppRoutes.settings,
      //   builder: (context, state) => const SettingsScreen(),
      // ),
    ],
  );
});

// ─── Notifier ─────────────────────────────────────────────────────────────────

/// Escucha cambios en [tokenProvider] y notifica al router para
/// que re-evalúe el redirect automáticamente al login, register o logout.
class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(Ref ref) {
    ref.listen<String?>(tokenProvider, (previous, next) {
      if (previous != next) notifyListeners();
    });
  }
}
