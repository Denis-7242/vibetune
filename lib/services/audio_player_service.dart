import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../models/song_model.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  AudioPlayerService._internal();

  final AudioPlayer _player = AudioPlayer();
  List<AudioModel> _playlist = [];
  int _currentIndex = 0;

  AudioPlayer get player => _player;
  List<AudioModel> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  AudioModel? get currentSong =>
      _playlist.isNotEmpty ? _playlist[_currentIndex] : null;

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<bool> get playingStream => _player.playingStream;

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  Future<void> setPlaylist(List<AudioModel> songs, int startIndex) async {
    _playlist = songs;
    _currentIndex = startIndex;
    await _playSongAtIndex(_currentIndex);
  }

  Future<void> _playSongAtIndex(int index) async {
    if (index < 0 || index >= _playlist.length) return;
    
    final song = _playlist[index];
    if (song.uri == null) return;

    try {
      await _player.setFilePath(song.uri!);
      await _player.play();
    } catch (e) {
      print('Error playing song: $e');
    }
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> playPause() async {
    if (_player.playing) {
      await pause();
    } else {
      await play();
    }
  }

  Future<void> next() async {
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
      await _playSongAtIndex(_currentIndex);
    }
  }

  Future<void> previous() async {
    if (_player.position.inSeconds > 3) {
      await _player.seek(Duration.zero);
    } else if (_currentIndex > 0) {
      _currentIndex--;
      await _playSongAtIndex(_currentIndex);
    }
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}