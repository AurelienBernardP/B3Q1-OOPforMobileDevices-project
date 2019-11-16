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
      appBar: AppBar(
        centerTitle: true,
        title: Text('How to play'),
      ),
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
    return
      Container(
        color: Colors.black,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/table.png"), 
              //fit: BoxFit.cover,
              fit: BoxFit.fill,
          ),
        ),
        child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //SizedBox(height: height/20),
                _addTitle(),
                //_addDetails(_tappedItemX, _tappedItemY),
                //_addText(),
                _addButton(),
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

  Widget _addButton(){
      return Row(
        children: <Widget>[ 
          Container(
        alignment: Alignment.bottomRight,
        //width: 100,
        //height: 100,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/left.png"), 
              //fit: BoxFit.cover,
              fit: BoxFit.fill,
          ),
        ),
        child: FlatButton.icon(
        label: Text('Buy item'), 
        icon: Icon(Icons.lock_open),
        onPressed: () { _nextPage();
        },
        ),
        ),
        ],
        
      );
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