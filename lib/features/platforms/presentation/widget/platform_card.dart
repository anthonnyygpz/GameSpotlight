import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamespotlight/core/domain/platforms/entities/platforms_entity.dart';
import 'package:gamespotlight/core/network/memory_cache_manager.dart';

class PlatformCard extends StatelessWidget {
  const PlatformCard({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    required this.isFocused,
  });

  final PlatformEntity item;
  final double width;
  final double height;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedScale(
      scale: isFocused ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        decoration: _buildDecoration(cs),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  _buildBackgroundImage(item.iconUrl, constraints),
                  _buildGradientOverlay(),
                  _buildContent(constraints),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(ColorScheme cs) {
    final borderColor = isFocused ? cs.primary : Colors.transparent;
    final shadowColor = isFocused
        ? cs.primary.withValues(alpha: 0.4)
        : Colors.transparent;

    return BoxDecoration(
      color: const Color(0xFF0B0D14),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor, width: 2),
      boxShadow: [
        BoxShadow(color: shadowColor, blurRadius: 16, spreadRadius: 2),
      ],
    );
  }

  Widget _buildBackgroundImage(String coverImage, BoxConstraints constraints) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: constraints.maxHeight * 0.85,
      child: CachedNetworkImage(
        imageUrl: coverImage,
        cacheManager: MemoryCacheManager(),
        fit: BoxFit.cover,
        errorWidget: (context, url, error) =>
            const ColoredBox(color: Colors.black26),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF0B0D14).withValues(alpha: 0.6),
            const Color(0xFF0B0D14),
          ],
          stops: const [0.3, 0.55, 0.8],
        ),
      ),
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
    // Escala dinámica para márgenes basados en el tamaño de la tarjeta
    final padding = constraints.maxWidth * 0.08;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildPlatformBadge(constraints),
          SizedBox(height: constraints.maxHeight * 0.03),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.01),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: const Text(
              '- Acceso a miles de juegos',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.04),
          _buildActionBtn(constraints),
        ],
      ),
    );
  }

  Widget _buildPlatformBadge(BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.04,
        vertical: constraints.maxHeight * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          item.type.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildActionBtn(BoxConstraints constraints) {
    return SizedBox(
      width: double.infinity,
      height: constraints.maxHeight * 0.12, // Botón adaptable a la altura
      child: ElevatedButton(
        onPressed: () {
          // Inserte su directiva de navegación aquí, Señor.
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero, // El tamaño lo dicta el SizedBox
        ),
        child: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'VER JUEGOS',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
