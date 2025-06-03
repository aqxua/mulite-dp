import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mulite/models/track_model.dart';

class AudioService extends ChangeNotifier {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioService._internal() {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _isRepeat ? _playCurrentTrack() : playNext();
      }
      notifyListeners(); // Оновлюємо слухачів при зміні стану
    });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Track> _playlist = [];
  int _currentIndex = 0;
  bool _isRepeat = false;
  Track? _currentTrack;

  Track? get currentTrack => _currentTrack;
  bool get isRepeat => _isRepeat;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

  void setPlaylist(List<Track> playlist, int startIndex) {
    _playlist = playlist;
    _currentIndex = startIndex.clamp(0, playlist.length - 1);
    _playCurrentTrack();
  }

  Future<void> _playCurrentTrack() async {
    if (_playlist.isEmpty) return;
    _currentTrack = _playlist[_currentIndex];

    try {
      // Зупиняємо плеєр і скидаємо стан перед зміною треку
      
      await _audioPlayer.setAsset(_currentTrack!.audioPath);
      await _audioPlayer.play();

      // Відтворюємо, тільки якщо плеєр не на паузі
      if (_audioPlayer.playing || _audioPlayer.processingState == ProcessingState.idle) {
        await _audioPlayer.stop();
      }
    } catch (e) {
      print('Error setting asset or playing: $e');
    }
    notifyListeners();
  }

  void playNext() {
    if (_playlist.isEmpty) return;
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    _playCurrentTrack();
  }

  void playPrevious() {
    if (_playlist.isEmpty) return;
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    _playCurrentTrack();
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  // Перевірка плеєра на паузу
  bool get isPaused => !_audioPlayer.playing && _audioPlayer.processingState != ProcessingState.idle;
}