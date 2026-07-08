import 'package:flutter/material.dart';
import 'package:gamespotlight/core/models/nav_item.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: isActive || isSelected
                  ? colorScheme.onPrimary
                  : colorScheme.onTertiary,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  color: isActive || isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onTertiary,
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
