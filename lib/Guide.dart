import 'package:first/AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Guide extends StatefulWidget{

@override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide>{
int pageNumber = 0;

  @override
  Widget build(BuildContext context){
    return MaterialApp(title: "Guide", home: Scaffold(

      appBar: AdTreesAppTopBar('How to play', context,isGuide:true).getBar(),
      body: _buildGuide(),
    ),
    );
  }

  void _nextPage(){
    setState(() {
      pageNumber = (pageNumber + 1) % 3;
    });
  }

  _buildGuide(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return
      Container(
        color: Colors.black,
      child: Container(
        width: width,
        height: height,
        
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/table.png"), 
              fit: BoxFit.fill,
          ),
        ),
        child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                child: _addTitle(),
                flex: 2,
              ),
                //SizedBox(height: height/20),
                
                //_addDetails(_tappedItemX, _tappedItemY),
                Expanded(
                  child: _addText(),
                  flex: 8,
                ),
                Expanded(
                  child: Container(
                  alignment: Alignment.bottomRight,
                child: _addButton(height, width),),
                flex: 2,
                ),
              ],
            ),
      ),
      );
  }

  _addTitle(){
    return Container(
        margin: new EdgeInsets.all(25.0),
        child: Text(_getTitle(),
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 40.0, 
              ),
        ),
      );
  }

  _addText(){
    return Container(
        margin: new EdgeInsets.all(20.0),
        child: Text(_getText(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0, 
              ),
        ),
      );
  }

  _getText(){
    switch (pageNumber){
      case 0:
        return "The world map is divided into zones. A zone has different characteristics depending on its type. \n There are five types of zones: desert, forest, snowy mountains, path, river. \n Zones can be locked or unlocked. Unlocked zones can be planted by using a tree.";
      case 1:
        return "Some description for tree screen";
      case 2:
        return "moneyyyyyyyyyyyy";
    }
  }

  Widget _addButton(double height, double width){
      return GestureDetector(
              onTap: (){_nextPage();},
              child:Container(
                margin: new EdgeInsets.all(20.0),
                width: height/10,
                height: height/10,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/left.png"), 
                    fit: BoxFit.fill,
                  ),
                ),
              ),);
  }

  _getTitle(){
    switch (pageNumber){
    case 0:
      return "Map";
    case 1:
      return "Tree screen";
    case 2:
      return "Shop & coins";
   }
  }
}