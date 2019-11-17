import 'dart:math';

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
      appBar: AppBar(),
      body: _buildBody(),
    );
  }



  Widget _buildBody(){
    return Container(
        decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/polluted.png"), 
                  fit: BoxFit.fill,),
        ),
        SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 12.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CardStackWidget(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DragTargetWidget(),
              )
            ],
          ),
        ),
        ),
);
}}