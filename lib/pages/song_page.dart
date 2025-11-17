import 'package:flutter/material.dart';
import 'package:musique/components/musique_player.dart';
import 'package:musique/models/playlist_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> openArtistLicense(String artistName) async {
    final url = Uri.parse("https://$artistName.bandcamp.com");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  void showArtistLicensePopup(BuildContext context, String artistName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Artist License"),
          content: Text("Open license page for $artistName?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openArtistLicense(artistName);
              },
              child: Text("Open"),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder:
          (context, value, child) {

            final playlist = value.activeList;

            final currentSong = playlist[value.currentSongIndex ?? 0];

            return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // back button
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),

                        // title of the song
                        Text(
                          "Song Name",
                          style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.fade,
                          ),
                        ),

                        // menu button
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(Icons.menu_sharp),
                        // ),

                        PopupMenuButton(
                          icon: const Icon(Icons.menu_sharp),
                          onSelected: (value) {
                          if (value == "licenses") {
                            final artist = (currentSong.artistName ?? "unknown")
                                .toLowerCase()
                                .replaceAll(" ", "");  // Adjust for URL 
                            showArtistLicensePopup(context, artist);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: "licenses",
                            child: Text("View Artist License"),
                          ),
                        ],
                        ),


                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 45),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: MusiquePlayer(
                                child: Column(
                                  children: [
                                    // song image
                                    // ClipRRect(
                                    //   borderRadius: BorderRadiusGeometry.circular(8),
                                    //   child: currentSong.imagePath.startsWith("http") ? Image.network(currentSong.imagePath) : Image.asset(currentSong.imagePath),
                                    //   ),
                                   LayoutBuilder(
                                      builder: (context, constraints) {
                                        final maxWidth = constraints.maxWidth;
                        
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: SizedBox(
                                            width: maxWidth,
                                            height: maxWidth, // same as width → square
                                            child: currentSong.imagePath.startsWith("http")
                                                ? Image.network(
                                                    currentSong.imagePath,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    currentSong.imagePath,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                         
                                    // song and artist name
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  currentSong.songName,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                            
                                                Text(
                                                  currentSong.artistName ?? "Unknown",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                        
                                          const SizedBox(width: 15,),
                        
                                          Icon(Icons.favorite, color: Colors.red),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        
                            // song duration progress
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // start time
                                Text(formatDuration(value.currentDuration)),
                                // shuffle
                                Icon(Icons.shuffle_rounded),
                                // repeat
                                Icon(Icons.repeat, color: Colors.green),
                                // end time
                                Text(formatDuration(value.totalDuration)),
                              ],
                            ),
                        
                            // slider
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8,
                              ),
                              child: SliderTheme(
                                data: SliderThemeData(
                                  thumbShape: SliderComponentShape.noThumb,
                                ),
                                child: Slider(
                                  min: 0,
                                  max: value.totalDuration.inSeconds.toDouble(),
                                  value: value.currentDuration.inSeconds.clamp(0, value.totalDuration.inSeconds).toDouble(),
                                  activeColor: Colors.green,
                                  inactiveColor:
                                      Theme.of(context).colorScheme.secondary,
                                  onChanged: (double double) {
                                    // when the user is dragging the slider around 
                                  },
                                  onChangeEnd:(double double) {
                                    // sliding has finished, we g to that position in the song
                                    value.seek(Duration(seconds: double.toInt()));
                                  },
                                  
                                ),
                              ),
                            ),
                        
                            // controls
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  // prev
                                  Expanded(
                                    child: GestureDetector(
                                      onTap:() => value.skipPrevious(),
                                      child: MusiquePlayer(
                                        child: Icon(Icons.skip_previous_outlined),
                                      ),
                                    ),
                                  ),
                        
                                  const SizedBox(width: 20),
                                  // play/pause
                                  Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      onTap: () => value.pauseOrPlay(),
                                      child: MusiquePlayer(
                                        child: Icon(!value.isPlaying ? Icons.play_arrow_outlined : Icons.pause_outlined),
                                      ),
                                    ),
                                  ),
                        
                                  const SizedBox(width: 20),
                                  // next
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => value.skipNext(),
                                      child: MusiquePlayer(
                                        child: Icon(Icons.skip_next_outlined),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // till here
                ],
              ),
            ),
          );
          }
    );
  }
}
