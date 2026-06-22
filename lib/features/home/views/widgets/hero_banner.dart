import 'package:flutter/material.dart';
import 'package:game_tv/core/widgets/static_button.dart';
import 'package:game_tv/features/home/models/game_item.dart';

class HeroBanner extends StatelessWidget {
  final int currentIndex;
  final bool isFocused;
  final List<GameItem> heroSlides;

  const HeroBanner({
    super.key,
    required this.currentIndex,
    required this.isFocused,
    required this.heroSlides,
  });

  @override
  Widget build(BuildContext context) {
    final slide = heroSlides[currentIndex];
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: isFocused
            ? Border.all(color: colorScheme.outline, width: 2.5)
            : Border.all(color: Colors.transparent, width: 2.5),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [slide.gradientStart, slide.gradientEnd],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: -40,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.08),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (slide.badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        slide.badge!,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    slide.title,
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    slide.subtitle,
                    style: TextStyle(
                      color: colorScheme.onSecondary,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      StaticButton(
                        icon: Icons.play_arrow_rounded,
                        label: 'VER TRÁILER ESPECIAL',
                        isPrimary: true,
                      ),
                      const SizedBox(width: 12),
                      StaticButton(
                        icon: Icons.add_rounded,
                        label: 'MI LISTA',
                        isPrimary: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (slide.date != null)
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colorScheme.primary, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'LANZAMIENTO',
                        style: TextStyle(
                          color: colorScheme.onTertiary,
                          fontSize: 8,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        slide.date!.split(' ')[0],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        slide.date!.substring(3),
                        style: TextStyle(
                          color: colorScheme.secondary,
                          fontSize: 10,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Indicadores de slide
            Positioned(
              bottom: 20,
              left: 36,
              child: Row(
                children: List.generate(heroSlides.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 6),
                    width: i == currentIndex ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == currentIndex
                          ? colorScheme.primary
                          : colorScheme.onTertiary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
            if (isFocused)
              Positioned(
                bottom: 16,
                right: 20,
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: colorScheme.onTertiary,
                      size: 14,
                    ),
                    Text(
                      '  navegar  ',
                      style: TextStyle(
                        color: colorScheme.onTertiary,
                        fontSize: 10,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: colorScheme.onTertiary,
                      size: 14,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
