import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../models/song_model.dart';

class SongTile extends StatelessWidget {
  final AudioModel song;
  final VoidCallback onTap;
  final bool isPlaying;

  const SongTile({
    Key? key,
    required this.song,
    required this.onTap,
    this.isPlaying = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isPlaying
            ? theme.primaryColor.withOpacity(0.1)
            : theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,
        leading: Hero(
          tag: 'album_art_${song.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: QueryArtworkWidget(
              id: song.id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor.withOpacity(0.7),
                      theme.colorScheme.secondary.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.music_note,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              artworkHeight: 56,
              artworkWidth: 56,
              artworkFit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          song.displayTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: isPlaying ? theme.primaryColor : null,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          song.displayArtist,
          style: TextStyle(
            fontSize: 13,
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              song.durationText,
              style: TextStyle(
                fontSize: 12,
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isPlaying ? Icons.equalizer : Icons.play_arrow,
              color: isPlaying ? theme.primaryColor : theme.iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}