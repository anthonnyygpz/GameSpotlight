import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_constants.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/providers/games/games_provider.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/game_card.dart';
import 'package:gamespotlight/core/widgets/sidebar_navitation_handler.dart';
import 'package:go_router/go_router.dart';

class ExclusiveTrailersScreen extends ConsumerStatefulWidget {
  const ExclusiveTrailersScreen({super.key});

  @override
  ConsumerState<ExclusiveTrailersScreen> createState() =>
      _ExclusiveTrailersScreenState();
}

class _ExclusiveTrailersScreenState
    extends ConsumerState<ExclusiveTrailersScreen> {
  final ScrollController _mainScroll = ScrollController();
  final List<ScrollController> _rowScrolls = [ScrollController()];

  @override
  void dispose() {
    _mainScroll.dispose();
    _rowScrolls[0].dispose();
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
        controller.attachControllers(
          _mainScroll,
          _rowScrolls,
          hasHero: false,
          rowHeight: 360.0,
        );

        return SidebarNavigationHandler(
          rowItemCounts: [data?.exclusives.length ?? 0],
          onContentSelect: (row, col) {
            context.push(
              '${AppRoutes.gameDetails}/${data?.exclusives[col].id}',
            );
          },
          child: CustomScrollView(
            controller: _mainScroll,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'TRÁILERES EXCLUSIVOS',
                          style: TextStyle(
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
                          controller: _rowScrolls[0],
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          clipBehavior: Clip.none,
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 64.0,
                          ),
                          itemExtent: AppConstants.cardWidth,
                          itemCount: data?.exclusives.length,
                          itemBuilder: (context, colIndex) {
                            final game = data?.exclusives[colIndex];
                            final isFocused =
                                state.row == 0 && state.col == colIndex;

                            if (game == null) return const SizedBox();

                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: GameCard(
                                item: game,
                                width: AppConstants.cardScrollExtent - 12.0,
                                height: AppConstants.cardHeight,
                                isFocused: isFocused,
                                showPlayButton: false,
                                showDate: false,
                                showBadgeTop: false,
                              ), // Widget restaurado
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
