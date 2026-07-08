import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/constants/menu_items.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/widgets/d_pad.dart';
import 'package:go_router/go_router.dart';

class SidebarNavigationHandler extends ConsumerWidget {
  const SidebarNavigationHandler({
    super.key,
    required this.child,
    required this.rowItemCounts,
    this.onContentSelect,
    this.autofocus = true,
  });

  final Widget child;
  final List<int> rowItemCounts;
  final void Function(int row, int col)? onContentSelect;
  final bool autofocus;

  KeyEventResult _handle(
    BuildContext context,
    WidgetRef ref,
    DPadAction action,
  ) {
    final controller = ref.read(navigationProvider.notifier);
    final state = ref.read(navigationProvider);

    switch (action) {
      case DPadAction.down:
        controller.moveRow(1, rowItemCounts);
        return KeyEventResult.handled;
      case DPadAction.up:
        controller.moveRow(-1, rowItemCounts);
        return KeyEventResult.handled;
      case DPadAction.right:
        controller.moveCol(1, rowItemCounts);
        return KeyEventResult.handled;
      case DPadAction.left:
        controller.moveCol(-1, rowItemCounts);
        return KeyEventResult.handled;
      case DPadAction.select:
        if (state.col == -1) {
          controller.syncActiveRoute();
          context.go(globalNavItems[state.navIndex].route);
        } else {
          onContentSelect?.call(state.row, state.col);
        }
        return KeyEventResult.handled;
      case DPadAction.back:
        return KeyEventResult
            .ignored; // deja que el sistema/back nativo lo maneje
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DPadListener(
      autofocus: autofocus,
      onAction: (action) => _handle(context, ref, action),
      child: child,
    );
  }
}
