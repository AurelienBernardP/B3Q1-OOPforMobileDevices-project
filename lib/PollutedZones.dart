import 'dart:math';
import 'package:first/AdTreesAppTopBar.dart';
import 'package:first/PollutionItem.dart';
import 'package:flutter/material.dart';
import 'Wallet.dart';
import 'Health.dart';

class PollutedZones extends StatefulWidget {
  @override
  _PollutedZonesState createState() => _PollutedZonesState();
}

class _PollutedZonesState extends State<PollutedZones> with TickerProviderStateMixin{

  int _dragged = 0; //variable used to detect the current PollutionItem being dragged
  //GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

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

  /* creates an AlertDialog; this function will be called when the 
   * player removes all the garbage from the screen
   */
  void _cleanedPopup(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("All clean!"),
      content: Row(children: <Widget>[
        Text(
          "Congratulations, you got rid of the garbage.",
          maxLines: 1,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
      ]),
      actions: <Widget>[
        FlatButton(
          child: Text('Back to tree'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pop(context);
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
                          _cleanedPopup(context);
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
                          _cleanedPopup(context);
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

/*
 * Pollution class
 * Attributes:
 *    pollutionList: a list containing all the pollution items of the screen
 *    pollutionMap: a map of pollution items and integers
 *    nbPol: the number of garbage initially present
 *    curNbPol: the current number of garbage
 *    healthState: the Health associated with the actual polluted zone
 */
class Pollution{
  static Pollution _instance;
  List<PollutionItem> _pollutionList = [];
  Map<int, PollutionItem> _pollutionMap;
  int _nbPol;
  int _curNbPol;
  Health _healthState;

  //private constructor
  Pollution._internal() {
    for(int i = 0; i < 72; i++)
      _pollutionList.add(PollutionItem());
    _pollutionMap = _pollutionList.asMap();
  }
  
  /*
   * input: /
   * output: the instance of Pollution
   */
  static Pollution getInstance() {
    if (_instance == null) {
      _instance = Pollution._internal();
    }
    return _instance;
  }

  /*
   * input: /
   * effect: updates the assiociated Health to the Pollution
   */
  void updatePollution(Health healthBar){
    for(int i = 0; i < 72; i++)
      _pollutionMap[i].makeInvisible();
    _healthState = healthBar;
    _nbPol = healthBar.getNbPollutions();
    if(_nbPol > 5)
      _nbPol = 5;
    _curNbPol = _nbPol;
    for(int i = _nbPol; i > 0; i--)
      _pollutionMap[Random().nextInt(72)].makeVisible(Random().nextInt(4));
  }

  /*
   * input: /
   * output: a PollutionItem object associated with index in pollutionMap
   */
  PollutionItem getPollutionItem(int index){
    return _pollutionMap[index];
  }

  /*
   * input: /
   * effect: reduces the number of garbage left on the screen by one
   */
  void removePollution(){
    _curNbPol--;
  }

  /*
   * input: /
   * output: curNbPol, the number of garbage left on the screen
   */
  int getCurPollutionNb(){
    return _curNbPol;
  }

  /*
   * input: /
   * output: nbPol, the number of garbage initially present on the screen
   */
  int getPollutionNb(){
    return _nbPol;
  }

  /*
   * input: /
   * output: healthState, the Health object currently associated with Pollution
   */
  Health getHealthState(){
    return _healthState;
  }

}