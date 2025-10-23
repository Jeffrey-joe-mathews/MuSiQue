import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:musique/models/my_song.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Song> _playlist = [];
  
  int? _currentSongIndex;

  /* AUDIO PLAYER */
  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // initially not playing or playing
  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    _audioPlayer.stop();
    if (path.startsWith("http")) {
      _audioPlayer.play(UrlSource(path));
    }
    else {
      _audioPlayer.play(AssetSource(path));
    }
    _isPlaying = true;
    notifyListeners();
  }

  // puase current song
  void pause() async {
    _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause / play
  void pauseOrPlay() async {
    if (_isPlaying) {
      pause();
    }
    else {
      resume();
    }
    notifyListeners();
  }


  // skip previous
  void skipPrevious() async {
    if (_playlist.isEmpty || _currentSongIndex == null) return;
    if (_currentDuration.inSeconds < 5) {
        currentSongIndex = (_currentSongIndex! - 1)%_playlist.length;
    }
    else {
      seek(Duration.zero);
    }
    notifyListeners();
  }

  // skip next
  void skipNext() {
    if(_currentSongIndex != null && _playlist.isNotEmpty) {
      currentSongIndex = (_currentSongIndex! + 1) % _playlist.length;
    }
  }

  // seek to a specific position within the song
  void seek (Duration position) async {
    await _audioPlayer.seek(position);
  }

  // listen to duration
  void listenToDuration () {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      skipNext();
    });
  }

  // dispose audio player
  void disposePlayer () async {
    _audioPlayer.dispose();
    notifyListeners();
    
  }

  // getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //setters
  set currentSongIndex (int? songIndex) {
    _currentSongIndex = songIndex;

    if (songIndex!= null) {
      play();
    } 

    notifyListeners();
  }

  void clearCurrentSong () {
    _audioPlayer.stop();
    _currentSongIndex = null;
    notifyListeners();
  }

  void setPlaylist(List<Song> newPlaylist) {
    _playlist = newPlaylist;
    notifyListeners();
  }


  Future<void> loadSongs() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    final List<dynamic> data = jsonDecode(response);

    _playlist = data.map((json) => Song.fromJson(json)).toList();
    notifyListeners();
  }

}
