import 'package:flutter/material.dart';
import 'package:musique/components/musique_player.dart';
import 'package:musique/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder:
          (context, value, child) => Scaffold(
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
                          onPressed:() => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),

                        // title of the song
                        Text(
                          "SoNg NaMe",
                          style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.fade,
                          ),
                        ),

                        // menu button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu_sharp),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: MusiquePlayer(
                      child: Column(
                        children: [
                          // song image
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            child: Image.asset("assets/images/template.webp"),
                          ),

                          // song and artist name
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "song name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),

                                    Text(
                                      "artist name",
                                      style: TextStyle(
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),

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
                      Text("0:00"),
                      // shuffle
                      Icon(Icons.shuffle_rounded),
                      // repeat
                      Icon(Icons.repeat, color: Colors.green,),
                      // end time
                      Text("3:21"),
                    ],
                  ),

                  // slider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbShape: SliderComponentShape.noThumb,
                      ),
                      child: Slider(
                        min: 0,
                        max: 100,
                        value: 50, 
                        activeColor: Colors.green,
                        inactiveColor: Theme.of(context).colorScheme.secondary,
                        onChanged: (value) {},
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
                            child: MusiquePlayer(
                              child: Icon(Icons.skip_previous_outlined)
                            )
                          ),
                        ),

                        const SizedBox(width: 20,),
                        // play/pause
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            child: MusiquePlayer(
                              child: Icon(Icons.play_arrow_outlined)
                            )
                          ),
                        ),

                        const SizedBox(width: 20,),
                        // next
                        Expanded(
                          child: GestureDetector(
                            child: MusiquePlayer(
                              child: Icon(Icons.skip_next_outlined)
                            )
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
    );
  }
}
