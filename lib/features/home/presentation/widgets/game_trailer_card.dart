import 'package:flutter/material.dart';
import 'package:game_tv/core/widgets/line_opacity.dart';
import 'package:game_tv/features/auth/views/widgets/card_glass.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTrailerCard extends StatelessWidget {
  final bool isEntry;

  const GameTrailerCard({super.key, this.isEntry = false});

  @override
  Widget build(BuildContext context) {
    return CardGlass(
      isEntry: isEntry,
      onPressed: () {},
      enableBlur: false,
      bgImage: AssetImage('assets/img.png'),
      padding: const .all(10),
      borderSize: 1,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Badge(
              label: Text(
                'NUEVO',
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: Column(
              spacing: 10,
              crossAxisAlignment: .start,
              children: [
                Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .center,
                  children: [
                    Text(
                      'ECLIPSE',
                      style: GoogleFonts.cinzel(
                        textStyle: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Row(
                      spacing: 10,
                      mainAxisSize: .min,
                      children: [
                        const LineOpacity(flipX: true),
                        Text(
                          'REBIRTH',
                          style: GoogleFonts.cinzel(
                            textStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const LineOpacity(),
                      ],
                    ),
                  ],
                ),

                const Text(
                  'TRAILER DE LANZAMIENTO',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: CardGlass(
              borderRadius: 100,
              borderSize: 0.3,
              padding: const .all(2),
              child: const Icon(
                Icons.play_arrow,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
