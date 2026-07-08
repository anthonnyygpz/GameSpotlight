import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_constants.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/domain/games/entities/game_entity.dart';
import 'package:gamespotlight/core/providers/games/games_provider.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/game_card.dart';
import 'package:gamespotlight/core/widgets/sidebar_navitation_handler.dart';
import 'package:go_router/go_router.dart';

class UpcomingReleasesScreen extends ConsumerStatefulWidget {
  const UpcomingReleasesScreen({super.key});

  @override
  ConsumerState<UpcomingReleasesScreen> createState() =>
      _UpcomingReleasesScreenState();
}

class _UpcomingReleasesScreenState
    extends ConsumerState<UpcomingReleasesScreen> {
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

  @override
  Widget build(BuildContext context) {
    final gamesAsyncValue = ref.watch(gamesProvider);
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);

    return AsyncUIBuilder(
      asyncValue: gamesAsyncValue,
      builder: (data) {
        final upcomingData = data?.upcoming;
        if (upcomingData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final Map<String, List<GameEntity>> gamesByYear = {};

        for (final game in upcomingData) {
          if (game.releaseDate == null) continue;

          final year = game.releaseDate?.year.toString();

          if (year != null) {
            gamesByYear.putIfAbsent(year, () => []).add(game);
          }
        }

        final rowsConfig = gamesByYear.entries.toList()
          ..sort((a, b) => b.key.compareTo(a.key));

        while (_localRowScrolls.length < rowsConfig.length) {
          _localRowScrolls.add(ScrollController());
        }

        controller.attachControllers(
          _localMainScroll,
          _localRowScrolls,
          hasHero: false,
          rowHeight: 360.0,
        );

        return SidebarNavigationHandler(
          rowItemCounts: rowsConfig.map((e) => e.value.length).toList(),
          onContentSelect: (row, col) {
            final selected = rowsConfig[row].value[col];
            context.push('${AppRoutes.gameDetails}/${selected.id}');
          },
          child: CustomScrollView(
            controller: _localMainScroll,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              ...rowsConfig.asMap().entries.map((entry) {
                final rowIndex = entry.key;
                final yearTitle = entry.value.key;
                final gamesInYear = entry.value.value;

                final safeController = _localRowScrolls[rowIndex];

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'LANZAMIENTOS $yearTitle',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: AppConstants.cardHeight,
                          child: ListView.builder(
                            controller: safeController,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            clipBehavior: Clip.none,
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 64.0,
                            ),
                            itemExtent: AppConstants.cardWidth,
                            itemCount: gamesInYear.length,
                            itemBuilder: (context, colIndex) {
                              final game = gamesInYear[colIndex];
                              final isFocused =
                                  state.row == rowIndex &&
                                  state.col == colIndex;

                              return GameCard(
                                item: game,
                                width: AppConstants.cardScrollExtent - 12.0,
                                height: AppConstants.cardHeight,
                                isFocused: isFocused,
                                showPlayButton: false,
                                showDate: false,
                                showBadgeTop: false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        );
      },
    );
  }
}
