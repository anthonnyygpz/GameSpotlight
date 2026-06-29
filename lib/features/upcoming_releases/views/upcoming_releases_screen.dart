import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/app_constants.dart';
import 'package:game_tv/core/constants/app_routes.dart';
import 'package:game_tv/core/domain/games/entities/game_entity.dart';
import 'package:game_tv/core/providers/games/games_provider.dart';
import 'package:game_tv/core/providers/navigation/navigation_notifier.dart';
import 'package:game_tv/core/widgets/async_ui_builder.dart';
import 'package:game_tv/core/widgets/base_scaffold.dart';
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
    final gameAsync = ref.watch(gamesProvider);
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);

    return AsyncUIBuilder(
      asyncValue: gameAsync,
      builder: (games) {
        // 1. Agrupación táctica por Año
        final Map<String, List<GameEntity>> gamesByYear = {};

        for (final game in games) {
          if (game.fechaLanzamiento == null || game.fechaLanzamiento!.isEmpty)
            continue;

          // Extraer solo el año de la fecha (Ej: "2023-08-03" -> "2023")
          final year = DateTime.tryParse(
            game.fechaLanzamiento!,
          )?.year.toString();

          if (year != null) {
            gamesByYear.putIfAbsent(year, () => []).add(game);
          }
        }

        // 2. Ordenar los años de más reciente a más antiguo
        final rowsConfig = gamesByYear.entries.toList()
          ..sort((a, b) => b.key.compareTo(a.key));

        // 3. Preparar los controladores de scroll
        while (_localRowScrolls.length < rowsConfig.length) {
          _localRowScrolls.add(ScrollController());
        }

        controller.attachControllers(
          _localMainScroll,
          _localRowScrolls,
          hasHero: false,
          rowHeight: 360.0, // Ajuste vertical optimizado
        );

        return BaseScaffold(
          rowItemCounts: rowsConfig.map((e) => e.value.length).toList(),
          onContentSelect: (row, col) {
            final selected = rowsConfig[row].value[col];
            context.push('${AppRoutes.gameDetails}/${selected.idJuego}');
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
                          height: 280,
                          child: ListView.builder(
                            controller: safeController,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            clipBehavior: Clip.none,
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 64.0,
                            ),
                            itemExtent: AppConstants.cardScrollExtent,
                            itemCount: gamesInYear.length,
                            itemBuilder: (context, colIndex) {
                              final game = gamesInYear[colIndex];
                              final isFocused =
                                  state.row == rowIndex &&
                                  state.col == colIndex;

                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: TvGameCard(
                                  game: game,
                                  isFocused: isFocused,
                                ),
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

class TvGameCard extends StatelessWidget {
  final GameEntity game; // Tipado fuerte aplicado
  final bool isFocused;

  const TvGameCard({super.key, required this.game, required this.isFocused});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFocused ? const Color(0xff6a1b9a) : Colors.transparent,
          width: 3,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: const Color(0xff6a1b9a).withValues(alpha: 0.5),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                game.imagenPortada ?? '', // Renderiza la portada real
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(color: Colors.grey[900]),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xff3f51b5).withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  game.fechaLanzamiento ??
                      'TBA', // Muestra la fecha en lugar de N/A
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              bottom: 12,
              right: 12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          game.titulo.toUpperCase(), // Propiedad corregida
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Icon(
                              Icons.videogame_asset,
                              size: 14,
                              color: Colors.white54,
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.hd, size: 14, color: Colors.white54),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white30, width: 1),
                      color: Colors.black,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
