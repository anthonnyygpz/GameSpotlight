import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/app_constants.dart';
import 'package:game_tv/core/constants/app_routes.dart';
import 'package:game_tv/core/models/row_data.dart';
import 'package:game_tv/core/providers/navigation/navigation_notifier.dart';
import 'package:game_tv/core/providers/navigation/navigation_state.dart';
import 'package:game_tv/core/widgets/base_scaffold.dart';
import 'package:game_tv/core/widgets/content_row.dart';
import 'package:go_router/go_router.dart';

class GameContentScreen extends ConsumerStatefulWidget {
  const GameContentScreen({
    super.key,
    required this.rowsConfig,
    this.headerSliver,
    this.headerSliverRowIndex = -1,
    this.cardWidth = AppConstants.cardWidth,
    this.cardHeight = AppConstants.cardHeight,
  });

  final List<RowData> rowsConfig;
  final Widget? headerSliver;
  final int headerSliverRowIndex;
  final double cardWidth;
  final double cardHeight;

  @override
  ConsumerState<GameContentScreen> createState() => _GameContentScreenState();
}

class _GameContentScreenState extends ConsumerState<GameContentScreen> {
  late final ScrollController _mainScroll;
  late final List<ScrollController> _rowScrolls;

  @override
  void initState() {
    super.initState();
    _mainScroll = ScrollController();
    _rowScrolls = List.generate(
      widget.rowsConfig.length,
      (_) => ScrollController(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(navigationProvider.notifier)
          .attachControllers(_mainScroll, _rowScrolls);
    });
  }

  @override
  void didUpdateWidget(covariant GameContentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rowsConfig.length != widget.rowsConfig.length) {
      for (final c in _rowScrolls) {
        c.dispose();
      }
      _rowScrolls
        ..clear()
        ..addAll(
          List.generate(widget.rowsConfig.length, (_) => ScrollController()),
        );
      ref
          .read(navigationProvider.notifier)
          .attachControllers(_mainScroll, _rowScrolls);
    }
  }

  @override
  void dispose() {
    _mainScroll.dispose();
    for (final c in _rowScrolls) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(navigationProvider);
    final notifier = ref.read(navigationProvider.notifier);

    return BaseScaffold(
      rowItemCounts: widget.rowsConfig.map((r) => r.totalCount).toList(),
      onContentSelect: (row, col) => _handleSelect(row, col, notifier),
      child: CustomScrollView(
        controller: _mainScroll,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          ..._buildSlivers(state),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  void _handleSelect(int row, int col, NavigationNotifier notifier) {
    final config = widget.rowsConfig[row];

    if (config.hasTrailingAction && col == config.items.length) {
      notifier.resetPosition();
      context.push(config.targetRoute!);
      return;
    }

    final selected = config.items[col];
    context.push('${AppRoutes.gameDetails}/${selected.id}');
  }

  Iterable<Widget> _buildSlivers(NavigationState state) {
    return widget.rowsConfig.asMap().entries.map((entry) {
      final rowIndex = entry.key;
      final config = entry.value;

      if (rowIndex == widget.headerSliverRowIndex &&
          widget.headerSliver != null) {
        return SliverToBoxAdapter(child: widget.headerSliver!);
      }

      return SliverToBoxAdapter(
        child: ContentRow(
          title: config.title,
          items: config.items,
          cardWidth: widget.cardWidth,
          cardHeight: widget.cardHeight,
          showDate: config.showDate,
          showBadgeTop: config.showBadgeTop,
          trailingLabel: config.hasTrailingAction ? 'VER TODOS' : null,
          focusedCol: state.row == rowIndex ? state.col : -1,
          scrollController: _rowScrollController(rowIndex),
        ),
      );
    });
  }

  ScrollController _rowScrollController(int rowIndex) {
    final scrollIndex = widget.headerSliverRowIndex >= 0
        ? rowIndex - 1
        : rowIndex;
    if (scrollIndex < 0 || scrollIndex >= _rowScrolls.length) {
      return ScrollController();
    }
    return _rowScrolls[scrollIndex];
  }
}
