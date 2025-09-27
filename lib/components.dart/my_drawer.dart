import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          DrawerHeader(child: Icon(
            Icons.multitrack_audio_sharp,
            size: 45,
            color: Theme.of(context).colorScheme.inversePrimary
            )
          ),


          // homw
          Padding(
            padding: const EdgeInsets.only(top: 72, bottom: 0),
            child: ListTile(
              title: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.home),
                    const SizedBox(width: 8,),
                    const Text("H o M e")
                  ],
                ),
              ),
              onTap:() => Navigator.pop(context),
            ),
          ),

          // settings
          ListTile(
            title: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.settings),
                  const SizedBox(width: 8,),
                  const Text("S e T t I n G s")
                ],
              ),
            ),
            onTap: (){},
          )

          // profile
        ],
      ),
    );
  }
}