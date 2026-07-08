import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamespotlight/core/domain/games/entities/game_entity.dart';
import 'package:gamespotlight/core/network/memory_cache_manager.dart';
import 'package:smart_date_formatter/smart_date_formatter.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    required this.isFocused,
    required this.showPlayButton,
    required this.showDate,
    required this.showBadgeTop,
    this.showFavorite = false,
  });

  final GameEntity item;
  final double width;
  final double height;
  final bool isFocused;
  final bool showPlayButton;
  final bool showDate;
  final bool showBadgeTop;
  final bool showFavorite;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedScale(
      scale: isFocused ? 1.06 : 0.95,
      duration: const Duration(milliseconds: 200),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        decoration: _buildDecoration(cs),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              _buildImage(cs),
              _shimmerOverlay(cs),
              if (item.releaseDate != null && !showBadgeTop)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Badge(
                    label: Text(
                      item.releaseDate?.format('dd/MM/yyyy') ?? '',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    backgroundColor: cs.primary.withValues(alpha: 0.6),
                  ),
                ),
              // if (item.badge != null && showBadgeTop)
              // Positioned(
              //   top: 10,
              //   right: 10,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 8,
              //       vertical: 3,
              //     ),
              //     decoration: BoxDecoration(
              //       color: Colors.amber.withValues(alpha: 0.9),
              //       borderRadius: BorderRadius.circular(6),
              //     ),
              //     child: Text(
              //       item.badge!,
              //       style: const TextStyle(
              //         color: Colors.black,
              //         fontSize: 10,
              //         fontWeight: FontWeight.w800,
              //       ),
              //     ),
              //   ),
              // ),
              if (showDate && item.editor != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: cs.surface.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: cs.primary.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      item.editor.toString(),
                      style: TextStyle(
                        color: cs.secondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0x88000000)],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color: cs.onPrimary,
                                fontSize: 10,
                                fontFamily: 'Azonix',
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                              ),
                            ),
                            if (item.editor != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                item.editor ?? 'Desconocido',
                                style: TextStyle(
                                  color: cs.onSecondary,
                                  fontSize: 9,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (showPlayButton)
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isFocused
                                ? cs.primary
                                : cs.surface.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isFocused
                                  ? cs.secondary
                                  : cs.onTertiary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: cs.onPrimary,
                            size: 18,
                          ),
                        ),

                      if (showFavorite)
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isFocused
                                ? cs.primary
                                : cs.surface.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isFocused
                                  ? cs.secondary
                                  : cs.onTertiary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: cs.onPrimary,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(ColorScheme cs) {
    final borderColor = isFocused ? cs.outline : Colors.transparent;
    final shadowColor = isFocused ? cs.shadow : Colors.transparent;

    return BoxDecoration(
      borderRadius: .circular(12),
      border: Border.all(color: borderColor, width: 2.5),
      boxShadow: [
        BoxShadow(color: shadowColor, blurRadius: 16, spreadRadius: 2),
      ],
    );
  }

  Widget _buildImage(ColorScheme cs) {
    return Positioned.fill(
      child: CachedNetworkImage(
        imageUrl: item.coverImageUrl,
        cacheManager: MemoryCacheManager(),
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Container(color: cs.surfaceContainerHighest),
        errorWidget: (context, url, error) => Container(
          color: cs.surfaceContainerHighest,
          child: Icon(Icons.broken_image_outlined, color: cs.onSurfaceVariant),
        ),
      ),
    );
  }

  Widget _shimmerOverlay(ColorScheme cs) {
    if (item.bannerUrl == null) return const SizedBox.shrink();

    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white.withValues(alpha: 0.04), Colors.transparent],
          ),
        ),
      ),
    );
  }
}
