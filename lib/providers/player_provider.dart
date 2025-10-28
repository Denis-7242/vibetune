import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../models/song_model.dart';
import '../services/audio_player_service.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayerService _audioService = AudioPlayerService();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  
  List<AudioModel> _songs = [];
  bool _isLoading = true;
  bool _permissionGranted = false;

  List<AudioModel> get songs => _songs;
  bool get isLoading => _isLoading;
  bool get permissionGranted => _permissionGranted;
  AudioPlayerService get audioService => _audioService;

  PlayerProvider() {
    _init();
  }

  Future<void> _init() async {
    await _audioService.init();
    await requestPermission();
    if (_permissionGranted) {
      await loadSongs();
    }
  }

  Future<void> requestPermission() async {
    _permissionGranted = await _audioQuery.permissionsRequest();
    notifyListeners();
  }

  Future<void> loadSongs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final queriedSongs = await _audioQuery.querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      _songs = queriedSongs.map((song) => AudioModel.fromSongModel(song)).toList();
    } catch (e) {
      print('Error loading songs: $e');
      _songs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> playSong(int index) async {
    await _audioService.setPlaylist(_songs, index);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}