import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Zone.dart';
import 'Characteristic.dart';

class Planet extends StatefulWidget{

@override
  _PlanetState createState() => _PlanetState();
}

class _PlanetState extends State<Planet>{

  int _tappedZoneX = -1;
  int _tappedZoneY = -1;

  @override
  Widget build(BuildContext context){
    return MaterialApp(title: "World map", home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('World map'),
      ),
      body: _buildGameBody(),
    ),
    );
  }
  void _tapOnGrid(int x, int y){
    setState(() {
      _tappedZoneX = x;
      _tappedZoneY = y;
    });
  }

  void _unlockZone(){
    setState(() {
      PlanetBackEnd.getInstance().unlockZone(_tappedZoneX, _tappedZoneY);
    });
  }

  void _plant(){
    setState(() {
      PlanetBackEnd.getInstance().plant(_tappedZoneX, _tappedZoneY);
    });
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = PlanetBackEnd.getInstance().getGrid().length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () {
        _tapOnGrid(x, y);
        }, 
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5)
          ),
          child: Center(
            child: _buildGridItem(x, y),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(int x, int y){
    if(PlanetBackEnd.getInstance().getZone(x, y).is_locked())
      return Icon(Icons.lock_outline, size: 20.0);
    if(PlanetBackEnd.getInstance().getZone(x, y).is_planted())
      return Icon(Icons.local_florist, size: 20.0);
    return Text(' ');
  }

  Widget _buildGameBody() {
    int gridStateLength = PlanetBackEnd.getInstance().getGrid().length;
    return Column(
      children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
            image: new AssetImage("assets/images/treemap.jpeg"), 
            fit: BoxFit.cover,),
            border: Border.all(color: Colors.black, width: 2.0)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridStateLength,
            ),
            itemBuilder: _buildGridItems,
            itemCount: gridStateLength * gridStateLength,
          ),
        ),
      ),
      _addDescription(),
    ]
    );
  }
  //will be called on tap
  Widget _addDescription(){
    if(_tappedZoneX >= 0 && _tappedZoneY >= 0){
      if(PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).is_planted())
          return _buildTreeDescription();
      else{
        return _buildZoneDescription(_tappedZoneX, _tappedZoneY);
      }
    }
    return Text("Tap on a grid to view more details!");
  }

  Widget _buildZoneDescription(int x, int y){
    return Column(
      
      children: <Widget>[ 
        Container(
        margin: const EdgeInsets.all(15.0),
        height: 30.0,
        width: 240.0,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child : _buildButton(),
        ),
        Container(child:
        PlanetBackEnd.getInstance().getZone(x, y).buildZone(context),)
      ]
      );
  }

  Widget _buildButton(){
    if(PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).is_locked())
      //if(_unlockedZones < Wallet.available_coins())
        return FlatButton.icon(
          color: Colors.red,
          label: Text('Unlock Zone?'), 
          icon: Icon(Icons.lock_open),
          onPressed: () { _unlockZone();
          },
        );
    return FlatButton.icon(
          color: Colors.red,
          label: Text('View zone details'), 
          icon: Icon(Icons.lock_open),
          onPressed: () { _plant();
          },
        );
  }

  Widget _buildTreeDescription(){
    return Column(
      children: <Widget>[ 
      Container(
      margin: const EdgeInsets.all(15.0),
      height: 30.0,
      width: 240.0,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child : FlatButton.icon(
          color: Colors.red,
          label: Text('See tree?'), 
          icon: Icon(Icons.lock_open),
          onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).getTree()),
                );
          },
        ),
      ),
      Text('Tree description'),
      ]
      );
  }

}

class PlanetBackEnd{  
  static PlanetBackEnd _instance;
  List<List<Zone>> gridState;
  int _unlockedZones;

  PlanetBackEnd._internal() {
  gridState = [
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  [Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert()), Zone(Desert())],
  ];

  _unlockedZones = 0;
  }
  static PlanetBackEnd getInstance() {
    if (_instance == null) {
      _instance = PlanetBackEnd._internal();
    }
    return _instance;
  }

  List<List<Zone>> getGrid(){
    return gridState;
  }

  Zone getZone(int x, int y){
    return gridState[x][y];
  }

  void unlockZone(int x, int y){
    gridState[x][y].unlock(); 
  }

  void plant(int x, int y){
    gridState[x][y].plantTree();
  }
}
