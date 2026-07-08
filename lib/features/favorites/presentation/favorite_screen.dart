import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_constants.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/domain/games/entities/game_entity.dart';
import 'package:gamespotlight/core/providers/favorites/favorites_provider.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/game_card.dart';
import 'package:gamespotlight/core/widgets/sidebar_navitation_handler.dart';
import 'package:go_router/go_router.dart';

const _gridCrossAxisCount = 5;

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  final ScrollController _localMainScroll = ScrollController();
  final List<ScrollController> _localRowScrolls = [];

  @override
  void dispose() {
    _localMainScroll.dispose();
    for (final controller in _localRowScrolls) {
      controller.dispose();
    }
    super.dispose();
  }

  List<int> _computeGridRowCounts(int totalItems, int crossAxisCount) {
    if (totalItems == 0) return [0];
    final rowCount = (totalItems / crossAxisCount).ceil();
    return List.generate(rowCount, (row) {
      final remaining = totalItems - row * crossAxisCount;
      return remaining >= crossAxisCount ? crossAxisCount : remaining;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesAsyncValue = ref.watch(favoritesProvider);
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);

    return Scaffold(
      body: AsyncUIBuilder(
        asyncValue: favoritesAsyncValue,
        builder: (data) {
          final totalItems = data?.length ?? 0;
          final rowItemCounts = _computeGridRowCounts(totalItems, 4);

          controller.attachControllers(
            _localMainScroll,
            _localRowScrolls,
            hasHero: false,
            rowHeight: 360.0,
          );

          return SidebarNavigationHandler(
            rowItemCounts: rowItemCounts,
            onContentSelect: (row, col) {
              final index = row * _gridCrossAxisCount + col;
              if (data == null || index < 0 || index >= data.length) return;
              final selected = data[index];
              context.push('${AppRoutes.gameDetails}/${selected.gameId}');
            },
            child: CustomScrollView(
              controller: _localMainScroll,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'FAVORITOS',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _gridCrossAxisCount,
                          mainAxisExtent: AppConstants.cardHeight,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final favorites = data?[index];
                      if (favorites == null) return const SizedBox.shrink();

                      final int crossAxisCount = 4;
                      final int rowIndex = index ~/ crossAxisCount;
                      final int colIndex = index % crossAxisCount;
                      final isFocused =
                          state.row == rowIndex && state.col == colIndex;

                      final gameEntity = GameEntity(
                        id: favorites.gameId,
                        title: favorites.title,
                        slug: favorites.slug,
                        coverImageUrl: favorites.coverImage,
                        status: favorites.status,
                        genres: favorites.generes,
                      );

                      return GameCard(
                        item: gameEntity,
                        width: double.infinity,
                        height: double.infinity,
                        isFocused: isFocused,
                        showPlayButton: false,
                        showDate: true,
                        showBadgeTop: true,
                        showFavorite: true,
                      );
                    }, childCount: data?.length ?? 0),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          );
        },
      ),
    );
  }
}
