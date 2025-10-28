import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import '../providers/player_provider.dart';
import '../widgets/song_tile.dart';
import '../widgets/theme_toggle.dart';
import 'now_playing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  ]
                : [
                    const Color(0xFFF5F5F7),
                    const Color(0xFFE8EAF6),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Consumer<PlayerProvider>(
                  builder: (context, provider, child) {
                    if (!provider.permissionGranted) {
                      return _buildPermissionDenied(context, provider);
                    }

                    if (provider.isLoading) {
                      return _buildLoading(context);
                    }

                    if (provider.songs.isEmpty) {
                      return _buildEmptyState(context);
                    }

                    return _buildSongList(context, provider);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VibeTune',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
                Text(
                  'Your Music Library',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          const ThemeToggle(),
        ],
      ),
    );
  }

  Widget _buildSongList(BuildContext context, PlayerProvider provider) {
    final currentSong = provider.audioService.currentSong;
    
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: provider.songs.length,
      itemBuilder: (context, index) {
        final song = provider.songs[index];
        final isPlaying = currentSong?.id == song.id;

        return OpenContainer(
          closedElevation: 0,
          openElevation: 0,
          transitionDuration: const Duration(milliseconds: 500),
          closedColor: Colors.transparent,
          openColor: Theme.of(context).scaffoldBackgroundColor,
          closedBuilder: (context, openContainer) {
            return SongTile(
              song: song,
              isPlaying: isPlaying,
              onTap: () async {
                await provider.playSong(index);
                openContainer();
              },
            );
          },
          openBuilder: (context, closeContainer) {
            return const NowPlayingScreen();
          },
        );
      },
    );
  }

  Widget _buildPermissionDenied(BuildContext context, PlayerProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 80,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Storage Permission Required',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'VibeTune needs access to your music library to play songs.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: provider.requestPermission,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Grant Permission',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'Loading your music...',
            style: GoogleFonts.poppins(
              fontSize: 16,
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_off,
              size: 80,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'No Music Found',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Add some music files to your device and pull down to refresh.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}