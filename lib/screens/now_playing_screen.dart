import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../providers/player_provider.dart';
import '../widgets/player_controls.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: Theme.of(context).brightness == Brightness.dark
                ? [
                    const Color(0xFF0F172A),
                    const Color(0xFF1E293B),
                    const Color(0xFF312E81),
                  ]
                : [
                    const Color(0xFFF5F5F7),
                    const Color(0xFFE8EAF6),
                    const Color(0xFFD1C4E9),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: Consumer<PlayerProvider>(
                  builder: (context, provider, child) {
                    final currentSong = provider.audioService.currentSong;
                    
                    if (currentSong == null) {
                      return _buildNoSongPlaying(context);
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          _buildAlbumArt(context, currentSong.id),
                          const SizedBox(height: 40),
                          _buildSongInfo(context, currentSong),
                          const SizedBox(height: 24),
                          StreamBuilder<bool>(
                            stream: provider.audioService.playingStream,
                            builder: (context, snapshot) {
                              final isPlaying = snapshot.data ?? false;
                              return AnimatedEqualizer(isPlaying: isPlaying);
                            },
                          ),
                          const SizedBox(height: 40),
                          ProgressBar(audioService: provider.audioService),
                          const SizedBox(height: 32),
                          PlayerControls(audioService: provider.audioService),
                          const SizedBox(height: 40),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 28,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Now Playing',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildAlbumArt(BuildContext context, int songId) {
    return Hero(
      tag: 'album_art_$songId',
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
              spreadRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: QueryArtworkWidget(
            id: songId,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Icon(
                  Icons.music_note,
                  size: 120,
                  color: Colors.white,
                ),
              ),
            ),
            artworkHeight: 300,
            artworkWidth: 300,
            artworkFit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSongInfo(BuildContext context, song) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            song.displayTitle,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            song.displayArtist,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (song.album != null && song.album != '<unknown>')
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                song.album!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNoSongPlaying(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.music_note,
            size: 80,
            color: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'No Song Playing',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Select a song to start playing',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}