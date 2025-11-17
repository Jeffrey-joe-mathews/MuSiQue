import 'package:flutter/material.dart';
import 'package:musique/pages/download_page.dart';
import 'package:musique/pages/playlist_page.dart';

// --- DEMO DATA FOR SIMULATION (Same as before) ---
class Playlist {
  final String title;
  final String imageUrl;
  final bool isLarge;

  Playlist(this.title, this.imageUrl, {this.isLarge = false});
}

class Genre {
  final String name;
  final Color color;

  Genre(this.name, this.color);
}

final List<Playlist> topPlaylists = [
  Playlist('Liked Songs', 'https://picsum.photos/id/10/200/300', isLarge: true),
  Playlist('Downloads', 'https://picsum.photos/id/20/200/300', isLarge: true),
  Playlist('Last Played', 'https://picsum.photos/id/30/200/300', isLarge: true),
  Playlist('Chill Vibes', 'https://picsum.photos/id/40/200/300', isLarge: true),
  Playlist('Workout Mix', 'https://picsum.photos/id/50/200/300', isLarge: true),
  Playlist('Acoustic Covers', 'https://picsum.photos/id/60/200/300', isLarge: true),
];

final List<Genre> genres = [
  Genre('Pop Hits', Colors.purple.shade900),
  Genre('Hip Hop', Colors.red.shade900),
  Genre('Rock Classics', Colors.blue.shade900),
  Genre('Electronic', Colors.green.shade900),
  Genre('Jazz', Colors.orange.shade900),
  Genre('Indie', Colors.pink.shade900),
];
// ---------------------------------

// Define the height of the fixed bottom component for padding calculation

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Demo action for tapping a playlist/genre
  void _onTapItem(String title) {
    if (title == "Downloads") {
      Navigator.push(context, MaterialPageRoute(builder:(context) => const DownloadPage(),));
      return;
    }
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Tapped on: $title')),
    // );
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const PlaylistPage()),
  );

  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        // 1. Use a Stack to layer the scrollable content and the fixed bottom bar
        child: Stack(
          children: [
            // --- SCROLLABLE MAIN CONTENT (Top Layer) ---
            SingleChildScrollView(
              // Add padding at the bottom equal to the height of the fixed section
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header/Greeting
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onBackground,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.settings_outlined),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.notifications_none),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- 1. PLAYLIST BOXES (Top Scrollable Section) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Your Mixes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200, // Height for the horizontal scrolling playlist cards
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topPlaylists.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        final playlist = topPlaylists[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: _SmallPlaylistCard(
                            playlist: playlist,
                            onTap:() => _onTapItem(playlist.title), 
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- 2. GENRE/CATEGORIES SECTION (Middle Scrollable Section) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Explore Genres',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100, // Fixed height for the horizontal list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: genres.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        final genre = genres[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: _GenreBox(
                            genre: genre,
                            onTap: () => _onTapItem(genre.name),
                          ),
                        );
                      },
                    ),
                  ),
                  // Add more space so you can see the content scroll above the fixed bar
                  const SizedBox(height: 400),
                ],
              ),
            ),

            // --- FIXED BOTTOM GRID (Always Visible) ---
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              // Add a Material layer for elevation and shadow if desired, and background color
              child: Material(
                color: colorScheme.surface.withOpacity(0.95), // Slightly transparent background
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final playlist = topPlaylists[index];
                      // Show the first 4: Liked Songs, Downloads, Last Played, Chill Vibes (Random)
                      return _MainPlaylistTile(
                        playlist: playlist,
                        onTap: () => _onTapItem(playlist.title),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- DEMO COMPONENTS (Same as before) ---

class _MainPlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const _MainPlaylistTile({required this.playlist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.network(
                playlist.imageUrl,
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                child: Text(
                  playlist.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenreBox extends StatelessWidget {
  final Genre genre;
  final VoidCallback onTap;

  const _GenreBox({required this.genre, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: genre.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(12),
        child: Text(
          genre.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _SmallPlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const _SmallPlaylistCard({required this.playlist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130, // Fixed width for the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                playlist.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(child: Icon(Icons.music_note, size: 40)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            playlist.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Playlist',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}