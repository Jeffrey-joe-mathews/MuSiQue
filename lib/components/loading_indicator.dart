import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:musique/models/search_result.dart';

class LoadingIndicatorDialog extends StatelessWidget {
  final SearchResult song;

  const LoadingIndicatorDialog({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            Lottie.asset(
              'assets/animations/astronaut_music.json',
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 20),
            Text(
              "Preparing your track...",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 15),
            // Song Info
            Text(
              song.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              song.artist,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
