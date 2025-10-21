import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:musique/models/my_song.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final unescape = HtmlUnescape();
  bool _isLoading = false;
  bool _isSongLoading = false;
  bool _showErrorOverlay = false;
  bool _searchStatus = false;
  List<dynamic> _results = [];
  String? _error;

  Future<void> _searchSongs(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _searchStatus = false;
      _results.clear();
    });

    try {
      final response = await http.post(
        Uri.parse("https://kamilah-overgenerous-empirically.ngrok-free.dev/search-suggestions"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"query": query}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _results = data["results"];
          _searchStatus = true;
        });
      } else {
        setState(() {
          _error = "Error ${response.statusCode}: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _error = "Failed to connect to server (Our dev team is working on it ^w^): $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                onSubmitted: _searchSongs,
                decoration: InputDecoration(
                  hintText: "Search songs...",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _searchSongs(_controller.text),
                  ),
                  suffixStyle: TextStyle(),
                ),
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_error != null)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(_error!, style: const TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                )
              else if (_results.isEmpty && _searchStatus)
                Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("No results found!"),
                    )
                  ],
                ))
              else if (_results.isEmpty && !_searchStatus)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding( 
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Search for any music you like"),
                      )
                    ],
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final song = _results[index];
                      return ListTile(
                        leading: Image.network(
                          song["thumbnail_url"],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(unescape.convert(song["title"]), style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white70
                        ),),
                        subtitle: Text(unescape.convert(song["artist"]), style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white38,
                        ),),
                        onTap: () async {
                          setState(() {
                            _isSongLoading = true;
                          });

                          // for test purpose 
                          // print(song);
                          // await Future.delayed(Duration(seconds: 5));

                          final videoUrl = song["video_url"];

                          try {
                            final response = await http.post(
                              Uri.parse("https://kamilah-overgenerous-empirically.ngrok-free.dev/get-audio-info"),
                              headers:{"Content-Type": "application/json"},
                              body: jsonEncode({"url" : videoUrl})
                            );
                            
                            if (response.statusCode == 200) {
                              final data = jsonDecode(response.body);
                              print(data); // simple debugging
                              final song = Song(
                                songName: data["title"], 
                                artistName: data["artist"], 
                                audioPath: data["audio_url"], 
                                imagePath: data["thumbnail_url"]
                              );
                              // TODO: logic to move to the next page probably material builder
                            }

                            else {
                              print("Failed with status: ${response.statusCode}");
                              print("Body: ${response.body}");
                              setState(() {
                                _showErrorOverlay = true;
                              });
                            }
                          } catch (e) {
                            print("Error fetching audio info!");
                            _showErrorOverlay = true;
                          }

                          finally {
                            setState(() {
                              _isSongLoading = false;
                            });
                          }                    

                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        if (_isSongLoading)
          Container(
            color: Colors.black.withAlpha(225),
            child: Center(
              child: Lottie.asset('assets/animations/astronaut_music.json', width: 200, height: 200, repeat: true),
            ),
          )
        else if (_showErrorOverlay)
          GestureDetector(
            onTap:() {
              setState(() {
                _showErrorOverlay = false;
              });
            },
              child: Container(
                color: Colors.black.withAlpha(225),
                child: Center(
                  child: Lottie.asset(
                    'assets/animations/404_error.json',
                    width: 250,
                    height: 250,
                    repeat: true,
                  ),
                            ),
              ),
          )
        ],
      ),
    );
  }
}
