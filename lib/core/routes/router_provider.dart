import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/providers/dio_client.dart';
import 'package:gamespotlight/core/widgets/shell_route.dart';
import 'package:gamespotlight/features/auth/views/auth_screen.dart';
import 'package:gamespotlight/features/exclusive_trailers/views/exclusive_trailers_screen.dart';
import 'package:gamespotlight/features/favorites/presentation/favorite_screen.dart';
import 'package:gamespotlight/features/game_details/views/game_details_screen.dart';
import 'package:gamespotlight/features/genres/presentation/game_genre_screen.dart';
import 'package:gamespotlight/features/genres/presentation/genres_screen.dart';
import 'package:gamespotlight/features/home/presentation/home_screen.dart';
import 'package:gamespotlight/features/settings/presentation/edit_profile_screen.dart';
import 'package:gamespotlight/features/settings/presentation/settings_screen.dart';
import 'package:gamespotlight/features/upcoming_releases/views/upcoming_releases_screen.dart';
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
        path: '${AppRoutes.gameDetails}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return GameDetailsScreen(id: id);
        },
      ),

      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.gameGenre}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return GameGenreScreen(id: id);
        },
      ),

      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.upcomingReleases,
            builder: (context, state) => const UpcomingReleasesScreen(),
          ),
          GoRoute(
            path: AppRoutes.exclusiveTrailers,
            builder: (context, state) => const ExclusiveTrailersScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.favorites,
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            path: AppRoutes.genres,
            builder: (context, state) => const GenresScreen(),
          ),
        ],
      ),
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
