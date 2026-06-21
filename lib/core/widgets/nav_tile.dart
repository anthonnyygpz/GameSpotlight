import 'package:flutter/material.dart';
import 'package:game_tv/core/models/nav_item.dart';
import 'package:game_tv/core/theme/app_colors.dart';

class NavTile extends StatelessWidget {
  final NavItem item;
  final bool isSelected;
  final bool isActive;

  const NavTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              // Mantiene el color primario si está enfocado o es la ruta activa
              color: isActive || isSelected
                  ? AppColors.textPrimary
                  : AppColors.textMuted,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  color: isActive || isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: isActive || isSelected
                      ? FontWeight.w700
                      : FontWeight.w500,
                  letterSpacing: 0.8,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
