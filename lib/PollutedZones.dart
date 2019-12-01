import 'dart:math';
import 'package:first/AdTreesAppTopBar.dart';
import 'package:first/PollutionItem.dart';
import 'package:flutter/material.dart';
import 'Wallet.dart';
import 'Health.dart';
//import 'package:flutter/widgets.dart';

class PollutedZones extends StatefulWidget {
  @override
  _PollutedZonesState createState() => _PollutedZonesState();
}

class _PollutedZonesState extends State<PollutedZones> with TickerProviderStateMixin{

  int _dragged = 0;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Pollution", 
    home: Stack(
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
          appBar:  AdTreesAppTopBar('Clean It Up!', context).getBar(),
          body: _buildBody(),
        ),
      ],
    ),
    ) ;
  }

Widget _createDraggable(BuildContext context, int index){
  if(Pollution.getInstance().getPollutionItem(index).isVisible())
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          _dragged = index;
        });
        }, 
            child: Draggable(
              data: Pollution.getInstance().getPollutionItem(index).getType(),
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(Pollution.getInstance().getPollutionItem(index).getImage()), 
                  fit: BoxFit.fill,),
                ),
              ),
              feedback: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(Pollution.getInstance().getPollutionItem(index).getImage()), 
                  fit: BoxFit.fill,),
                ),
              ),
              childWhenDragging: Container(width: 50.0,
                height: 50.0,),
            ),
            );
    return Container(width: 50, height: 50);
  }

  Widget _createPollution(){
    return Flexible(
    child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              childAspectRatio: 1.0,
            ),
            itemBuilder: _createDraggable,
            itemCount: 72,),
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

          children: <Widget>[
            _createPollution(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                      return Center(
                        child: Container(
                        decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/compost.png"), 
                            fit: BoxFit.fill,),
                          ),
                        ),
                      );
                    },
                    onWillAccept: (data) {
                      if(data % 2 == 0)
                        return true;
                      return false;
                    },
                    onAccept: (data) {
                      setState(() {
                        Pollution.getInstance().removePollution();
                        Pollution.getInstance().getPollutionItem(_dragged).makeInvisible();
                        if(Pollution.getInstance().getCurPollutionNb() == 0){
                          Wallet().addCoins(Pollution.getInstance().getPollutionNb());
                          Pollution.getInstance().getHealthState().cleanTree();
                        }
                      });
                    },
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                      return Center(
                        child: Container(
                        decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/recycle.png"), 
                            fit: BoxFit.fill,),
                          ),
                        ),
                      );
                    },
                    onWillAccept: (data) {
                      if(data % 2 != 0)
                        return true;
                      return false;
                    },
                    onAccept: (data) {
                      setState(() {
                        Pollution.getInstance().removePollution();
                        Pollution.getInstance().getPollutionItem(_dragged).makeInvisible();
                        if(Pollution.getInstance().getCurPollutionNb() == 0){
                          Wallet().addCoins(Pollution.getInstance().getPollutionNb());
                          Pollution.getInstance().getHealthState().cleanTree();
                        }
                      });
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

class Pollution{  
  static Pollution _instance;
  List<PollutionItem> _pollutionList = [];
  Map<int, PollutionItem> _pollutionMap;
  int _nbPol;
  int _curNbPol;
  Health _healthState;

  Pollution._internal() {
    for(int i = 0; i < 72; i++)
      _pollutionList.add(PollutionItem());
    _pollutionMap = _pollutionList.asMap();
  }
  
  static Pollution getInstance() {
    if (_instance == null) {
      _instance = Pollution._internal();
    }
    return _instance;
  }

  void updatePollution(Health healthBar){
    _healthState = healthBar;
    _nbPol = healthBar.getNbPollutions();
    _curNbPol = _nbPol;
    for(int i = _nbPol; i > 0; i--)
      _pollutionMap[Random().nextInt(56)].makeVisible(Random().nextInt(4));
  }

  PollutionItem getPollutionItem(int index){
    return _pollutionMap[index];
  }

  void resetPollution(){
    for(int i = 0; i < 72; i++){
      _pollutionMap[i].makeInvisible();
    }
  }

  void removePollution(){
    _curNbPol--;
  }

  int getCurPollutionNb(){
    return _curNbPol;
  }

  int getPollutionNb(){
    return _nbPol;
  }

  Health getHealthState(){
    return _healthState;
  }

}