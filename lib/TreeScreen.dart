import 'package:first/Item.dart';

import 'Health.dart';

import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'Wallet.dart';
import 'ItemList.dart';
import 'Zone.dart';

class TreeScreen extends StatefulWidget {
  TreeBackEnd treeInfo;

  TreeScreen({Zone location, Item treeType, String name}) {
    treeInfo = TreeBackEnd(
        zone: location, tree: treeType, name: name != null ? name : null);
  }
  @override
  TreeScreenBodyState createState() => TreeScreenBodyState(treeInfo);
}

class TreeScreenBodyState extends State<TreeScreen> {
  TreeBackEnd treeInfo;

  TreeScreenBodyState(TreeBackEnd info) {
    treeInfo = info;
  }
  Widget build(BuildContext context) {
    AppBar bar = AdTreesAppTopBar(treeInfo.name, context).getBar();
    return Scaffold(
      appBar: bar,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(
              flex: 18,
              child: _buildMiddleSection(),
            ),
            Expanded(
              flex: 2,
              child: _buildActionButtons(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => treeInfo.getHealth(),
                      barrierDismissible: false,
                    );
                  },
                  child: Container(
                    child: treeInfo.getHealth().buildGeneralHealth(context),
                    decoration: BoxDecoration(color: Colors.amberAccent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  treeInfo.shake();
                });
                print("tree section");
              },
              child: Container(
                child: treeInfo.getImage(),
                decoration: BoxDecoration(color: Colors.greenAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemList()),
                );
                print("store");
              },
              child: Container(
                child: Text("store"),
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                print("inventory");
              },
              child: Container(
                child: Text("inventory"),
                decoration: BoxDecoration(color: Colors.blueGrey),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                print("water plant");
              },
              child: Container(
                child: Text("water"),
                decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/images/water.png'), 
                  fit: BoxFit.fill,),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Wallet().addCoins(5);
                });
              },
              child: Container(
                child: Icon(Icons.attach_money),
                decoration: BoxDecoration(color: Colors.amberAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TreeBackEnd {
  Health treeHealth;
  Widget image;
  Zone plantedZone;
  DateTime lastTimeShaken;
  String name;
  Item planetdTree;

  TreeBackEnd({Zone zone, Item tree, String name}) {
    image = Container(decoration : BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(tree.getIcon()), 
                  fit: BoxFit.cover,),
                ),);
    treeHealth = Health();
    lastTimeShaken = DateTime.now();
    if (zone != null) {
      plantedZone = zone;
    }
    if (tree != null) {
      planetdTree = tree;
    }
    if (name != null) {
      this.name = name;
    } else {
      this.name = "Grooot";
    }
  }

  void shake() {
    print(DateTime.now().toString());
    print(lastTimeShaken.add(Duration(minutes: 1)).toString());
    if (DateTime.now().isAfter(lastTimeShaken.add(Duration(minutes: 1)))) {
      lastTimeShaken = DateTime.now();
      Wallet().addCoins(7);
    }
  }

  Widget getImage() {
    return image;
  }

  Health getHealth() {
    return treeHealth;
  }
}
