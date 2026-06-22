import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/app_routes.dart';
import 'package:game_tv/core/providers/games/games_provider.dart';
import 'package:game_tv/core/providers/navigation/navigation_notifier.dart';
import 'package:game_tv/core/widgets/base_scaffold.dart';
import 'package:game_tv/core/widgets/content_row.dart';
import 'package:game_tv/features/home/models/game_item.dart';
import 'package:game_tv/features/home/views/widgets/hero_banner.dart';
import 'package:go_router/go_router.dart';

class _RowConfig {
  final String title;
  final List<GameItem> items;
  final String? targetRoute;
  final bool showDate;
  final bool showBadgeTop;

  _RowConfig({
    required this.title,
    required this.items,
    this.targetRoute,
    this.showDate = false,
    this.showBadgeTop = false,
  });

  bool get hasTrailingAction => targetRoute != null;
  int get totalCount => hasTrailingAction ? items.length + 1 : items.length;
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final groupedGames = ref.watch(groupedgamesProvider);
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);

    final rowsConfig = [
      _RowConfig(title: 'HERO', items: groupedGames['hero'] ?? []),
      _RowConfig(title: 'TRAILERS', items: groupedGames['trailers'] ?? []),
      _RowConfig(
        title: 'PRÓXIMOS LANZAMIENTOS',
        items: groupedGames['upcoming'] ?? [],
        targetRoute: AppRoutes.upcomingReleases,
        showDate: true,
      ),
      _RowConfig(
        title: 'MEJOR VALORADOS',
        items: groupedGames['top_rated'] ?? [],
        showBadgeTop: true,
      ),
      _RowConfig(
        title: 'NUEVOS LANZAMIENTOS',
        items: groupedGames['new_releases'] ?? [],
      ),
    ];

    return BaseScaffold(
      rowItemCounts: rowsConfig.map((r) => r.totalCount).toList(),
      onContentSelect: (row, col) {
        final config = rowsConfig[row];

        // Intercepción polimórfica: Navegación instantánea al llegar al final
        if (config.hasTrailingAction && col == config.items.length) {
          controller.resetPosition();

          context.push(config.targetRoute!);
          return;
        }

        // Selección estándar indexada por matriz sin condicionales
        final selected = config.items[col];
        context.push('${AppRoutes.gameDetails}/${selected.id}');
      },
      child: CustomScrollView(
        controller: controller.mainScroll,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          ...rowsConfig.asMap().entries.map((entry) {
            final rowIndex = entry.key;
            final config = entry.value;

            // Fila 0: Tratamiento exclusivo del Banner principal
            if (rowIndex == 0) {
              return SliverToBoxAdapter(
                child: HeroBanner(
                  currentIndex: state.heroSlideIndex,
                  isFocused: state.row == 0 && state.col >= 0,
                  heroSlides: config.items,
                ),
              );
            }

            final scrollIndex = rowIndex - 1;
            final safeController = scrollIndex < controller.rowScrolls.length
                ? controller.rowScrolls[scrollIndex]
                : ScrollController();

            // Renderizado automatizado basado en la configuración del mapa
            return SliverToBoxAdapter(
              child: ContentRow(
                title: config.title,
                items: config.items,
                cardWidth: 210,
                cardHeight: 120,
                showDate: config.showDate,
                showBadgeTop: config.showBadgeTop,
                trailingLabel: config.hasTrailingAction ? 'VER TODOS' : null,
                focusedCol: state.row == rowIndex ? state.col : -1,
                scrollController: safeController,
              ),
            );
          }),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
