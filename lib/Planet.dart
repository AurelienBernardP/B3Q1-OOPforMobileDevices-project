import 'package:first/AdTreesAppTopBar.dart';
import 'package:first/TreeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Characteristics/allCharacteristics.dart';
import 'Zone.dart';
import 'Wallet.dart';
import 'Item.dart';
import 'ItemList.dart';
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
      appBar: AdTreesAppTopBar('World map', context).getBar(),
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

  void _createZonePopup(BuildContext conext){
    if (Wallet().isSufficient(PlanetBackEnd.getInstance().getPrice()))
      _unlockZonePopup(context);
    else
      _zonePricePopup(context);
  }

  void _unlockZonePopup(BuildContext context){
    var alertDialog = AlertDialog(
      title: Text("Unlock Zone?"),
      content: Row( 
                  children: <Widget>[
                    Text(
                      "Price:" + PlanetBackEnd.getInstance().getPrice().toString(),
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0, 
                      ),
                    ),
                    Icon(Icons.strikethrough_s, color: Colors.yellow, size: 25.0),
                  ]
                ),
      actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Unlock'),
            onPressed: () {
              _unlockZone();
              Navigator.of(context).pop();
            },
          ),
        ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }
    );
  }

  void _zonePricePopup(BuildContext context){
    var alertDialog = AlertDialog(
      title: Text("Nid moneyz bitch"),
      content: Row(
                  children: <Widget>[
                    Text(
                      "Price:" + PlanetBackEnd.getInstance().getPrice().toString(),
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0, 
                      ),
                    ),
                    Icon(Icons.strikethrough_s, color: Colors.yellow, size: 25.0),
                  ]
                ),
      actions: <Widget>[
          FlatButton(
            child: Text('Ok im sorry'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }
    );
  }

    void _createPlantPopup(BuildContext conext, Item tree){
    if(tree.getQuantity() > 0)
      _plantTreePopup(context, tree);
    else
      _shopPopup(context, tree);
  }

  void _plantTreePopup(BuildContext context, Item tree){
    String treeName;
    var alertDialog = AlertDialog(
      title: Text("Pick a cute name for your " + tree.getName()),
      content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Tree name', hintText: 'eg. Groot'),
              onChanged: (value) {
                treeName = value;
              },
            ))
          ],
        ),
      actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Plant'),
            onPressed: () {
              _plantTree(tree, treeName);
              Navigator.of(context).pop();
            },
          ),
        ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }
    );
  }

  void _shopPopup(BuildContext context, Item tree){
    var alertDialog = AlertDialog(
      title: Text("You've ran out of" + tree.getName()),
      content: Row(
                  children: <Widget>[
                    Text(
                      "Price:" + tree.getPrice(),
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0, 
                      ),
                    ),
                    Icon(Icons.strikethrough_s, color: Colors.yellow, size: 25.0),
                  ]
                ),
      actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Go to shop'),
            onPressed: () {
              Navigator.of(context).pop();
              ItemList.makeShop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemList()),
                );
            },
          ),
        ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }
    );
  }

  void _plantTree(Item tree, String name){
    setState(() {
      PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).plantTree(tree, name: name);
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if(_tappedZoneX >= 0 && _tappedZoneY >= 0){
      if(PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).isPlanted())
          return _buildTreeDescription();
      else{
        return _buildZoneDescriptionNotPlanted(_tappedZoneX, _tappedZoneY);
      }
    }
    return Container(
          color: Colors.black,
        child: Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/table.png"), 
                  fit: BoxFit.fill,),
                ),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Container(
                    alignment: Alignment.center,
                    width: width/2.2,
                    height: height/5,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/table.png"), 
                          fit: BoxFit.fill,),
                        ),
                    child:
                    Text(
                "Select a tree \nfor more \ninfo!",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.yellow,
                ),),
                  ),
                ),
              ],
            ),
          ),
        );
  }


  Widget _buildZoneDescriptionNotPlanted(int x, int y){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if(PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).isLocked())
      return
          Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/locked/"+PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).getZoneType()+"Locked.png"), 
                  fit: BoxFit.cover,),
                ),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Container(
                    width: width/2.2,
                    height: height/5,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/table.png"), 
                          fit: BoxFit.fill,),
                        ),
                    child: PlanetBackEnd.getInstance().getZone(x, y).buildZone(context),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.red,
                        onPressed: () {
                          _createZonePopup(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.photo_album),
                            Text('Unlock for '+  PlanetBackEnd.getInstance().getPrice().toString()+ " "),
                            Icon(Icons.strikethrough_s),
                            ],
                          ),
                      ),
                    ],
                  ),
                ),
                
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Container(
                    width: width/2.2,
                    height: height/5,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/table.png"), 
                          fit: BoxFit.fill,),
                        ),
                    child: PlanetBackEnd.getInstance().getZone(x, y).buildZone(context),
                  ),
                ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Plant a tree:",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),),
                      _buildTreeGrid(),
                  ],),
                  SizedBox(width:10)
                  
              ],
              ),
            );
  }

  Widget _buildTreeGrid(){
    int gridStateLength = PlanetBackEnd.getInstance().getTreeGrid().length;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
      FittedBox(
  fit: BoxFit.cover,
  child: SizedBox(
    width: width/3,
        height: width/3,
        child: Container(
        child: GridView.builder(

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemBuilder: (BuildContext context, int index) {
    int gridStateLength = PlanetBackEnd.getInstance().getTreeGrid().length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: (){
        _createPlantPopup(context, PlanetBackEnd.getInstance().getTreeGrid()[x][y]);
        }, 
       child: _buildImage(x, y),
    );
  }
            ,
            itemCount: gridStateLength * gridStateLength,
          ),
        ),
      ),
      ),
      ],
    );
  }

  Widget _buildImage(int x, int y){
    return 
    Container(
    decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0)
          ),
    child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
                   PlanetBackEnd.getInstance().getTreeGrid()[x][y].getIcon(),
                  fit: BoxFit.fill,
                ),

                Container(
                  alignment: Alignment.bottomRight,
                child:Text(
                PlanetBackEnd.getInstance().getTreeGrid()[x][y].getQuantity().toString(),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.yellow,
                ),),),  
    ],),
    
    );
  }
  
  Widget _buildTreeDescription(){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return 
      Container(
      decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/unlocked/"+PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).getZoneType()+"Unlocked.png"), 
                fit: BoxFit.cover,),
              ),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Container(
                    width: width/2.2,
                    height: height/5,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/table.png"), 
                          fit: BoxFit.fill,),
                        ),
                    child: PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).buildZone(context),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: FlatButton.icon(
          color: Colors.green,
          label: Text('See tree?'), 
          icon: Icon(Icons.remove_red_eye),
          onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY).getTreeScreen()),
                );
          },
        ),
                )
 
      ]
      )
      );
  }

}

class PlanetBackEnd{  
  static PlanetBackEnd _instance;
  List<List<Zone>> gridState;
  List<List<Item>> gridTree;
  int _zonePrice;

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
gridTree = [
  [Cactus.getInstance(), PineTree.getInstance()], 
  [ForestTree.getInstance(), MiniPlant.getInstance(),],
  ];
  _zonePrice = 1;
  }
  static PlanetBackEnd getInstance() {
    if (_instance == null) {
      _instance = PlanetBackEnd._internal();
    }
    return _instance;
  }

  int getPrice(){
    return _zonePrice;
  }

  List<List<Zone>> getGrid(){
    return gridState;
  }

  List<List<Item>> getTreeGrid(){
    return gridTree;
  }

  Zone getZone(int x, int y){
    return gridState[x][y];
  }

  void unlockZone(int x, int y){
    _zonePrice *= 2;
    gridState[x][y].unlock(); 
  }

  void plant(int mapX, int mapY, int x, int y){
    gridState[mapX][mapY].plantTree(gridTree[x][y]);
    //viewTree();
  }
}
