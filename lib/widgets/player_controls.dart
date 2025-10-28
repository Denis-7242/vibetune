import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../services/audio_player_service.dart';

class PlayerControls extends StatelessWidget {
  final AudioPlayerService audioService;

  const PlayerControls({
    super.key,
    required this.audioService,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioService.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final playing = playerState?.playing ?? false;
        final processingState = playerState?.processingState;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Previous Button
            IconButton(
              onPressed: audioService.previous,
              icon: const Icon(Icons.skip_previous),
              iconSize: 40,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            
            // Play/Pause Button
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: audioService.playPause,
                icon: Icon(
                  processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering
                      ? Icons.hourglass_empty
                      : playing
                          ? Icons.pause
                          : Icons.play_arrow,
                ),
                iconSize: 36,
                color: Colors.white,
              ),
            ),
            
            // Next Button
            IconButton(
              onPressed: audioService.next,
              icon: const Icon(Icons.skip_next),
              iconSize: 40,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        );
      },
    );
  }
}

class ProgressBar extends StatelessWidget {
  final AudioPlayerService audioService;

  const ProgressBar({
    super.key,
    required this.audioService,
  });

  String _formatDuration(Duration? duration) {
    if (duration == null) return '0:00';
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: audioService.positionStream,
      builder: (context, positionSnapshot) {
        return StreamBuilder<Duration?>(
          stream: audioService.durationStream,
          builder: (context, durationSnapshot) {
            final position = positionSnapshot.data ?? Duration.zero;
            final duration = durationSnapshot.data ?? Duration.zero;
            final total = duration.inMilliseconds.toDouble();
            final current = position.inMilliseconds.toDouble();

            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 16,
                    ),
                    activeTrackColor: Theme.of(context).primaryColor,
                    inactiveTrackColor:
                        Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                    thumbColor: Theme.of(context).primaryColor,
                    overlayColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: total > 0 ? current.clamp(0, total) : 0,
                    max: total > 0 ? total : 1,
                    onChanged: (value) {
                      audioService.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(position),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color
                              ?.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        _formatDuration(duration),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color
                              ?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class AnimatedEqualizer extends StatefulWidget {
  final bool isPlaying;

  const AnimatedEqualizer({
    super.key,
    required this.isPlaying,
  });

  @override
  State<AnimatedEqualizer> createState() => _AnimatedEqualizerState();
}

class _AnimatedEqualizerState extends State<AnimatedEqualizer>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + (index * 100)),
      )..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedEqualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        for (var controller in _controllers) {
          controller.repeat(reverse: true);
        }
      } else {
        for (var controller in _controllers) {
          controller.stop();
          controller.value = 0;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return AnimatedBuilder(
          animation: _controllers[index],
          builder: (context, child) {
            return Container(
              width: 4,
              height: widget.isPlaying
                  ? 20 + (_controllers[index].value * 20)
                  : 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          },
        );
      }),
    );
  }
}