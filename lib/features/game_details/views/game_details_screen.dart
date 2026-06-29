import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/widgets/async_ui_builder.dart';
import 'package:game_tv/core/widgets/tv_button.dart';
import 'package:game_tv/features/game_details/providers/game_aggregator_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material3_expressive_loading_indicator/material3_expressive_loading_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class GameDetailsScreen extends ConsumerStatefulWidget {
  final String? id;

  const GameDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends ConsumerState<GameDetailsScreen> {
  VideoPlayerController? _controller;
  final _ytExtractor = YoutubeExplode();

  bool _isInitializingVideo = false;
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _videoListener();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final current = ref.read(gameAggregatorProvider(widget.id!));
      if (current is AsyncData && current.value != null) {
        _initializeVideo(current.value!.trailer.urlVideo);
      }
    });
  }

  void _videoListener() {
    if (mounted && _controller != null && _controller!.value.isPlaying) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _ytExtractor.close();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo(String videoUrl) async {
    // 1. Bloqueo de seguridad: evitar re-entrada
    if (_isInitializingVideo) return;

    setState(() => _isInitializingVideo = true);

    try {
      // 2. Limpieza profunda: Si ya había un controlador, destruirlo
      if (_controller != null) {
        await _controller!.dispose();
        _controller = null;
      }

      // 3. Obtención de URL directa
      final String? urlDirect = await getVideoUrl(videoUrl);

      if (urlDirect != null && mounted) {
        _controller = VideoPlayerController.networkUrl(Uri.parse(urlDirect));
        await _controller!.initialize();

        _controller?.addListener(_videoListener);

        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      debugPrint('Error al inicializar video: $e');
    } finally {
      if (mounted) {
        setState(() => _isInitializingVideo = false);
      }
    }
  }

  String formatoTiempo(Duration duracion) {
    String dosDigitos(int n) => n.toString().padLeft(2, '0');
    final horas = dosDigitos(duracion.inHours);
    final minutos = dosDigitos(duracion.inMinutes.remainder(60));
    final segundos = dosDigitos(duracion.inSeconds.remainder(60));

    return [if (duracion.inHours > 0) horas, minutos, segundos].join(':');
  }

  void _enterFullScreen() {
    if (_controller == null || !_controller!.value.isInitialized) return;

    Navigator.of(context)
        .push(
          PageRouteBuilder(
            opaque: true,
            pageBuilder: (context, _, _) => Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
            ),
          ),
        )
        .then((_) {
          setState(() {});
        });
  }

  Future<String?> getVideoUrl(String videoUrl) async {
    final yt = YoutubeExplode();

    try {
      var videoId = VideoId(videoUrl);

      var manifest = await yt.videos.streamsClient.getManifest(videoId);

      if (manifest.muxed.isEmpty) {
        debugPrint(
          'El video no tiene flujos combinados. Buscando flujos independientes...',
        );

        var videoStream = manifest.videoOnly.withHighestBitrate();
        // Mejor calidad pero buen rendieminto
        // var videoStream = manifest.videoOnly.bestQuality;
        String urlVideo = videoStream.url.toString();
        debugPrint('URL Directa de Video (sin audio): $urlVideo');
        return urlVideo;
      } else {
        var streamInfo = manifest.muxed.withHighestBitrate();
        return streamInfo.url.toString();
      }
    } catch (e) {
      debugPrint(e.toString());

      return null;
    } finally {
      yt.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final aggregatorAsync = ref.watch(gameAggregatorProvider(widget.id!));

    ref.listen(gameAggregatorProvider(widget.id!), (previous, next) {
      if (next is AsyncData && next.value != null) {
        final newUrl = next.value!.trailer.urlVideo;
        final oldUrl = previous?.value?.trailer.urlVideo;

        // Solo si la URL cambia (evita re-init innecesario)
        if (newUrl != oldUrl && _controller == null) {
          _initializeVideo(newUrl);
        }
      }
    });

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: AsyncUIBuilder(
        asyncValue: aggregatorAsync,
        builder: (data) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.game.bannerUrl ?? ''),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.5),
                  BlendMode.srcATop,
                ),
              ),
            ),
            child: Padding(
              padding: const .only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const .symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                            icon: Icon(Icons.chevron_left),
                            iconSize: 14,
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ),

                        Text(data.game.titulo),
                        const SizedBox(width: 25),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  width: 0.5,
                                ),
                                bottom: BorderSide(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  width: 0.5,
                                ),
                                right: BorderSide(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  width: 0.5,
                                ),
                              ),
                            ),
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
                                          color: colorScheme.onSecondary,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: colorScheme.primary.withValues(
                                            alpha: 0.3,
                                          ),
                                          thickness: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // ... (dentro de la columna del lado izquierdo, debajo del título)
                                  Text(
                                    data.game.titulo,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Azonix',
                                    ),
                                  ),

                                  // NUEVO: Desarrollador y Editor
                                  Text(
                                    '${data.game.desarrollador?.toUpperCase() ?? 'N/A'}  •  ${data.game.editor?.toUpperCase() ?? 'N/A'}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),
                                  ),

                                  Divider(
                                    color: colorScheme.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    thickness: 0.5,
                                  ),

                                  // Estadísticas base (ya existentes)
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
                                            color: colorScheme.primary
                                                .withValues(alpha: 0.5),
                                          ),
                                        ),

                                        Text(
                                          formatoTiempo(
                                            _controller?.value.duration ??
                                                Duration.zero,
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          child: VerticalDivider(
                                            thickness: 0.5,
                                            color: colorScheme.primary
                                                .withValues(alpha: 0.5),
                                          ),
                                        ),

                                        Text(
                                          // NUEVO: Extracción del año desde la base de datos
                                          data.game.fechaLanzamiento?.substring(
                                                0,
                                                4,
                                              ) ??
                                              'TBA',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  // NUEVO: Plataformas y Géneros
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      // Ejemplo estático, idealmente iterar sobre data.platforms y data.genres
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

                                  const Spacer(),

                                  Text(
                                    '${formatoTiempo(_controller?.value.position ?? Duration.zero)} / ${formatoTiempo(_controller?.value.duration ?? Duration.zero)}',
                                    style: const TextStyle(color: Colors.white),
                                  ),

                                  ExpressiveLinearProgressIndicator(
                                    minHeight: 14,
                                    amplitude:
                                        (_controller?.value.isPlaying ?? false)
                                        ? 0.45
                                        : 0.0,
                                    wavelength: 30,
                                    waveSpeed: 10,
                                    value:
                                        (_controller
                                                    ?.value
                                                    .duration
                                                    .inMilliseconds ??
                                                0) >
                                            0
                                        ? ((_controller
                                                      ?.value
                                                      .position
                                                      .inMilliseconds ??
                                                  0) /
                                              (_controller
                                                      ?.value
                                                      .duration
                                                      .inMilliseconds ??
                                                  1)) // El 1 evita división por cero
                                        : 0.0,
                                  ),
                                  Row(
                                    spacing: 10,
                                    children: [
                                      TvButton(
                                        label:
                                            (_controller?.value.isPlaying ??
                                                false)
                                            ? 'PAUSAR'
                                            : 'REPRODUCIR',
                                        icon:
                                            (_controller?.value.isPlaying ??
                                                false)
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        onPressed: () {
                                          setState(() {
                                            if (_controller != null) {
                                              _controller!.value.isPlaying
                                                  ? _controller!.pause()
                                                  : _controller!.play();
                                            }
                                          });
                                        },
                                      ),

                                      TvButton(
                                        label: 'Favoritos',
                                        icon: isFavorite
                                            ? Icons.favorite_outline
                                            : Icons.favorite,
                                        onPressed: () {
                                          setState(() {
                                            isFavorite = !isFavorite;
                                          });
                                        },
                                      ),

                                      TvButton(
                                        label: 'Pantalla completa',
                                        icon: Icons.fullscreen,
                                        onPressed: _enterFullScreen,
                                      ),
                                    ],
                                  ),

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
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  width: 0.5,
                                ),
                                bottom: BorderSide(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const .all(10.0),
                              child: Column(
                                children: [
                                  (_isInitializingVideo ||
                                          _controller == null ||
                                          !_controller!.value.isInitialized)
                                      ? SizedBox(
                                          width: 400,
                                          height: 225,
                                          child: Container(
                                            color: Colors.black26,
                                            child: const Center(
                                              child: ExpressiveLoadingIndicator(
                                                style:
                                                    ExpressiveLoadingIndicatorStyle
                                                        .outlined,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 400,
                                          height: 225,
                                          child: VideoPlayer(_controller!),
                                        ),
                                  // VideoPlayerWidget(controller: _controller),
                                  Padding(
                                    padding: const .symmetric(vertical: 5),
                                    child: Divider(
                                      thickness: 1,
                                      color: colorScheme.primary.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),

                                  const Text(
                                    'Sinopsis',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    data.game.sinopsis ?? 'no hay sinopsis',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: colorScheme.onPrimary.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontWeight: FontWeight.w400,
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
