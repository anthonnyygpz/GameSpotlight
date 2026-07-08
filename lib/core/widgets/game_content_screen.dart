import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/app_constants.dart';
import 'package:gamespotlight/core/constants/app_routes.dart';
import 'package:gamespotlight/core/models/content_section.dart';
import 'package:gamespotlight/core/models/row_data.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_state.dart';
import 'package:gamespotlight/core/utils/row_scroll_controllers.dart';
import 'package:gamespotlight/core/widgets/content_row.dart';
import 'package:gamespotlight/core/widgets/sidebar_navitation_handler.dart';
import 'package:go_router/go_router.dart';

class GameContentScreen extends ConsumerStatefulWidget {
  const GameContentScreen({
    super.key,
    required this.sections,
    this.cardWidth = AppConstants.cardWidth,
    this.cardHeight = AppConstants.cardHeight,
  });

  final List<ContentSection> sections;
  final double cardWidth;
  final double cardHeight;

  @override
  ConsumerState<GameContentScreen> createState() => _GameContentScreenState();
}

class _GameContentScreenState extends ConsumerState<GameContentScreen> {
  late final ScrollController _mainScroll;
  late RowScrollControllers _rowScrolls;
  late List<ContentSection> _visible;

  final List<RowData> _validRows = [];

  @override
  void initState() {
    super.initState();
    _mainScroll = ScrollController();
    _visible = visibleSections(widget.sections);
    _rowScrolls = RowScrollControllers(_visible.length);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(navigationProvider.notifier)
          .attachControllers(_mainScroll, _rowScrolls.all);
    });
  }

  @override
  void didUpdateWidget(covariant GameContentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldLength = _validRows.length;
    _visible = visibleSections(widget.sections);

    if (oldLength != _validRows.length) {
      _rowScrolls.disposeAll();
      _rowScrolls = RowScrollControllers(_visible.length);
      ref
          .read(navigationProvider.notifier)
          .attachControllers(_mainScroll, _rowScrolls.all);
    }
  }

  @override
  void dispose() {
    _mainScroll.dispose();
    _rowScrolls.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(navigationProvider);
    final notifier = ref.read(navigationProvider.notifier);

    notifier.attachControllers(
      _mainScroll,
      _rowScrolls.all,
      hasHero: true,
      rowHeight: 185.0,
      heroHeight: 320.0,
    );

    return SidebarNavigationHandler(
      rowItemCounts: _visible.map((s) => s.data.totalCount).toList(),
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
    if (row < 0 || row >= _visible.length) return;

    final section = _visible[row];
    final data = section.data;

    if (data.items.isEmpty) return;

    if (section is HeaderSection) {
      final safeIndex = (col >= 0 && col < data.items.length) ? col : 0;
      final heroGame = data.items[safeIndex];

      context.push(AppRoutes.gameDetailsPath(heroGame.id));
      return;
    }

    if (col == data.items.length) {
      if (data.targetRoute != null) {
        notifier.resetPosition();
        context.push(data.targetRoute!);
      }
      return;
    }

    if (col >= 0 && col < data.items.length) {
      final selectedGame = data.items[col];
      context.push(AppRoutes.gameDetailsPath(selectedGame.id));
    }
  }

  Iterable<Widget> _buildSlivers(NavigationState state) {
    return _visible.asMap().entries.map((entry) {
      final rowIndex = entry.key;
      final section = entry.value;

      return switch (section) {
        HeaderSection(widget: final headerWidget) => SliverToBoxAdapter(
          child: headerWidget,
        ),
        RowSection(data: final data) => SliverToBoxAdapter(
          child: ContentRow(
            title: data.title,
            items: data.items,
            cardWidth: widget.cardWidth,
            cardHeight: widget.cardHeight,
            showDate: data.showDate,
            showBadgeTop: data.showBadgeTop,
            trailingLabel: data.hasTrailingAction ? 'VER TODOS' : null,
            focusedCol: state.row == rowIndex ? state.col : -1,
            scrollController: _rowScrolls.forRow(rowIndex),
          ),
        ),
      };
    });
  }
}
