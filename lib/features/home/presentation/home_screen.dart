import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/domain/games/entities/game_entity.dart';
import 'package:gamespotlight/core/domain/games/entities/game_response_entity.dart';
import 'package:gamespotlight/core/models/content_section.dart';
import 'package:gamespotlight/core/models/row_data.dart';
import 'package:gamespotlight/core/providers/games/games_provider.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/game_content_screen.dart';
import 'package:gamespotlight/core/widgets/loading_expressive.dart';
import 'package:gamespotlight/features/home/presentation/widgets/hero_banner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsyncValue = ref.watch(gamesProvider);

    return AsyncUIBuilder(
      asyncValue: gamesAsyncValue,
      builder: (games) {
        if (games == null) {
          return const Scaffold(body: LoadingExpressive());
        }

        return _HomeContent(games: games);
      },
    );
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.games});

  final DataGame games;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);
    final heroGames = games.hero;
    final safeHeroIndex = _computeSafeHeroIndex(
      heroGames: heroGames,
      rawIndex: navigationState.heroSlideIndex,
    );

    ref.listen(gamesProvider, ((previous, next) {
      final data = next.asData?.value;
      if (data != null) {
        _precacheHeroImages(context, data.hero);
      }
    }));

    final sections = [
      HeaderSection(
        widget: HeroBanner(
          currentIndex: safeHeroIndex,
          isFocused: navigationState.row == 0 && navigationState.col >= 0,
          heroSlides: heroGames,
        ),
        data: RowData(title: 'HERO', items: games.hero),
      ),
      RowSection(RowData(title: 'TRAILERS', items: games.trailers)),
      RowSection(
        RowData(
          title: 'PROXIMOS LANZAMIENTOS',
          items: games.upcoming.take(5).toList(),
          targetRoute: AppRoutes.upcomingReleases,
        ),
      ),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheHeroImages(context, games.hero);
    });

    return GameContentScreen(sections: sections);
  }

  int _computeSafeHeroIndex({
    required List<GameEntity> heroGames,
    required int rawIndex,
  }) {
    if (heroGames.isEmpty) return 0;
    return rawIndex.clamp(0, heroGames.length - 1);
  }

  void _precacheHeroImages(BuildContext context, List<GameEntity> heroGames) {
    for (final game in heroGames) {
      precacheImage(CachedNetworkImageProvider(game.bannerUrl ?? ''), context);
    }
  }
}
