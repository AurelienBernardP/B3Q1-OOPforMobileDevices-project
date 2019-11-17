import 'dart:math';

import 'package:first/AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class PollutedZones extends StatefulWidget {
  @override
  _PollutedZonesState createState() => _PollutedZonesState();
}

class _PollutedZonesState extends State<PollutedZones> with TickerProviderStateMixin{

  //final _random = new Random();
  //int garbageNumber(int min, int max) => 0 + _random.nextInt(12 - 0);
  double garbageNumber = 12.0;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AdTreesAppTopBar("Clean It Up!", context).getBar(),
      body: _buildBody(),
    );
  }

Widget _createDraggable(){
  return Draggable(
              data: 5,
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/20.png"), 
                  fit: BoxFit.fill,),
                ),
                /*child: Center(
                  //child: Text(
                    "5",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.pink,*/
              ),
              feedback: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/20.png"), 
                  fit: BoxFit.fill,),
                ),
                /*child: Center(
                  child: Text(
                    "5",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.pink,*/
              ),
              childWhenDragging: Container(width: 50.0,
                height: 50.0,),
            );
  }

Widget _makeDraggables(double i){
  //for(double i = 0; i < garbageNumber; i++ )
  return Positioned(
            top: i,
            right: i,
            child: _createDraggable()
        );
  }

  Widget _buildBody(){
    return Container(
        decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/polluted.png"), 
                  fit: BoxFit.fill,),
        ),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _createDraggable(),
            _createDraggable(),
            _createDraggable(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.green,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                      print(candidateData);
                      return Center(child: Text("PMC", style: TextStyle(color: Colors.white, fontSize: 22.0),));
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      if(data % 2 == 0) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Correct!")));
                      } else {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Wrong!")));
                      }
                    },
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.deepPurple,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                      return Center(child: Text("Bio", style: TextStyle(color: Colors.white, fontSize: 22.0),));
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      if(data % 2 != 0) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Correct!")));
                      } else {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Wrong!")));
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
      );
    
  }

}