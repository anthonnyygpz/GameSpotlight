import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_constants.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/domain/genres/entities/genres_entity.dart';
import 'package:gamespotlight/core/providers/genres/genres_provider.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/genre_card.dart';
import 'package:gamespotlight/core/widgets/sidebar_navitation_handler.dart';
import 'package:go_router/go_router.dart';

const _gridCrossAxisCount = 5;

class GenresScreen extends ConsumerStatefulWidget {
  const GenresScreen({super.key});

  @override
  ConsumerState<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends ConsumerState<GenresScreen> {
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
    final genresAsyncValue = ref.watch(genresProvider);
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);

    return Scaffold(
      body: AsyncUIBuilder(
        asyncValue: genresAsyncValue,
        builder: (data) {
          final totalItems = data?.length ?? 0;
          final rowItemCounts = _computeGridRowCounts(
            totalItems,
            _gridCrossAxisCount,
          );

          controller.attachControllers(
            _localMainScroll,
            _localRowScrolls,
            hasHero: false,
            rowHeight: 360.0,
            isGrid: true,
          );

          return SidebarNavigationHandler(
            rowItemCounts: rowItemCounts,
            onContentSelect: (row, col) {
              final index = row * _gridCrossAxisCount + col;
              if (data == null || index < 0 || index >= data.length) return;
              final selected = data[index];
              context.push(AppRoutes.gameGenrePath(selected.id));
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
                      'GENEROS DE JUEGOS',
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
                      final genres = data?[index];
                      if (genres == null) return const SizedBox.shrink();

                      final int rowIndex = index ~/ _gridCrossAxisCount;
                      final int colIndex = index % _gridCrossAxisCount;
                      final isFocused =
                          state.row == rowIndex && state.col == colIndex;

                      final gameEntity = GenreEntity(
                        id: genres.id,
                        name: genres.name,
                        description: genres.description,
                        iconUrl: genres.iconUrl,
                      );

                      return GenreCard(
                        item: gameEntity,
                        width: double.infinity,
                        height: double.infinity,
                        isFocused: isFocused,
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
