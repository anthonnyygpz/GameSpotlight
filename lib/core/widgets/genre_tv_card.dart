import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreTvCard extends StatefulWidget {
  final String genreName;
  final String imageUrl;
  final int gameCount;
  final VoidCallback onTap;

  const GenreTvCard({
    super.key,
    required this.genreName,
    required this.imageUrl,
    required this.gameCount,
    required this.onTap,
  });

  @override
  State<GenreTvCard> createState() => _GenreTvCardState();
}

class _GenreTvCardState extends State<GenreTvCard> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        onFocusChange: (hasFocus) => setState(() => _isFocused = hasFocus),
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutExpo,
          transform: Matrix4.identity()..scale(_isFocused ? 1.05 : 1.0),
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(
              alpha: _isFocused ? 0.8 : 0.4,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isFocused
                  ? colorScheme.primary
                  : colorScheme.primary.withValues(alpha: 0.2),
              width: _isFocused ? 2 : 0.5,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagen de fondo con gradiente para oscurecer
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.gamepad, size: 40),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.2),
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
              // Contenido de texto
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.genreName.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Azonix',
                        fontSize: 16,
                        color: _isFocused ? colorScheme.primary : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.gameCount} TÍTULOS',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSecondary.withValues(alpha: 0.8),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
