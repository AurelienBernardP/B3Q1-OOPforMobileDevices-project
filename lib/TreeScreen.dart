import 'package:first/Item.dart';
import 'package:first/TreeList.dart';

import 'Health.dart';

import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'Wallet.dart';
import 'ItemList.dart';
import 'Zone.dart';
import 'dart:async';
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
  Timer _everySecond;
  TreeScreenBodyState(TreeBackEnd info) {
    treeInfo = info;
  }

  @override
  void initState() {
    super.initState();

    // sets first value

    // defines a timer 
    _everySecond = Timer.periodic(Duration(seconds: 5), (Timer t) {
      print("pased");
      setState(() {
        
      });
    });
  }

  Widget build(BuildContext context) {
    AppBar bar = AdTreesAppTopBar(treeInfo.name, context).getBar();
    return Scaffold(
      appBar: bar,
      body: Container(
        decoration: treeInfo.getBackground(),
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
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => treeInfo.getHealth(),
                    barrierDismissible: true,
                  );
                },
                child: Container(
                  child: treeInfo.getHealth().buildGeneralHealth(context),
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
              },
              child: Container(
                child: treeInfo.getImage(),
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
                child: Icon(Icons.add_shopping_cart),
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
                child: Icon(Icons.work),
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
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/water.png'),
                    fit: BoxFit.fill,
                  ),
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
    image = Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(tree.getIcon()),
          fit: BoxFit.cover,
        ),
      ),
    );
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

    TreeList().addTreeToList(this);

  }
  int getMilisecondsLeft(){
    int time = lastTimeShaken.add(Duration(minutes: 1)).millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
    return time <= 0 ? 0: time;

  }
  void shake() {
    print(getMilisecondsLeft());
    if (getMilisecondsLeft() <= 0) {
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
  String getName() => name;
  BoxDecoration getBackground() {
    return BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage(
          "assets/images/unlocked/"+plantedZone.getZoneType()+"Unlocked.png",
        ),fit: BoxFit.cover
      ),
    );
  }
}
