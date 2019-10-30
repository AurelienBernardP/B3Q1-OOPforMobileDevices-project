import 'dart:core' as prefix0;

import 'package:first/ItemList.dart';
import 'package:flutter/material.dart';

import 'AdTreesAppTopBar.dart';
import 'TreeScreen.dart';
import 'Planet.dart';
import 'ItemList.dart';
void main() => runApp(new TreeScreen());

class AdTreesApp extends StatelessWidget {

  Widget build(BuildContext context) {

    var screen = Scaffold(
      appBar: AdTreesAppTopBar("AdTrees!",context).getBar(),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Your money is over 9000!!'),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Go to WorldMap!'),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Planet()),
            );
              prefix0.print("worldmap");
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Get free coins'),
            onTap: () {
              prefix0.print("Get free coins");
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Go to shop!'),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemList()),
            );
              prefix0.print("go to shop");
            },
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('go planted trees list'),
            onTap: () {
              prefix0.print("tree list");
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Go to inventory!'),
            onTap: () {
              prefix0.print("inventory");
            },
          ),
        ],
      ),
    );

    return MaterialApp(title: "AdTrees", home: screen);
  }
}