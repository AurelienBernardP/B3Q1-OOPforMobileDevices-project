
import 'package:flutter/material.dart';
import 'Guide.dart';
import 'Wallet.dart';
class AdTreesAppTopBar {
  final String text = "AdTrees";
  AppBar bar;

  AdTreesAppTopBar(String text,BuildContext context) {
    this.text.replaceAll('AdTrees', text);

    Widget settingsButton = IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Guide()),
        );
      },
    );

    Widget backButton = IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      bar = new AppBar(
      title: Center(child: Text(text +" | You have "+ Wallet().getCoins().toString() + "C")),
      backgroundColor: Colors.green,
      leading: Navigator.canPop(context) ? backButton : null,
      actions: <Widget>[ settingsButton],
    );
    this.bar = bar;
  }
  AppBar getBar() => bar;
}