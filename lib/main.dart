import 'package:first/ItemList.dart';
import 'package:first/Wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'Planet.dart';
import 'ItemList.dart';

void main() => runApp(new AdTreesApp());

class AdTreesApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(title: "AdTrees", home: _AdTreesAppBody());
  }
}

class _AdTreesAppBody extends StatefulWidget {
  __AdTreesAppBodyState createState() => __AdTreesAppBodyState();
}

class __AdTreesAppBodyState extends State<_AdTreesAppBody> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdTreesAppTopBar("AdTrees!", context).getBar(),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Your money is ' + Wallet().getCoins().toString() + " coins"),
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Get free coins'),
              onTap: () {
                setState(() {
                  Wallet().addCoins(5);
                });
                print("Get free coins");
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
                print("worldmap");
              },
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('Go to shop!'),
              onTap: () {
                ItemList.makeShop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemList()),
                );
                print("go to shop");
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('go planted trees list'),
              onTap: () {
                print("tree list");
              },
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Go to inventory!'),
              onTap: () {
                ItemList.makeInventory();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
