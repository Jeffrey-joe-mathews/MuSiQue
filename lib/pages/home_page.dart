import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:musique/components/song_bar.dart';
import 'package:musique/models/playlist_provider.dart';
import 'package:musique/pages/home_screen.dart';
import 'package:musique/pages/playlist_page.dart';
import 'package:musique/pages/search_page.dart';
import 'package:musique/pages/settings_page.dart';
import 'package:musique/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchPage(),
    // PlaylistPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      //// old app bar
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Row(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Icon(Icons.multitrack_audio_outlined),
      //       const SizedBox(width: 16,),
      //       Text("M U S I Q U E")
      //     ],
      //   ),
      // ),
      // drawer: MyDrawer(),

      // dynamic app bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Consumer<PlaylistProvider>(
          builder: (context, value, child) {
            final songSelectedYN =
                value.playlist.isNotEmpty && value.currentSongIndex != null;

            return AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 10,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (songSelectedYN)
                    const SongBar()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.multitrack_audio_outlined),
                        SizedBox(width: 8),
                        Text("M U S I Q U E"),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500,
        activeColor: isDarkMode ? Colors.white : Colors.black87,
        gap: 8,
        tabs: [
          GButton(icon: Icons.home_outlined, text: "H O M E"),
          GButton(icon: Icons.search_outlined, text: "S E A R C H"),
          // GButton(icon: Icons.album, text: "L I B R A R Y"),
          GButton(icon: Icons.settings_outlined, text: "S E T T I N G S"),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
