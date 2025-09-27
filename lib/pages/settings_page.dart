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
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Let there be Light", style: TextStyle(fontWeight: FontWeight.bold),),
          
          CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context, listen: false).isLightMode, 
            onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme()
          )
        ],
      )),
    );
  }
}