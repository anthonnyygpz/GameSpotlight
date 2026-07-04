import 'package:flutter/material.dart';
import 'package:game_tv/core/domain/games/entities/game_entity.dart';
import 'package:game_tv/core/widgets/game_card.dart';

class ContentRow extends StatelessWidget {
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

  final String title;
  final List<GameEntity> items;
  final double cardWidth;
  final double cardHeight;
  final bool showPlayButton;
  final bool showDate;
  final bool showBadgeTop;
  final String? trailingLabel;
  final int focusedCol;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final hasTrailingAction = trailingLabel != null;
    final totalItems = hasTrailingAction ? items.length + 1 : items.length;

    return Padding(
      padding: const .only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RowHeader(title: title, hasTrailingAction: hasTrailingAction),
          const SizedBox(height: 14),
          SizedBox(
            height: cardHeight,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: const .symmetric(horizontal: 20),
              itemCount: totalItems,
              itemExtent: cardWidth + 12,
              itemBuilder: (context, index) => _buildItem(context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final isTrailing = trailingLabel != null && index == items.length;
    if (isTrailing) {
      return RepaintBoundary(
        child: _TrailingCard(
          label: trailingLabel!,
          isFocused: focusedCol == index,
        ),
      );
    }

    return RepaintBoundary(
      child: GameCard(
        item: items[index],
        width: cardWidth,
        height: cardHeight,
        isFocused: focusedCol == index,
        showPlayButton: showPlayButton,
        showDate: showDate,
        showBadgeTop: showBadgeTop,
      ),
    );
  }
}

class _RowHeader extends StatelessWidget {
  const _RowHeader({required this.title, required this.hasTrailingAction});

  final String title;
  final bool hasTrailingAction;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const .symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 18,
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: .circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: .w800,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          if (hasTrailingAction) _ScrollHint(cs: cs),
        ],
      ),
    );
  }
}

class _ScrollHint extends StatelessWidget {
  const _ScrollHint({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'DESLIZA AL FINAL',
          style: TextStyle(
            color: cs.onSurface.withValues(alpha: 0.35),
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(width: 6),
        Icon(
          Icons.keyboard_arrow_right_rounded,
          color: cs.onSurface.withValues(alpha: 0.35),
          size: 14,
        ),
      ],
    );
  }
}

class _TrailingCard extends StatelessWidget {
  const _TrailingCard({required this.label, required this.isFocused});

  final String label;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = isFocused ? cs.primary : cs.onSurface.withValues(alpha: 0.6);

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isFocused
              ? cs.primary.withValues(alpha: 0.15)
              : cs.surface.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isFocused ? cs.primary : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline_rounded, size: 28, color: color),
              const SizedBox(height: 8),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
