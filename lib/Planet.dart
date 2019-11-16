import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Characteristics/AllCharacteristics.dart';
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
    if(PlanetBackEnd.getInstance().getZone(x, y).isLocked())
      return Icon(Icons.lock_outline, size: 20.0);
    if(PlanetBackEnd.getInstance().getZone(x, y).isPlanted())
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
      Expanded(child:_addDescription()),
    ]
    );
  }


  Widget _addDescription(){
    if(_tappedZoneX >= 0 && _tappedZoneY >= 0){
      if(PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).isPlanted())
          return _buildTreeDescription();
      else{
        return _buildZoneDescriptionNotPlanted(_tappedZoneX, _tappedZoneY);
      }
    }
    return Text("Tap on a grid to view more details!");
  }


  Widget _buildZoneDescriptionNotPlanted(int x, int y){
    if(PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).isLocked())
      return
          Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/locked/"+PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).getZoneType()+"Locked.png"), 
                  fit: BoxFit.cover,),
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.red,
                        onPressed: () { _unlockZone();},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.photo_album),
                            Text('Unlock for x'),
                            Icon(Icons.strikethrough_s),
                            ],
                          ),
                      ),
                    ],
                  ),
                    PlanetBackEnd.getInstance().getZone(x, y).buildZone(context),
              ],
            ),
          );

      else
        return
        Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/unlocked/"+PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).getZoneType()+"Unlocked.png"), 
                  fit: BoxFit.cover,),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //faire container un à gauche et un à adroite
                Container(
                  alignment: Alignment.topLeft,
                  child: PlanetBackEnd.getInstance().getZone(x, y).buildZone(context),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: 
                    _buildGridCharacteristics(context),
                ),
              ],
              ),
            );
  }




  Widget _buildGridCharacteristics(BuildContext context) {
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
            image: new DecorationImage(
            image: new AssetImage("assets/images/window.png"), 
            fit: BoxFit.cover,),
          ),
          child: Center(
            child: _buildImage(x, y),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(int x, int y){
    return Image.asset(
                  gridState[x][y].get_icon(),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                );
  }
  
  Widget _buildTreeDescription(){
    return 
      Container(
      decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/unlocked/"+PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).getZoneType()+"Unlocked.png"), 
                fit: BoxFit.cover,),
              ),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
 FlatButton.icon(
          color: Colors.green,
          label: Text('See tree?'), 
          icon: Icon(Icons.remove_red_eye),
          onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).getTreeScreen()),
                );
          },
        ),
      Container(
                  child: PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).buildZone(context),
                ),
      ]
      )
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
    gridState[x][y].viewTree();
  }
}
