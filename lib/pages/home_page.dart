import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:musique/components/my_drawer.dart';
import 'package:musique/pages/home_screen.dart';
import 'package:musique/pages/playlist_page.dart';
import 'package:musique/pages/playlists_page.dart';
import 'package:musique/pages/search_page.dart';

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
    // PlaylistsPage()
    PlaylistPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.multitrack_audio_outlined),
            const SizedBox(width: 16,),
            Text("M U S I Q U E")
          ],
        ),
      ),
      // drawer: MyDrawer(),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        color: Colors.grey.shade700,
        activeColor: Colors.white,
        gap: 8,
        tabs: [
          GButton(icon: Icons.home_outlined, text: "H O M E",),
          GButton(icon: Icons.search_outlined, text: "S E A R C H",),
          GButton(icon: Icons.album, text: "L I B R A R Y")
        ]
      ),
      body: _pages[_selectedIndex],
    );
  }
}