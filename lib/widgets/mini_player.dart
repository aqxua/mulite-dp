import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mulite/models/audio_service.dart';
import 'package:mulite/screens/main/player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AudioService(),
      builder: (context, _) {
        final track = AudioService().currentTrack;
        if (track == null) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlayerScreen())),
          child: Container(
            height: 60,
            color: const Color(0xFF1C1C1C),
            child: Row(
              children: [
                Image.asset(track.image, width: 50, height: 50, fit: BoxFit.cover),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(track.title, style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
                      Text(track.artist, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.repeat, color: AudioService().isRepeat ? Colors.green : Colors.white, size: 20),
                      onPressed: AudioService().toggleRepeat,
                    ),
                    IconButton(icon: const FaIcon(FontAwesomeIcons.backward, color: Colors.white, size: 20), onPressed: AudioService().playPrevious),
                    StreamBuilder<PlayerState>(
                      stream: AudioService().playerStateStream,
                      builder: (context, snapshot) {
                        final playing = snapshot.data?.playing ?? false;
                        return IconButton(
                          icon: FaIcon(playing ? FontAwesomeIcons.pause : FontAwesomeIcons.play, color: Colors.white, size: 24),
                          onPressed: () => playing ? AudioService().pause() : AudioService().resume(),
                        );
                      },
                    ),
                    IconButton(icon: const FaIcon(FontAwesomeIcons.forward, color: Colors.white, size: 20), onPressed: AudioService().playNext),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}