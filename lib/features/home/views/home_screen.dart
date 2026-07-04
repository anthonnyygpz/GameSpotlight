import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/domain/games/entities/game_entity.dart';
import 'package:game_tv/core/domain/games/entities/game_response_entity.dart';
import 'package:game_tv/core/models/row_data.dart';
import 'package:game_tv/core/providers/games/games_provider.dart';
import 'package:game_tv/core/providers/navigation/navigation_notifier.dart';
import 'package:game_tv/core/widgets/async_ui_builder.dart';
import 'package:game_tv/core/widgets/game_content_screen.dart';
import 'package:game_tv/core/widgets/loading_expressive.dart';
import 'package:game_tv/features/home/views/widgets/hero_banner.dart';

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

    final rowsConfig = _buildRowsConfig(
      games.hero,
      games.trailers,
      games.upcoming,
      games.topRated,
    );
    final heroGames = rowsConfig[0].items;
    final safeHeroIndex = _computeSafeHeroIndex(
      heroGames: heroGames,
      rawIndex: navigationState.heroSlideIndex,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheHeroImages(context, games.hero);
    });

    return GameContentScreen(
      rowsConfig: rowsConfig,
      headerSliverRowIndex: 0,
      headerSliver: HeroBanner(
        currentIndex: safeHeroIndex,
        isFocused: navigationState.row == 0 && navigationState.col >= 0,
        heroSlides: heroGames,
      ),
    );
  }

  List<RowData> _buildRowsConfig(
    List<GameEntity> games,
    List<GameEntity> trailers,
    List<GameEntity> upcoming,
    List<GameEntity> topRated,
  ) => [
    RowData(title: 'HERO', items: games.take(5).toList()),
    RowData(title: 'TRAILERS', items: trailers),
    RowData(title: 'PROXIMOS LANZAMIENTOS', items: upcoming),
    RowData(title: 'MEJOR VALORADOS', items: topRated),
  ];

  int _computeSafeHeroIndex({
    required List<GameEntity> heroGames,
    required int rawIndex,
  }) {
    if (heroGames.isEmpty) return 0;
    return rawIndex.clamp(0, heroGames.length - 1);
  }

  void _precacheHeroImages(BuildContext context, List<GameEntity> heroGames) {
    for (final game in heroGames) {
      precacheImage(CachedNetworkImageProvider(game.bannerUrl), context);
    }
  }
}
