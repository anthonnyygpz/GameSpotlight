import 'package:flutter/material.dart';
import 'package:gamespotlight/core/constants/menu_items.dart';
import 'package:gamespotlight/core/widgets/nav_tile.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;

  const Sidebar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    return Container(
      width: 175,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              spacing: 5,
              children: [
                Image.asset('assets/logo.png', width: 36, height: 36),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GAME',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'SPOTLIGHT',
                      style: TextStyle(fontSize: 9, letterSpacing: 2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(globalNavItems.length, (i) {
            return NavTile(
              item: globalNavItems[i],
              isSelected: i == selectedIndex,
              isActive: currentRoute == globalNavItems[i].route,
            );
          }),
        ],
      ),
    );
  }
}
