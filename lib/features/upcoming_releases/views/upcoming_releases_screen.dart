import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/trailer_game.dart';
import 'package:game_tv/core/providers/navigation/navigation_notifier.dart';
import 'package:game_tv/core/widgets/base_scaffold.dart';
import 'package:game_tv/core/widgets/content_row.dart';

class UpcomingReleasesScreen extends ConsumerWidget {
  const UpcomingReleasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);

    return BaseScaffold(
      rowItemCounts: [globalTrailerGames.length],
      child: CustomScrollView(
        controller: controller.mainScroll,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ContentRow(
              title: 'PRÓXIMOS LANZAMIENTOS',
              items: globalTrailerGames,
              cardWidth: 360,
              cardHeight: 320,
              focusedCol: state.row == 0 ? state.col : -1,
              scrollController: controller.rowScrolls[0],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
