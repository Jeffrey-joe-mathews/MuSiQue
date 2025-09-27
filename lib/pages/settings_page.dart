import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musique/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SeTtInGs"),centerTitle: true,),
      body: Expanded(child: Row(
        children: [
          Text("Let there be Light"),
          
          CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context, listen: false).isLightMode, 
            onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme()
          )
        ],
      )),
    );
  }
}