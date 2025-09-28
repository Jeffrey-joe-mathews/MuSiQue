import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:musique/models/my_song.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Song> _playlist = [];
  
  int? _currentSongIndex;
  // getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  //setters
  set currentSongIndex (int? songIndex) {
    _currentSongIndex = songIndex;
    notifyListeners();
  }

  Future<void> loadSongs() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    final List<dynamic> data = jsonDecode(response);

    _playlist = data.map((json) => Song.fromJson(json)).toList();
    notifyListeners();
  }

}
