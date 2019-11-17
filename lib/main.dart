import 'package:first/ItemList.dart';
import 'package:first/TreeList.dart';
import 'package:first/TreeScreen.dart';
import 'package:first/Wallet.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'Planet.dart';
import 'ItemList.dart';
import 'PollutedZones.dart';
import 'Timer.dart';
import 'TreeList.dart';
import 'package:admob_flutter/admob_flutter.dart';
void main() { 

    //Admob.initialize('ca-app-pub-3940256099942544~3347511713');
    runApp(new AdTreesApp());
    
}

class AdTreesApp extends StatelessWidget {
  Widget build(BuildContext context) {
    TimersForTrees().timers();
    return MaterialApp(title: "AdTrees", home: _AdTreesAppBody());
  }
}

class _AdTreesAppBody extends StatefulWidget {
  __AdTreesAppBodyState createState() => __AdTreesAppBodyState();
}

class __AdTreesAppBodyState extends State<_AdTreesAppBody> {
  
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          height: MediaQuery.of(context).size.height/8.5,
          width: double.infinity,
          decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/table.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
      appBar: AdTreesAppTopBar("AdTrees!", context).getBar(),
      body: Container(
        decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/mainmenu.png"), 
                  fit: BoxFit.cover,),
                ),
        child: ListView(
          children: <Widget>[
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
              title: Text('polluted zone'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PollutedZones()),
                );
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
                        ListTile(
              leading: Icon(Icons.view_list),
              title: Text('tree list'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TreeListScreen()),
                );
              },
            ),
          ],
        ),
      ),
        ),
      ],
    );
  }
}
