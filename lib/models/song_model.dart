import 'package:on_audio_query/on_audio_query.dart';

class AudioModel {
  final int id;
  final String title;
  final String artist;
  final String? album;
  final String? uri;
  final int? duration;
  final String? albumArt;

  AudioModel({
    required this.id,
    required this.title,
    required this.artist,
    this.album,
    this.uri,
    this.duration,
    this.albumArt,
  });

  factory AudioModel.fromSongModel(SongModel song) {
    return AudioModel(
      id: song.id,
      title: song.title,
      artist: song.artist ?? 'Unknown Artist',
      album: song.album,
      uri: song.uri,
      duration: song.duration,
      albumArt: song.id.toString(),
    );
  }

  String get displayTitle => title != '<unknown>' ? title : 'Unknown Title';
  String get displayArtist => artist != '<unknown>' ? artist : 'Unknown Artist';
  
  String get durationText {
    if (duration == null) return '0:00';
    final minutes = duration! ~/ 60000;
    final seconds = (duration! % 60000) ~/ 1000;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}