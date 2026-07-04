import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/domain/games/entities/game_entity.dart';
import 'package:game_tv/core/providers/navigation/navigation_notifier.dart';
import 'package:game_tv/core/widgets/async_ui_builder.dart';
import 'package:game_tv/features/home/providers/home_aggregator_provider.dart';

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
    // final aggregatorAsync = ref.watch(homeAggregatorProvider);
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);
    return Scaffold(body: const Center(child: CircularProgressIndicator()));

    // return AsyncUIBuilder(
    //   asyncValue: aggregatorAsync,
    //   builder: (data) {
    //     return Text('hola');
    // Filtramos SOLO la categoría de Tráileres Exclusivos (ID 4)
    // final exclusiveEntry = data.categorizedGames.entries
    //     .where((entry) => entry.key.idTrailer == '4')
    //     .toList();
    //
    // final exclusiveGames = exclusiveEntry.isNotEmpty
    //     ? exclusiveEntry.first.value
    //     : [];

    controller.attachControllers(
      _mainScroll,
      _rowScrolls,
      hasHero: false,
      rowHeight: 360.0,
    );

    // return BaseScaffold(
    //   rowItemCounts: [exclusiveGames.length],
    //   onContentSelect: (row, col) {
    //     final selected = exclusiveGames[col];
    //     context.push('${AppRoutes.gameDetails}/${selected.idJuego}');
    //   },
    //   child: CustomScrollView(
    //     controller: _mainScroll,
    //     physics: const NeverScrollableScrollPhysics(),
    //     slivers: [
    //       SliverToBoxAdapter(
    //         child: Padding(
    //           padding: const EdgeInsets.only(top: 28.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 20.0),
    //                 child: Text(
    //                   'TRÁILERES EXCLUSIVOS',
    //                   style: TextStyle(
    //                     color: Colors.white70,
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold,
    //                     letterSpacing: 2.0,
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(height: 14),
    //               SizedBox(
    //                 height: 280,
    //                 child: ListView.builder(
    //                   controller: _rowScrolls[0],
    //                   scrollDirection: Axis.horizontal,
    //                   physics: const NeverScrollableScrollPhysics(),
    //                   clipBehavior: Clip.none,
    //                   padding: const EdgeInsets.only(
    //                     left: 20.0,
    //                     right: 64.0,
    //                   ),
    //                   itemExtent: AppConstants.cardScrollExtent,
    //                   itemCount: exclusiveGames.length,
    //                   itemBuilder: (context, colIndex) {
    //                     final game = exclusiveGames[colIndex];
    //                     final isFocused =
    //                         state.row == 0 && state.col == colIndex;
    //
    //                     return Padding(
    //                       padding: const EdgeInsets.only(right: 12.0),
    //                       child: TvGameCard(
    //                         game: game,
    //                         isFocused: isFocused,
    //                       ), // Widget restaurado
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    //   },
    // );
  }
}

// Clase renderizadora para las tarjetas
class TvGameCard extends StatelessWidget {
  final GameEntity game;
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
                // game.imagenPortada ??
                '',
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
                  // game.fechaLanzamiento ??
                  'TBA',
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
                          // game.titulo.toUpperCase(),
                          '',
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
