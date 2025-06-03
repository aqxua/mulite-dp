import 'package:flutter/material.dart';
import 'package:mulite/models/playlist_model.dart';
import 'package:mulite/models/track_model.dart';
import 'package:mulite/screens/main/player_screen.dart';
import 'package:mulite/models/audio_service.dart';

class PLScreen extends StatelessWidget {
  const PLScreen({super.key});

  static final List<Playlist> _playlists = [
    Playlist(
      id: '1',
      title: 'Вайб фонку',
      genre: 'Phonk',
      image: 'assets/images/playlists/phonk.jpg',
      tracks: [
        Track(id: 1, title: 'FATE', artist: 'KILLAPHONK', image: 'assets/images/music/id-1.jpg', audioPath: 'assets/audio/id-1.mp3'),
        Track(id: 2, title: 'Mr. Pedro', artist: 'MoonDeity', image: 'assets/images/music/id-4.jpg', audioPath: 'assets/audio/id-4.mp3'),
      ],
    ),
    Playlist(
      id: '2',
      title: 'Класичний рок',
      genre: 'Rock',
      image: 'assets/images/playlists/rock.jpg',
      tracks: [
        Track(id: 3, title: 'Smells Like Teen Spirit', artist: 'Nirvana', image: 'assets/images/music/id-6.jpg', audioPath: 'assets/audio/id-6.mp3'),
        Track(id: 4, title: 'Highway To Hell', artist: 'AC/DC', image: 'assets/images/music/id-7.jpg', audioPath: 'assets/audio/id-7.mp3'),
      ],
    ),
    Playlist(
      id: '3',
      title: 'Ню-метал',
      genre: 'Rock',
      image: 'assets/images/playlists/nu_metal.jpg',
      tracks: [
        Track(id: 5, title: 'Numb', artist: 'Linkin Park', image: 'assets/images/music/id-8.jpg', audioPath: 'assets/audio/id-8.mp3'),
        Track(id: 6, title: 'In The End', artist: 'Linkin Park', image: 'assets/images/music/id-10.jpg', audioPath: 'assets/audio/id-10.mp3'),
      ],
    ),
    Playlist(
      id: '4',
      title: 'Альтернативна добірка',
      genre: 'Alternative',
      image: 'assets/images/playlists/alternative.jpg',
      tracks: [
        Track(id: 7, title: 'Zombie', artist: 'The Cranberries', image: 'assets/images/music/id-11.jpg', audioPath: 'assets/audio/id-11.mp3'),
        Track(id: 8, title: 'It\'s My Life', artist: 'Bon Jovi', image: 'assets/images/music/id-12.jpg', audioPath: 'assets/audio/id-12.mp3'),
      ],
    ),
  ];

  Map<String, List<Playlist>> _groupPlaylistsByGenre() {
    final Map<String, List<Playlist>> grouped = {};
    for (var playlist in _playlists) {
      if (!grouped.containsKey(playlist.genre)) {
        grouped[playlist.genre] = [];
      }
      grouped[playlist.genre]!.add(playlist);
    }
    return grouped;
  }

  void _navigateToPlayer(BuildContext context, List<Track> tracks, int index) {
    AudioService().setPlaylist(tracks, index);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PlayerScreen(),
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut))
              .animate(animation),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupedPlaylists = _groupPlaylistsByGenre();

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/homepage_background.png',
              fit: BoxFit.cover,
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final genre = groupedPlaylists.keys.elementAt(index);
                      final playlists = groupedPlaylists[genre]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              genre,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 0.8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: playlists.length,
                              itemBuilder: (context, idx) {
                                final playlist = playlists[idx];
                                return GestureDetector(
                                  onTap: () => _navigateToPlayer(context, playlist.tracks, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2 - 24,
                                    margin: const EdgeInsets.only(right: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.asset(
                                            playlist.image,
                                            height: 140,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          playlist.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${playlist.tracks.length} композицій',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                    childCount: groupedPlaylists.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}