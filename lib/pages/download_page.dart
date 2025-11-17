import 'package:flutter/material.dart';
import 'package:musique/models/my_song.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  // Dummy data representing downloaded songs
  final List<Song> downloadedSongs = [
    Song(
      songName: "The Night Driver",
      artistName: "Synthwave Collective",
      imagePath: 'assets/image1.jpg',
      audioPath: 'audio/driver.mp3',
    ),
    Song(
      songName: "Pixel Dreams",
      artistName: "8-Bit Wizard",
      imagePath: 'assets/image2.jpg',
      audioPath: 'audio/dreams.mp3',
    ),
    Song(
      songName: "Echoes of Tomorrow",
      artistName: "Aura",
      imagePath: 'assets/image3.jpg',
      audioPath: 'audio/echoes.mp3',
    ),
    Song(
      songName: "Lost in Translation",
      artistName: "",
      imagePath: 'assets/image4.jpg',
      audioPath: 'audio/lost.mp3',
    ),
    // Add many entries to ensure scrollability
    for (int i = 5; i < 20; i++)
      Song(
        songName: "Downloaded Track $i",
        artistName: "The Musique User",
        imagePath: 'assets/placeholder.jpg',
        audioPath: 'audio/track$i.mp3',
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Text(
          "Downloads",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        // Add padding to match the style of other content pages
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        itemCount: downloadedSongs.length,
        itemBuilder: (context, index) {
          final song = downloadedSongs[index];
          return ListTile(
            leading: const Icon(
              Icons.music_note,
              color: Colors.green, // A distinct color for a downloaded status icon
            ),
            title: Text(
              song.songName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            // Use the null-coalescing operator (??) to display "Unknown Artist" 
            // if the artistName is null, matching the logic we discussed earlier.
            subtitle: Text(
              song.artistName ?? "Unknown Artist", 
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // TODO: Implement options menu for the downloaded song
              },
            ),
            onTap: () {
              // TODO: Implement logic to play the downloaded song
              print("Playing downloaded song: ${song.songName}");
            },
          );
        },
      ),
      
    );
  }
}
