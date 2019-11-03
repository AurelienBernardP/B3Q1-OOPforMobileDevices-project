import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';

class TreeScreen extends StatelessWidget {
  
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
                    child: Text("health bar section"),
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
                print("get money");
              },
              child: Container(
                child: Icon(Icons.attach_money),
                decoration: BoxDecoration(color: Colors.amberAccent),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                print("see money");
              },
              child: Container(
                child: Icon(Icons.attach_money),
                decoration: BoxDecoration(color: Colors.amber),
              ),
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
              onTap: () {
                print("tree section");
              },
              child: Container(
                child: Text("tree image"),
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
