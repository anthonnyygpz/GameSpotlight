import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/menu_items.dart';
import 'package:game_tv/core/providers/navigation/navigation_notifier.dart';
import 'package:game_tv/core/theme/app_colors.dart';
import 'package:game_tv/core/widgets/sidebar.dart';
import 'package:go_router/go_router.dart';

class BaseScaffold extends ConsumerStatefulWidget {
  final Widget child;
  final List<int> rowItemCounts;
  final void Function(int row, int col)? onContentSelect;

  const BaseScaffold({
    super.key,
    required this.child,
    required this.rowItemCounts,
    this.onContentSelect,
  });

  @override
  ConsumerState<BaseScaffold> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<BaseScaffold> {
  KeyEventResult _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;
    final state = ref.watch(navigationProvider);
    final controller = ref.read(navigationProvider.notifier);

    if (key == LogicalKeyboardKey.arrowDown) {
      controller.moveRow(1, widget.rowItemCounts);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowUp) {
      controller.moveRow(-1, widget.rowItemCounts);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowRight) {
      controller.moveCol(1, widget.rowItemCounts);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft) {
      controller.moveCol(-1, widget.rowItemCounts);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.select || key == LogicalKeyboardKey.enter) {
      if (state.col == -1) {
        controller.syncActiveRoute();
        context.go(globalNavItems[state.navIndex].route);
      } else {
        if (widget.onContentSelect != null) {
          widget.onContentSelect!(state.row, state.col);
        }
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final navIndex = ref.watch(navigationProvider.select((s) => s.navIndex));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        autofocus: true,
        onKeyEvent: (event) => _handleKey(event),
        child: Row(
          children: [
            // Sidebar
            RepaintBoundary(child: Sidebar(selectedIndex: navIndex)),
            // Contenido
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
