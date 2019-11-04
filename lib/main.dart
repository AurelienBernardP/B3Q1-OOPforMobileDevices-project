import 'dart:core' as prefix0;

import 'package:first/ItemList.dart';
import 'package:first/TreeScreen.dart';
import 'package:first/Wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'Planet.dart';
import 'ItemList.dart';

void main() => runApp(new TreeScreen());

class AdTreesApp extends StatefulWidget {
  _AdTreesAppState createState() => _AdTreesAppState();
}

class _AdTreesAppState extends State<AdTreesApp> {
  Widget build(BuildContext context) {
    var screen = Scaffold(
        appBar: AdTreesAppTopBar("AdTrees!", context).getBar(),
        body: _buildBody(context));
    
    return MaterialApp(title: "AdTrees", home: screen);
  }


Container _buildBody(BuildContext context) {
  return Container(
    child: ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.attach_money),
          title: Text('Your money is ' + Wallet().getCoins().toString()),
          onTap: () {
            prefix0.print(Wallet().getCoins().toString());
          },
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
          onTap: () {setState(() {
            Wallet().addCoins(5);
          });
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
}
}