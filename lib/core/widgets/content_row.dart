import 'package:flutter/material.dart';
import 'package:game_tv/core/theme/app_colors.dart';
import 'package:game_tv/core/widgets/game_card.dart';
import 'package:game_tv/features/home/models/game_item.dart';

class ContentRow extends StatelessWidget {
  final String title;
  final List<GameItem> items;
  final double cardWidth;
  final double cardHeight;
  final bool showPlayButton;
  final bool showDate;
  final bool showBadgeTop;
  final String? trailingLabel;
  final int focusedCol;
  final ScrollController scrollController;

  const ContentRow({
    super.key,
    required this.title,
    required this.items,
    required this.cardWidth,
    required this.cardHeight,
    required this.focusedCol,
    required this.scrollController,
    this.showPlayButton = false,
    this.showDate = false,
    this.showBadgeTop = false,
    this.trailingLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 3,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(),
                if (trailingLabel != null)
                  Text(
                    trailingLabel!,
                    style: const TextStyle(
                      color: AppColors.accentBright,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: cardHeight,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              itemExtent: cardWidth + 12,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: RepaintBoundary(
                    child: GameCard(
                      item: items[index],
                      width: cardWidth,
                      height: cardHeight,
                      isFocused: focusedCol == index,
                      showPlayButton: showPlayButton,
                      showDate: showDate,
                      showBadgeTop: showBadgeTop,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
