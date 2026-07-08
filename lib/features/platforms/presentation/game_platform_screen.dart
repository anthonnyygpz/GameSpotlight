import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_constants.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/domain/games/entities/game_entity.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/providers/platforms/platforms_provider.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/game_card.dart';
import 'package:gamespotlight/core/widgets/sidebar_navitation_handler.dart';
import 'package:gamespotlight/core/widgets/tv_button.dart';
import 'package:go_router/go_router.dart';

const _gridCrossAxisCount = 5;

class GamePlatformScreen extends ConsumerStatefulWidget {
  const GamePlatformScreen({super.key, this.id});

  final String? id;

  @override
  ConsumerState<GamePlatformScreen> createState() => _GameGenreScreenState();
}

class _GameGenreScreenState extends ConsumerState<GamePlatformScreen> {
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
    if (widget.id == null) return const SizedBox.shrink();
    final platformAsyncValue = ref.watch(gamePlatformsProvider(widget.id!));
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);

    return Scaffold(
      body: AsyncUIBuilder(
        asyncValue: platformAsyncValue,
        builder: (data) {
          final totalItems = data?.length ?? 0;
          final gameRows = _computeGridRowCounts(
            totalItems,
            _gridCrossAxisCount,
          );
          final rowItemCounts = [1, ...gameRows];

          controller.attachControllers(
            _localMainScroll,
            _localRowScrolls,
            hasHero: false,
            rowHeight: 360.0,
          );
          final isBackButtonFocused = state.row == 0 && state.col == 0;

          return SidebarNavigationHandler(
            rowItemCounts: rowItemCounts,
            onContentSelect: (row, col) {
              if (row == 0) {
                context.pop();
                return;
              }

              final index = (row - 1) * _gridCrossAxisCount + col;
              if (data == null || index < 0 || index >= data.length) return;

              final selected = data[index];
              context.push(AppRoutes.gameDetailsPath(selected.gameId));
            },
            child: CustomScrollView(
              controller: _localMainScroll,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        TvButton.ghost(
                          icon: Icons.arrow_back_ios_rounded,
                          onPressed: () => context.pop(),
                          isFocusedOverride: isBackButtonFocused,
                        ),

                        Text(
                          'JUEGOS DE ${data?[0].platform.toUpperCase() ?? 'Desconocido'}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 30)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _gridCrossAxisCount,
                          mainAxisExtent: AppConstants.cardHeight,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final platforms = data?[index];
                      if (platforms == null) return const SizedBox.shrink();

                      final int rowIndex = (index ~/ _gridCrossAxisCount) + 1;
                      final int colIndex = index % _gridCrossAxisCount;
                      final isFocused =
                          state.row == rowIndex && state.col == colIndex;

                      final gameEntity = GameEntity(
                        id: platforms.gameId,
                        title: platforms.title,
                        coverImageUrl: platforms.coverImage,
                        status: platforms.status!,
                      );

                      return GameCard(
                        item: gameEntity,
                        width: double.infinity,
                        height: double.infinity,
                        isFocused: isFocused,
                        showPlayButton: true,
                        showDate: true,
                        showBadgeTop: true,
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
