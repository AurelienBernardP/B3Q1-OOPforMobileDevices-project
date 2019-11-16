import 'package:first/ItemList.dart';
import 'package:flutter/material.dart';
import 'Guide.dart';

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

    Widget inventoryButton = IconButton(
      icon: Icon(Icons.work),
      onPressed: () {
        Route route = MaterialPageRoute(builder: (context) => ItemList());
        if(!route.isCurrent){
        ItemList.makeInventory();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemList()),
        );}
      },
    );

    Widget backButton = IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      bar = new AppBar(
      title: Text(text),
      backgroundColor: Colors.green,
      leading: Navigator.canPop(context) ? backButton : null,
      actions: <Widget>[inventoryButton, settingsButton],
    );
    this.bar = bar;
  }
  AppBar getBar() => bar;
}