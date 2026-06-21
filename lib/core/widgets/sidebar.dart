import 'package:flutter/material.dart';
import 'package:game_tv/core/constants/menu_items.dart';
import 'package:game_tv/core/theme/app_colors.dart';
import 'package:game_tv/core/widgets/nav_tile.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  // final ValueChanged<int> onSelect;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    // required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      color: AppColors.background,
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
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'SPOTLIGHT',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 9,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(globalNavItems.length, (i) {
            final String currentRoute = GoRouter.of(
              context,
            ).routerDelegate.currentConfiguration.uri.toString();

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
