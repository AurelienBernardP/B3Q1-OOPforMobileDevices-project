import 'package:first/ItemList.dart';
import 'package:first/TreeList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'Planet.dart';
import 'ItemList.dart';
import 'TreeList.dart';
import 'Timer.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        new Container(
          height: height/8.5,
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
      body: Stack(
      children: <Widget>[
        Container(
        decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/treemap.jpeg"), 
                  fit: BoxFit.cover,),
                ),
          ),
            Container(
            margin: new EdgeInsets.only(left: width/24, right: width/22, bottom: height/5),
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/menu.png"), 
                  fit: BoxFit.fill,),
                ),
        child: Container( 
          margin: new EdgeInsets.only(top: height/4, left: width/17, right: width/15),
          child: ListView(
            
          children: <Widget>[
            Container(
                decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/window.png"),
              fit: BoxFit.fill,
            ),
          ),
                child:ListTile(
              title: Text('Worldmap', overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: width/15,
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
              
                decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/window.png"),
              fit: BoxFit.fill,
            ),
          ),
                child: ListTile(
              title:  Text('Shop', overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: width/15,
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

            Container(
              
                decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/window.png"),
              fit: BoxFit.fill,
            ),
          ),
                child:ListTile(
              //leading: Icon(Icons.work),
              title: Text('Inventory', overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: width/15,
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
              
                decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/window.png"),
              fit: BoxFit.fill,
            ),
          ),
                child: ListTile(
              //leading: Icon(Icons.view_list),
              title: Text('Tree list', overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: width/15,
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
      ],
      ),
        ),
      ],
    );
  }
}
