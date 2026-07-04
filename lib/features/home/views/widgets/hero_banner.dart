import 'package:flutter/material.dart';
import 'package:game_tv/core/domain/games/entities/game_entity.dart';
import 'package:game_tv/core/widgets/static_button.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({
    super.key,
    required this.currentIndex,
    required this.isFocused,
    required this.heroSlides,
  });

  final int currentIndex;
  final bool isFocused;
  final List<GameEntity> heroSlides;

  static const _bannerHeight = 310.0;
  static const _borderRadius = 16.0;
  static const _padding = 36.0;

  GameEntity get _currentSlide => heroSlides[currentIndex];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _bannerHeight,
      decoration: _buildDecoration(cs),
      child: ClipRRect(
        borderRadius: .circular(_borderRadius - 2),
        child: Stack(
          children: [
            _BackgroundGlow(cs: cs),
            _BannerContent(slide: _currentSlide, cs: cs),
            _LaunchDataBadge(slide: _currentSlide, cs: cs),
            _SlideIndicators(
              count: heroSlides.length,
              currentIndex: currentIndex,
              cs: cs,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(ColorScheme colorScheme) {
    final borderColor = isFocused ? colorScheme.outline : Colors.transparent;

    return BoxDecoration(
      borderRadius: BorderRadius.circular(_borderRadius),
      image: DecorationImage(
        image: NetworkImage(_currentSlide.bannerUrl),
        fit: BoxFit.cover,
      ),
      border: Border.all(color: borderColor, width: 2.5),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -40,
      top: -40,
      child: Container(
        width: 320,
        height: 320,
        decoration: BoxDecoration(
          shape: .circle,
          color: cs.primary.withValues(alpha: 0.08),
        ),
      ),
    );
  }
}

class _BannerContent extends StatelessWidget {
  const _BannerContent({required this.slide, required this.cs});

  final GameEntity slide;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(36),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        children: [
          const SizedBox(height: 12),
          Text(
            slide.title,
            style: const TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Editor Desconocido',
            style: TextStyle(
              color: cs.onSecondary,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              StaticButton(
                icon: Icons.play_arrow_rounded,
                label: 'VER TRÁILER ESPECIAL',
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LaunchDataBadge extends StatelessWidget {
  const _LaunchDataBadge({required this.slide, required this.cs});

  final GameEntity slide;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final releaseDay = slide.date ?? '';

    return Positioned(
      top: 20,
      right: 20,
      child: Container(
        padding: const .all(12),
        decoration: BoxDecoration(
          color: cs.surface.withValues(alpha: 0.9),
          borderRadius: .circular(10),
          border: .all(color: cs.primary, width: 1.5),
        ),
        child: Column(
          children: [
            const Text('LANZAMIENTO'),
            Text(
              releaseDay.toString(),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideIndicators extends StatelessWidget {
  const _SlideIndicators({
    required this.count,
    required this.currentIndex,
    required this.cs,
  });

  final int count;
  final int currentIndex;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: HeroBanner._padding,
      child: Row(children: List.generate(count, _buildDot)),
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const .only(right: 6),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? cs.primary : cs.onTertiary,
        borderRadius: .circular(4),
      ),
    );
  }
}
