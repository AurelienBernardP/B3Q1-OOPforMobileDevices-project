import 'Health.dart';

import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'Wallet.dart';

class TreeScreen extends StatefulWidget {
  @override
  _TreeScreenState createState() => _TreeScreenState();
}

class _TreeScreenState extends State<TreeScreen> {
  TreeBackEnd treeInfo = TreeBackEnd();
  
  @override
  Widget build(BuildContext context) {
    Widget screen = MaterialApp(
      title: "screen",
      theme: ThemeData.light(),
      home: _buildScaffold(context),
    );
    return screen;
  }

  Widget _buildScaffold(BuildContext context) {
    AppBar bar = AdTreesAppTopBar("tree name!", context).getBar();
    return Scaffold(
      appBar: bar,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _buildCoinSection(),
            ),
            Expanded(
              flex: 7,
              child: _buildMiddleSection(),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    print("health bar");
                  },
                  child: Container(
                    child: Text("health bar box"),
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

  Widget _buildCoinSection() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
          Expanded(
            flex: 4,
              child: Container(
                child: Text("available coins : " + Wallet().getCoins().toString()),
                decoration: BoxDecoration(color: Colors.amber),
              ),
            
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 1, child: _buildActionButtons()),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () { setState(() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                print("water plant");
              },
              child: Container(
                child: Text("water"),
                decoration: BoxDecoration(color: Colors.blue),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
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
        ],
      ),
    );
  }
}

class TreeBackEnd{
  Health treeHealth;
  Widget image;
  DateTime lastTimeShaken;

  TreeBackEnd(){
    treeHealth = Health();
    image = Text("tree image");
    lastTimeShaken = DateTime.now();
    print(lastTimeShaken.toString());
  }

  void shake(){
    print(DateTime.now().toString());
    print(lastTimeShaken.add(Duration(minutes: 1)).toString());
    if(DateTime.now().isAfter(lastTimeShaken.add(Duration(minutes: 1)))){
      lastTimeShaken = DateTime.now();
      Wallet().addCoins(7);
    }
  }

  Widget getImage(){
    return image;
  }

  Health getHealth(){
    return treeHealth;
  }
}