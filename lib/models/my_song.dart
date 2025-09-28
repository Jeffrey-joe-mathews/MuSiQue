class Song {
  final String songName;
  final String artistName;
  final String audioPath;
  final String imagePath;
  
  Song({
    required this.songName, 
    required this.artistName, 
    required this.audioPath,
    required this.imagePath
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      songName: json['songName'],
      artistName: json['artistName'],
      audioPath: json['audioPath'],
      imagePath: json['imagePath'],
    );
  }

}