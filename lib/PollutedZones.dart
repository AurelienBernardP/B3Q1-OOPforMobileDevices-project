import 'package:first/AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Wallet.dart';
import 'Pollution.dart';

class PollutedZones extends StatefulWidget {
  @override
  _PollutedZonesState createState() => _PollutedZonesState();
}

class _PollutedZonesState extends State<PollutedZones> with TickerProviderStateMixin{

  int _dragged = 0; //variable used to detect the current PollutionItem being dragged

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
    var width = MediaQuery.of(context).size.width / 8;
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
                width: width,
                height: width,
                decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(Pollution.getInstance().getPollutionItem(index).getImage()), 
                  fit: BoxFit.fill,),
                ),
              ),
              feedback: Container(
                width: width,
                height: width,
                decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(Pollution.getInstance().getPollutionItem(index).getImage()), 
                  fit: BoxFit.fill,),
                ),
              ),
              childWhenDragging: Container(width: width,
                height: width,),
            ),
            );
    return Container(width: width, height: width);
  }

  Widget _createPollution(){
    return Expanded(
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
    var width = MediaQuery.of(context).size.width / 4;
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
                  width: width,
                  height: width,
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
                  width: width,
                  height: width,
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
