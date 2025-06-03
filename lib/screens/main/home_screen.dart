import 'package:flutter/material.dart';
import 'package:mulite/models/audio_service.dart';
import 'package:mulite/models/track_model.dart';
import 'package:mulite/screens/main/player_screen.dart';
import 'package:mulite/widgets/music_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _quickChoiceTracks = [
    Track(id: 1, title: 'FATE', artist: 'KILLAPHONK', image: 'assets/images/music/id-1.jpg', audioPath: 'assets/audio/id-1.mp3'),
    Track(id: 2, title: 'Dead Man`s Opera', artist: 'Silenclyde', image: 'assets/images/music/id-2.jpg', audioPath: 'assets/audio/id-2.mp3'),
    Track(id: 3, title: 'End Theme', artist: 'GSC Game World', image: 'assets/images/music/id-3.jpg', audioPath: 'assets/audio/id-3.mp3'),
  ];

  static const _trendingTracks = [
    Track(id: 4, title: 'Mr. Pedro', artist: 'MoonDeity', image: 'assets/images/music/id-4.jpg', audioPath: 'assets/audio/id-4.mp3'),
    Track(id: 5, title: 'Monster', artist: 'Skillet', image: 'assets/images/music/id-5.jpg', audioPath: 'assets/audio/id-5.mp3'),
    Track(id: 6, title: 'Smells Like Teen Spirit', artist: 'Nirvana', image: 'assets/images/music/id-6.jpg', audioPath: 'assets/audio/id-6.mp3'),
    Track(id: 7, title: 'Highway To Hell', artist: 'AC/DC', image: 'assets/images/music/id-7.jpg', audioPath: 'assets/audio/id-7.mp3'),
    Track(id: 8, title: 'Numb', artist: 'Linkin Park', image: 'assets/images/music/id-8.jpg', audioPath: 'assets/audio/id-8.mp3'),
    Track(id: 9, title: 'Guns N\' Roses', artist: 'November Rain', image: 'assets/images/music/id-9.jpg', audioPath: 'assets/audio/id-9.mp3'),
    Track(id: 10, title: 'In The End', artist: 'Linkin Park', image: 'assets/images/music/id-10.jpg', audioPath: 'assets/audio/id-10.mp3'),
    Track(id: 11, title: 'Zombie', artist: 'The Cranberries', image: 'assets/images/music/id-11.jpg', audioPath: 'assets/audio/id-11.mp3'),
    Track(id: 12, title: 'It\'s My Life', artist: 'Bon Jovi', image: 'assets/images/music/id-12.jpg', audioPath: 'assets/audio/id-12.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset('assets/images/homepage_background.png', fit: BoxFit.cover)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
              child: Text('Швидкий вибір', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _quickChoiceTracks.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 16 : 8, right: 8),
                  child: SizedBox(
                    width: 150,
                    child: MusicCard(
                      track: _quickChoiceTracks[index],
                      onTap: () => _navigateToPlayer(context, _quickChoiceTracks, index),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
              child: Text('В тренді', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 9,
                itemBuilder: (context, index) => MusicCard(
                  track: _trendingTracks[index],
                  onTap: () => _navigateToPlayer(context, _trendingTracks, index),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  // Функція навігації до екрана плеєра
  void _navigateToPlayer(BuildContext context, List<Track> playlist, int index) {
    AudioService().setPlaylist(playlist, index);
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
}