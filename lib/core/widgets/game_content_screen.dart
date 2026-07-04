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
  late List<ScrollController> _rowScrolls;

  List<RowData> _validRows = [];
  int _validHeaderIndex = -1;

  @override
  void initState() {
    super.initState();
    _mainScroll = ScrollController();
    _updateValidRows();
    _initScrolls();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(navigationProvider.notifier)
          .attachControllers(_mainScroll, _rowScrolls);
    });
  }

  void _updateValidRows() {
    _validRows = [];
    _validHeaderIndex = -1;

    for (int i = 0; i < widget.rowsConfig.length; i++) {
      final config = widget.rowsConfig[i];
      final isHeader = i == widget.headerSliverRowIndex;

      if (config.items.isNotEmpty || isHeader) {
        if (isHeader) {
          _validHeaderIndex = _validRows.length;
        }
        _validRows.add(config);
      }
    }
  }

  void _initScrolls() {
    _rowScrolls = List.generate(_validRows.length, (_) => ScrollController());
  }

  @override
  void didUpdateWidget(covariant GameContentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldLength = _validRows.length;

    _updateValidRows();

    if (oldLength != _validRows.length) {
      for (final c in _rowScrolls) {
        c.dispose();
      }
      _initScrolls();
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
      // Pasamos estrictamente las filas válidas
      rowItemCounts: _validRows.map((r) => r.totalCount).toList(),
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
    final config = _validRows[row];

    if (config.hasTrailingAction && col == config.items.length) {
      notifier.resetPosition();
      context.push(config.targetRoute!);
      return;
    }

    final selected = config.items[col];
    context.push('${AppRoutes.gameDetails}/${selected.id}');
  }

  Iterable<Widget> _buildSlivers(NavigationState state) {
    return _validRows.asMap().entries.map((entry) {
      final rowIndex = entry.key;
      final config = entry.value;

      if (rowIndex == _validHeaderIndex && widget.headerSliver != null) {
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
    final scrollIndex = _validHeaderIndex >= 0 ? rowIndex - 1 : rowIndex;
    if (scrollIndex < 0 || scrollIndex >= _rowScrolls.length) {
      return ScrollController();
    }
    return _rowScrolls[scrollIndex];
  }
}
