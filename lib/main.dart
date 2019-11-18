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
        child: Container( 
          margin: new EdgeInsets.only(top: 160.0, left: 30.0),
          child: ListView(
            padding: EdgeInsets.only(top:10.0),
          children: <Widget>[
            Container(
                decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/window.png"),
              fit: BoxFit.fill,
            ),
          ),
                child:ListTile(
              //leading: Icon(Icons.map),
              title: Text('Go to WorldMap!', overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: Colors.blueGrey[200],
      ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Planet()),
                );
              },
            ),),
            Container(
              margin: EdgeInsets.only(right: 30),
                decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/window.png"),
              fit: BoxFit.fill,
            ),
          ),
                child: ListTile(
              //leading: Icon(Icons.add_shopping_cart),
              title:  Text('Go to shop!', overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: Colors.blueGrey[200],
      ),),
              onTap: () {
                ItemList.makeShop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemList()),
                );
              },
            ),),
              //leading: Icon(Icons.view_list),

            Container(
              margin: EdgeInsets.only(right: 30),
                decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/window.png"),
              fit: BoxFit.fill,
            ),
          ),
                child:ListTile(
              //leading: Icon(Icons.work),
              title: Text('Go to inventory!', overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: Colors.blueGrey[200],
      ),),
              onTap: () {
                ItemList.makeInventory();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemList()),
                );
              },
            ),),
              Container(
              margin: EdgeInsets.only(right: 30),
                decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/window.png"),
              fit: BoxFit.fill,
            ),
          ),
                child: ListTile(
              //leading: Icon(Icons.view_list),
              title: Text('See tree list', overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: Colors.blueGrey[200],
      ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TreeListScreen()),
                );
              },
            ),
            ),
          ],
        ),
        ),
      ),
        ),
      ],
    );
  }
}
