import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/providers/navigation/navigation_notifier.dart';
import 'package:gamespotlight/core/widgets/sidebar.dart';
import 'package:go_router/go_router.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = GoRouterState.of(context).uri.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ref.read(navigationProvider.notifier).syncWithRoute(route);
      }
    });

    final navIndex = ref.watch(navigationProvider.select((s) => s.navIndex));

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 175,
            child: RepaintBoundary(child: Sidebar(selectedIndex: navIndex)),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
