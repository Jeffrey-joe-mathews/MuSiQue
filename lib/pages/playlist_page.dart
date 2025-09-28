import 'package:flutter/material.dart';
import 'package:musique/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return; 
      Provider.of<PlaylistProvider>(context, listen: false).loadSongs();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text("PlAyLiSt 1")),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final playlist = value.playlist;

          if (playlist.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final song = playlist[index];
              return ListTile(
                leading: Image.asset(
                  song.imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                },
              );
            },
          );
        },
      ),
    );
  }
}
