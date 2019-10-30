import 'package:flutter/material.dart';

class AdTreesAppTopBar extends AppBar {
  final String text = "AdTrees";
  AppBar bar;

  AdTreesAppTopBar(String text, BuildContext context) {
    this.text.replaceAll('AdTrees', text);
    Widget button = IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
      },
    );

    AppBar bar = new AppBar(
      title: Text(text),
      backgroundColor: Colors.green,
      actions: <Widget>[button],
    );
    this.bar = bar;
  }
  AppBar getBar() => bar;
}

class SettingsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings"),
      ),
      backgroundColor: Colors.green,
      body: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go back!'),
      ),
    );
  }
}
