import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/providers/favorites/favorites_provider.dart';
import 'package:gamespotlight/core/widgets/async_ui_builder.dart';
import 'package:gamespotlight/core/widgets/loading_expressive.dart';
import 'package:gamespotlight/core/widgets/tv_button.dart';
import 'package:material3_expressive_loading_indicator/material3_expressive_loading_indicator.dart';
import 'package:video_player/video_player.dart';

class GameVideoPlayer extends StatefulWidget {
  final String gameId;

  final String videoUrl;
  const GameVideoPlayer({
    super.key,
    required this.gameId,
    required this.videoUrl,
  });

  @override
  State<GameVideoPlayer> createState() => _GameVideoPlayerState();
}

class _GameVideoPlayerState extends State<GameVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            spacing: 10,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              _VideoSettings(
                controller: _controller,
                onFullscreen: _enterFullScreen,
                onPlayOrPause: _videoPlayOrPause,
                gameId: widget.gameId,
              ),
            ],
          );
        }
        return SizedBox(height: 250, child: const LoadingExpressive());
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.pause();
  }

  void _enterFullScreen() {
    if (!_controller.value.isInitialized) return;

    Navigator.of(context)
        .push(
          PageRouteBuilder(
            opaque: true,
            pageBuilder: (context, _, _) => Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),
        )
        .then((_) => setState(() {}));
  }

  void _videoPlayOrPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }
}

class _VideoSettings extends ConsumerStatefulWidget {
  final VideoPlayerController controller;

  final VoidCallback onFullscreen;
  final VoidCallback onPlayOrPause;
  final String gameId;
  const _VideoSettings({
    required this.controller,
    required this.onFullscreen,
    required this.onPlayOrPause,
    required this.gameId,
  });

  @override
  ConsumerState<_VideoSettings> createState() => _VideoSettingsState();
}

class _VideoSettingsState extends ConsumerState<_VideoSettings> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final isFavoritesAsyncValue = ref.watch(isFavoriteProvider(widget.gameId));

    ref.listen<AsyncValue<void>>(toggleFavoriteProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString()), backgroundColor: cs.error),
        ),
      );
    });

    return AsyncUIBuilder(
      asyncValue: isFavoritesAsyncValue,
      builder: (isFavorite) {
        return Column(
          spacing: 10,
          children: [
            Text(
              '${formatDate(widget.controller.value.position)} / ${formatDate(widget.controller.value.duration)}',
              style: const TextStyle(color: Colors.white),
            ),

            ExpressiveLinearProgressIndicator(
              minHeight: 14,
              amplitude: widget.controller.value.isPlaying ? 0.45 : 0.0,
              wavelength: 30,
              waveSpeed: 10,
              value: widget.controller.value.duration.inMilliseconds > 0
                  ? widget.controller.value.position.inMilliseconds /
                        widget.controller.value.duration.inMilliseconds
                  : 0.0,
            ),
            SizedBox(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  TvButton(
                    autofocus: true,
                    label: (widget.controller.value.isPlaying)
                        ? 'PAUSAR'
                        : 'REPRODUCIR',
                    icon: (widget.controller.value.isPlaying)
                        ? Icons.pause
                        : Icons.play_arrow,
                    onPressed: widget.onPlayOrPause,
                  ),

                  TvButton(
                    label: 'Favoritos',
                    icon: isFavorite ? Icons.favorite : Icons.favorite_outline,
                    colorIcon: isFavorite
                        ? cs.tertiary
                        : cs.onSurface.withValues(alpha: 0.6),
                    onPressed: () => _onFavoritePressed(cs, isFavorite),
                  ),

                  TvButton(
                    icon: Icons.fullscreen,
                    onPressed: widget.onFullscreen,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String formatDate(Duration duracion) {
    String dosDigitos(int n) => n.toString().padLeft(2, '0');
    final horas = dosDigitos(duracion.inHours);
    final minutos = dosDigitos(duracion.inMinutes.remainder(60));
    final segundos = dosDigitos(duracion.inSeconds.remainder(60));

    return [if (duracion.inHours > 0) horas, minutos, segundos].join(':');
  }

  void _onFavoritePressed(ColorScheme cs, bool isFavorite) {
    ref.read(toggleFavoriteProvider.notifier).call(widget.gameId);
    if (!context.mounted) return;
    if (!isFavorite) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Agregado a favoritos'),
          backgroundColor: cs.primary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Eliminado de favoritos'),
          backgroundColor: cs.error,
        ),
      );
    }
  }
}
