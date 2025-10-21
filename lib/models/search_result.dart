class SearchResult {
  final String title;
  final String artist;
  final String videoUrl;
  final String thumbnailUrl;

  SearchResult({
    required this.title,
    required this.artist,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'] ?? 'Unknown Title',
      artist: json['artist'] ?? 'Unknown Artist',
      videoUrl: json['video_url'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
    );
  }
}