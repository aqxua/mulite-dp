import 'package:mulite/models/track_model.dart';

class Playlist {
  final String id;
  final String title;
  final String genre;
  final String image;
  final List<Track> tracks;

  Playlist({
    required this.id,
    required this.title,
    required this.genre,
    required this.image,
    required this.tracks,
  });
}