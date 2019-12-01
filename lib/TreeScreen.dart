import 'package:first/Item.dart';
import 'package:first/PollutedZones.dart';
import 'package:first/Save.dart';
import 'package:first/Timer.dart';
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

  TreeScreen({Zone zone, Item treeType, String name, TreeBackEnd tree}) {
    if (tree == null)
      treeInfo = TreeBackEnd(
          zone: zone, tree: treeType, name: name != null ? name : null);
    else
      treeInfo = tree;
  }

  TreeBackEnd getTreeInfo() {
    return treeInfo;
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

  // void onValueChanged() {
  //   setState(() {

  //   });
  //   }

  @override
  void initState() {
    super.initState();

    // sets first value

    // defines a timer

    // _everySecond = Timer.periodic(Duration(seconds: 5), (Timer t) {
    //   print("pased");
    //   this.onValueChanged();
    // });
    // if(TimersForTrees().timerTreeScreen == null){
    //   TimersForTrees().setTimerForTreeScreen(this);

    // }
  }

  Widget build(BuildContext context) {
    AppBar bar = AdTreesAppTopBar(treeInfo.name, context).getBar();
    return Stack(
      children: <Widget>[
        new Container(
          height: MediaQuery.of(context).size.height / 8.5,
          width: double.infinity,
          decoration: new BoxDecoration(
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
                    flex: 7,
                    child: Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/table.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: _buildActionButtons(),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => treeInfo.getHealth(),
                                  barrierDismissible: true,
                                );
                              },
                              child: Container(
                                child: treeInfo
                                    .getHealth()
                                    .buildGeneralHealth(context),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 8,
              left: MediaQuery.of(context).size.width / 50),
          width: MediaQuery.of(context).size.height / 10,
          height: MediaQuery.of(context).size.height / 10,
          child: GestureDetector(
            onTap: () {
              ItemList.makeShop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemList()),
              );
              print("store");
            },
            child: Image.asset(
              "assets/images/shop.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  void _cannotUsePopup(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Sorry, you cannot use this item"),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok im sorry'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Widget _buildMiddleSection() {
    return Container(
      margin: EdgeInsets.only(top: 15),
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
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (!WaterItem.getInstance().useItem(treeInfo.getHealth()))
                  _cannotUsePopup(context);
                setState(() {});
                print("water plant");
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    WaterItem.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      WaterItem.getInstance().getQuantity().toString(),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (!RainItem.getInstance().useItem(treeInfo.getHealth()))
                  _cannotUsePopup(context);
                setState(() {});
                print("water plant");
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    RainItem.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      RainItem.getInstance().getQuantity().toString(),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (!NurishementItem1.getInstance()
                    .useItem(treeInfo.getHealth())) _cannotUsePopup(context);
                // if(!treeInfo.getHealth().){
                //   print("MAX");
                // }
                setState(() {});
                print("nurishemet 1");
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    NurishementItem1.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      NurishementItem1.getInstance().getQuantity().toString(),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (!NurishementItem2.getInstance()
                    .useItem(treeInfo.getHealth())) _cannotUsePopup(context);
                // if(!treeInfo.getHealth().){
                //   print("MAX");
                // }
                setState(() {});
                print("nurishement 2");
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    NurishementItem2.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      NurishementItem2.getInstance().getQuantity().toString(),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (!RepairItem.getInstance().useItem(treeInfo.getHealth()))
                  _cannotUsePopup(context);
                else {
                  setState(() {
                    Pollution.getInstance().resetPollution();
                    Pollution.getInstance()
                        .updatePollution(treeInfo.getHealth());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PollutedZones()),
                    );
                  });
                }

                print("repair");
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    RepairItem.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      RepairItem.getInstance().getQuantity().toString(),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
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
  Item plantedTree;

  TreeBackEnd(
      {Zone zone, Item tree, String name, DateTime time, Health health}) {
    image = Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(tree.getIcon()),
          fit: BoxFit.fill,
        ),
      ),
    );
    if (health == null)
      treeHealth = Health();
    else
      treeHealth = health;
    if (time == null)
      lastTimeShaken = DateTime.now();
    else
      lastTimeShaken = time;
    if (zone != null) {
      plantedZone = zone;
    }
    if (tree != null) {
      plantedTree = tree;
    }
    if (name != null) {
      this.name = name;
    } else {
      this.name = "Grooot";
    }

    TreeList().addTreeToList(this);
  }

  Zone getZone() => plantedZone;

  DateTime getLastTimeShaken() {
    return lastTimeShaken;
  }

  int getMilisecondsLeft() {
    int time = lastTimeShaken.add(Duration(minutes: 1)).millisecondsSinceEpoch -
        DateTime.now().millisecondsSinceEpoch;
    return time <= 0 ? 0 : time;
  }

  void shake() {
    print(getMilisecondsLeft());
    if (getMilisecondsLeft() <= 0) {
      lastTimeShaken = DateTime.now();
      Wallet().addCoins(7);
      Save().saveGame();
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
            "assets/images/unlocked/" +
                plantedZone.getZoneType() +
                "Unlocked.png",
          ),
          fit: BoxFit.cover),
    );
  }
}
