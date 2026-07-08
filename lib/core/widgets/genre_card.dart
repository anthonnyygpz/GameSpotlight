import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamespotlight/core/domain/genres/entities/genres_entity.dart';
import 'package:gamespotlight/core/network/memory_cache_manager.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    required this.isFocused,
  });

  final GenreEntity item;
  final double width;
  final double height;
  final bool isFocused;

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
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(cs),
              _buildGradientOverlay(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    item.name
                        .toUpperCase(), // Asegúrese de usar la propiedad correcta del nombre
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Azonix',
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.black87,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
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
    final borderColor = isFocused ? cs.primary : Colors.transparent;
    final shadowColor = isFocused
        ? cs.primary.withValues(alpha: 0.5)
        : Colors.transparent;

    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor, width: 2.5),
      boxShadow: [
        BoxShadow(color: shadowColor, blurRadius: 16, spreadRadius: 2),
      ],
    );
  }

  Widget _buildImage(ColorScheme cs) {
    return CachedNetworkImage(
      imageUrl:
          item.iconUrl, // Ajuste a la propiedad de imagen de su GenreEntity
      cacheManager: MemoryCacheManager(),
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          Container(color: cs.surfaceContainerHighest),
      errorWidget: (context, url, error) => Container(
        color: cs.surfaceContainerHighest,
        child: Icon(Icons.broken_image_outlined, color: cs.onSurfaceVariant),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.3),
            Colors.black.withValues(alpha: 0.7),
          ],
        ),
      ),
    );
  }
}
