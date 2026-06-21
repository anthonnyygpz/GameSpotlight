import 'package:flutter/material.dart';
import 'package:game_tv/core/theme/app_colors.dart';

class StaticButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;

  const StaticButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isPrimary ? 20 : 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: isPrimary
            ? AppColors.accent
            : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: isPrimary ? null : Border.all(color: AppColors.textMuted),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
