import 'package:flutter/material.dart';
import 'package:musique/models/playlist_provider.dart';
import 'package:musique/pages/song_page.dart';
import 'package:provider/provider.dart';

class SongBar extends StatefulWidget {
  const SongBar({super.key});

  @override
  State<SongBar> createState() => _SongBarState();
}

class _SongBarState extends State<SongBar> {

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder:(context, value, child) {
        if (value.activeList.isEmpty) return SizedBox();

        final currentSong = value.activeList[value.currentSongIndex ?? 0];

        return GestureDetector(
          onHorizontalDragEnd: (details) {
              setState(() {
                value.clearCurrentSong();
              });
          },
          onTap:() {  
            Navigator.push(context, MaterialPageRoute(builder:(context) => const SongPage() ));
            // TODO: navigate to song page when tapped
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(100),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [

                // song image on the left because it looks cool that way
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(4),
                  // child: Image.asset(
                  //   currentSong.imagePath,
                  //   width: 40,
                  //   height: 40,
                  //   fit: BoxFit.cover,
                  //   ),
                  child: currentSong.imagePath.startsWith("http") ? Image.network(
                    currentSong.imagePath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    ) : Image.asset(
                    currentSong.imagePath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    ),
                  
                ),

                const SizedBox(width: 10,),

                // song info
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentSong.songName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white
                      ),
                    ),
                    Text(
                      currentSong.artistName,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white60,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.normal
                      ),
                    )
                  ],
                )
                ),

                // basic controls
                IconButton(onPressed: () => value.pauseOrPlay(), icon: Icon(value.isPlaying ? Icons.pause_outlined : Icons.play_arrow_outlined , color: Colors.white, size: 22,)),
                IconButton(onPressed: () => value.skipNext(), icon: Icon(Icons.skip_next_outlined , color: Colors.white, size: 22,)),
              ],
            ),
          ),
        );
      },
    );
  }
}