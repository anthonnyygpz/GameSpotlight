import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/providers/games/games_provider.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/tv_button.dart';
import 'package:gamespotlight/features/game_details/views/widgets/game_video_player.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_date_formatter/smart_date_formatter.dart';

class GameDetailsScreen extends ConsumerWidget {
  const GameDetailsScreen({super.key, required this.id});
  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final gameDetailsAsyncValue = ref.watch(gameDetailsProvider(id!));

    return Scaffold(
      body: AsyncUIBuilder(
        asyncValue: gameDetailsAsyncValue,
        builder: (data) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data?.bannerUrl ?? ''),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.5),
                  BlendMode.srcATop,
                ),
              ),
            ),
            child: Padding(
              padding: const .only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildButtonBack(context),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: _buildDecorationBorder(cs),
                            child: Padding(
                              padding: const .symmetric(horizontal: 25),
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 25),

                                  Row(
                                    spacing: 10,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Detalles del juego',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: cs.onSecondary,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: cs.primary.withValues(
                                            alpha: 0.3,
                                          ),
                                          thickness: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    data?.title ?? '',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Azonix',
                                    ),
                                  ),

                                  Text(
                                    '${data?.developer?.toUpperCase() ?? 'N/A'}  •  ${data?.editor?.toUpperCase() ?? 'N/A'}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: cs.primary,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),
                                  ),

                                  Divider(
                                    color: cs.primary.withValues(alpha: 0.3),
                                    thickness: 0.5,
                                  ),

                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          spacing: 5,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 10,
                                            ),
                                            Text(
                                              '9.1',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          child: VerticalDivider(
                                            thickness: 0.5,
                                            color: cs.primary.withValues(
                                              alpha: 0.5,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          child: VerticalDivider(
                                            thickness: 0.5,
                                            color: cs.primary.withValues(
                                              alpha: 0.5,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          data?.releaseDate?.format(
                                                'dd MMM yyyy',
                                              ) ??
                                              '',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      _buildTag(context, 'PS5', Icons.gamepad),
                                      _buildTag(
                                        context,
                                        'XBOX SERIES X',
                                        Icons.gamepad,
                                      ),
                                      _buildTag(context, 'PC', Icons.computer),
                                      _buildTag(
                                        context,
                                        'RPG',
                                        null,
                                        isGenre: true,
                                      ),
                                      _buildTag(
                                        context,
                                        'DARK FANTASY',
                                        null,
                                        isGenre: true,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),
                                  _buildSynopsis(cs, data?.synopsis ?? ''),

                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: cs.primary.withValues(alpha: 0.3),
                                  width: 0.5,
                                ),
                                bottom: BorderSide(
                                  color: cs.primary.withValues(alpha: 0.3),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const .all(10.0),
                              child: Column(
                                children: [
                                  if (data?.trailers[0].videoUrl != null &&
                                      data!.trailers[0].videoUrl.isNotEmpty)
                                    GameVideoPlayer(
                                      videoUrl: data.trailers[0].videoUrl,
                                      gameId: data.id,
                                    )
                                  else
                                    SizedBox(
                                      height: 300,
                                      child: Padding(
                                        padding: const .symmetric(vertical: 5),
                                        child: Icon(
                                          Icons.broken_image_outlined,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSynopsis(ColorScheme cs, String synopsis) {
    return Column(
      children: [
        const Text(
          'Sinopsis',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        Text(
          synopsis,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            height: 1.5,
            color: cs.onPrimary.withValues(alpha: 0.9),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(
    BuildContext context,
    String label,
    IconData? icon, {
    bool isGenre = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isGenre
            ? Colors.transparent
            : colorScheme.surface.withValues(alpha: 0.5),
        border: Border.all(
          color: isGenre
              ? colorScheme.primary.withValues(alpha: 0.5)
              : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: colorScheme.onSecondary),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: isGenre ? colorScheme.primary : colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBack(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 10, vertical: 5),
      child: TvButton.ghost(
        icon: Icons.chevron_left,
        iconSize: 10,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  BoxDecoration _buildDecorationBorder(ColorScheme cs) {
    return BoxDecoration(
      border: Border(
        top: BorderSide(color: cs.primary.withValues(alpha: 0.5), width: 0.5),
        bottom: BorderSide(
          color: cs.primary.withValues(alpha: 0.5),
          width: 0.5,
        ),
        right: BorderSide(color: cs.primary.withValues(alpha: 0.5), width: 0.5),
      ),
    );
  }
}
