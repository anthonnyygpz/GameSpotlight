import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/app_routes.dart';
import 'package:game_tv/features/auth/views/auth_screen.dart';
import 'package:game_tv/features/game_details/views/game_details_screen.dart';
import 'package:game_tv/features/home/views/home_screen.dart';
import 'package:game_tv/features/upcoming_releases/views/upcoming_releases_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    // refreshListenable: _AuthNotifierListenable(ref),
    // redirect: (context, state) {
    //   final authState = ref.read(authProvider);
    //   final location = state.matchedLocation;
    //
    //   final isOnSplash = location == AppRoutes.splash;
    //   final isOnAuth = location == AppRoutes.auth;
    //
    //   // 1. Manejar usuarios autenticados
    //   if (authState.isAuthenticated) {
    //     // Si está en login, register o splash, mandarlo al home
    //     if (isOnAuth || isOnSplash) return AppRoutes.home;
    //     // En cualquier otro caso, permitir navegación
    //     return null;
    //   }
    //
    //   // 2. Manejar usuarios NO autenticados o con correo pendiente
    //   if (authState.isUnauthenticated || authState.isEmailNotConfirmed) {
    //     // Si intenta ir a una ruta protegida (que no sea splash o auth), mandarlo al login
    //     if (!isOnSplash && !isOnAuth) return AppRoutes.auth;
    //   }
    //
    //   return null;
    // },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.upcomingReleases,
        builder: (context, state) => const UpcomingReleasesScreen(),
      ),
      GoRoute(
        path: "${AppRoutes.gameDetails}/:id",
        builder: (context, state) {
          final String? id = state.pathParameters['id'];

          return GameDetailsScreen(id: id);
        },
      ),
      // GoRoute(
      //   path: AppRoutes.selectImageCar,
      //   pageBuilder: (context, state) => TileTransitionPage(
      //     key: state.pageKey,
      //     child: SelectImageCar(),
      //     duration: const Duration(milliseconds: 600),
      //   ),
      // ),
      // GoRoute(
      //   path: AppRoutes.witnesses,
      //   pageBuilder: (context, state) => TileTransitionPage(
      //     key: state.pageKey,
      //     child: const WitnessesPage(),
      //     duration: const Duration(milliseconds: 600),
      //   ),
      // ),
      // GoRoute(
      //   path: AppRoutes.profile,
      //   pageBuilder: (context, state) => TileTransitionPage(
      //     key: state.pageKey,
      //     child: const ProfilePage(),
      //     duration: const Duration(milliseconds: 600),
      //   ),
      // ),
      // GoRoute(
      //   name: AppRoutes.witnessDescription,
      //   path:
      //       '${AppRoutes.witnessDescription}/:name/:image/:description/:description2',
      //   pageBuilder: (context, state) {
      //     final String? name = state.pathParameters['name'];
      //     final String? image = state.pathParameters['image'];
      //     final String? description = state.pathParameters['description'];
      //     final String? description2 = state.pathParameters['description2'];
      //
      //     return TileTransitionPage(
      //       key: state.pageKey,
      //       child: WitnessDescriptionPage(
      //         name: name,
      //         image: image,
      //         description: description,
      //         description2: description2,
      //       ),
      //       duration: const Duration(milliseconds: 600),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: AppRoutes.myAutoInfo,
      //   pageBuilder: (context, state) => TileTransitionPage(
      //     key: state.pageKey,
      //     child: const MyAutoInfoPage(),
      //     duration: const Duration(milliseconds: 600),
      //   ),
      // ),
    ],
  );
});

// class _AuthNotifierListenable extends ChangeNotifier {
//   _AuthNotifierListenable(Ref ref) {
//     // Cada vez que authProvider cambie, notifica a GoRouter
//     ref.listen<AuthState>(authProvider, (previous, next) {
//       if (previous?.status != next.status) {
//         notifyListeners();
//       }
//     });
//   }
// }
