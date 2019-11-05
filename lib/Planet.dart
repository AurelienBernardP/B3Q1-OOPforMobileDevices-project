import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Zone.dart';
import 'Characteristic.dart';

class Planet extends StatefulWidget{

@override
  _PlanetState createState() => _PlanetState();
}

class _PlanetState extends State<Planet>{

  List<List<Zone>> gridState = [
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

  int _unlockedZones = 0;
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
      gridState[_tappedZoneX][_tappedZoneY].unlock();
    });
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = gridState.length;
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
    if(gridState[x][y].is_locked())
      return Icon(Icons.lock_outline, size: 20.0);
    return Text(' ');
  }

  Widget _buildGameBody() {
    int gridStateLength = gridState.length;
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
      if(gridState[_tappedZoneX][_tappedZoneY].is_planted())
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
      gridState[x][y].buildZone(context),
      ]
      );
  }

  Widget _buildButton(){
    if(gridState[_tappedZoneX][_tappedZoneY].is_locked())
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
          onPressed: () { print("pressed");
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
          onPressed: () { print("pressed");
          },
        ),
      ),
      Text('Tree description'),
      ]
      );
  }

}
