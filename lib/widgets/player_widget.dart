import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mulite/models/audio_service.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AudioService(),
      builder: (context, _) {
        final track = AudioService().currentTrack;
        if (track == null) return const Center(child: Text('No track selected', style: TextStyle(color: Colors.white)));
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(track.image, width: 300, height: 300, fit: BoxFit.cover)),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      Text(track.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(track.artist, style: const TextStyle(fontSize: 18, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  const SizedBox(height: 32),
                  StreamBuilder<Duration>(
                    stream: AudioService().positionStream,
                    builder: (context, positionSnapshot) {
                      final position = positionSnapshot.data ?? Duration.zero;
                      return StreamBuilder<Duration?>(
                        stream: AudioService().durationStream,
                        builder: (context, durationSnapshot) {
                          final duration = durationSnapshot.data ?? Duration.zero;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(position), style: const TextStyle(color: Colors.white, fontSize: 16)),
                                Expanded(
                                  child: Slider(
                                    value: position.inSeconds.toDouble(),
                                    min: 0,
                                    max: duration.inSeconds > 0 ? duration.inSeconds.toDouble() : 1,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.grey,
                                    thumbColor: Colors.white,
                                    onChanged: duration > Duration.zero ? (value) => AudioService().seek(Duration(seconds: value.toInt())) : null,
                                  ),
                                ),
                                Text(_formatDuration(duration), style: const TextStyle(color: Colors.white, fontSize: 16)),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: StreamBuilder<PlayerState>(
                stream: AudioService().playerStateStream,
                builder: (context, snapshot) {
                  final playing = snapshot.data?.playing ?? false;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.repeat, color: AudioService().isRepeat ? Colors.green : Colors.white, size: 40),
                        onPressed: AudioService().toggleRepeat,
                      ),
                      IconButton(icon: const FaIcon(FontAwesomeIcons.backward, color: Colors.white, size: 40), onPressed: AudioService().playPrevious),
                      IconButton(
                        icon: FaIcon(playing ? FontAwesomeIcons.pause : FontAwesomeIcons.play, color: Colors.white, size: 48),
                        onPressed: () => playing ? AudioService().pause() : AudioService().resume(),
                      ),
                      IconButton(icon: const FaIcon(FontAwesomeIcons.forward, color: Colors.white, size: 40), onPressed: AudioService().playNext),
                      IconButton(icon: const FaIcon(FontAwesomeIcons.heart, color: Colors.white, size: 40), onPressed: () {}),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}