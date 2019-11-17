import 'package:first/Item.dart';

import 'Health.dart';

import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'Wallet.dart';
import 'ItemList.dart';
import 'Timer.dart';
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
                    barrierDismissible: false,
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
        ),
      ],
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
          fit: BoxFit.fitWidth,
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

    TimersForTrees().addTreeToTimer(this);

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
