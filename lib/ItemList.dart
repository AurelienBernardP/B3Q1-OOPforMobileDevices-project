import 'package:first/AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Item.dart';

bool _is_shop = true;

class ItemList extends StatefulWidget{

  static void makeShop(){
    _is_shop = true;
  }

  static void makeInventory(){
    _is_shop = false;
  }

@override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList>{
  
  var gridState = [
    [WaterItem.getInstance(), RepairItem.getInstance(), NurishementItem.getInstance(),], 
    [Cactus.getInstance(), PineTree.getInstance(), ForestTree.getInstance(),], 
    [MiniPlant.getInstance(), MiniPlant.getInstance(), MiniPlant.getInstance(),], 
  ];
    
  int _tappedItemX = -1;
  int _tappedItemY = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "World map", home: Scaffold(
      appBar: AdTreesAppTopBar(makeTitle(), context).getBar(),
      body: /*Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[*/
          _displayItems(),
          //]),
    ),
    );
  }

  String makeTitle(){
    if(_is_shop)
      return 'Shop';
    return 'Inventory';
  }

  void _tapOnGrid(int x, int y){
    setState(() {
      _tappedItemX = x;
      _tappedItemY = y;
    });
  }

  void _buy(){
    setState(() {
      gridState[_tappedItemX][_tappedItemY].buyItem();
    });
  }

  void _use(){
    setState(() {
      gridState[_tappedItemX][_tappedItemY].sellItem();
    });
  }

  Widget _buildCard(BuildContext context, int index) {
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
            fit: BoxFit.fill,),
          ),
          child: Container(
            margin: new EdgeInsets.all(10.0),
            child: Center(
            
            child: _buildImage(x, y),
          ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(int x, int y){
    if(_is_shop)
return 
Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              gridState[x][y].getIcon(),
              fit: BoxFit.fill,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                              Text(
                gridState[x][y].getPrice().toString(),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.yellow,
              ),),
                            Icon(Icons.strikethrough_s,
                            color: Colors.yellow,),
                            ],
                          ),
              
              
              
            ),  
    ],),);
    else 
    return 
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              gridState[x][y].getIcon(),
              fit: BoxFit.fill,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child:Text(
                gridState[x][y].getQuantity().toString(),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.yellow,
              ),),),  
    ],),
    
    );
  }
  
  Widget _addDetails(int x, int y){
    if(_is_shop)
     return Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Price:" + gridState[x][y].getPrice(),
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.strikethrough_s, color: Colors.yellow, size: 20.0),
                  ]
                );
    else
      return Text('');
  }

  Widget _displayItems(){
    int gridStateLength = gridState.length;
    return Column(
      children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          //decoration: BoxDecoration(
            /*image: new DecorationImage(
            image: new AssetImage("assets/images/table.png"), 
            fit: BoxFit.cover,),*/
          //),
          color: Colors.black,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemBuilder: _buildCard,
            itemCount: gridStateLength * gridStateLength,
          ),
        ),
      ),
      Expanded(child: _addDescription()),
      //_addButton(),
      ]
    );
  }

  Widget _addDescription(){
    if(_tappedItemX >= 0 && _tappedItemY >= 0)
        return
        Container(
          color: Colors.black,
        child: Container(
            constraints: BoxConstraints.expand(), 
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/table.png"), 
                  fit: BoxFit.fill,),
                ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _addTitle(),
                // _addDetails(_tappedItemX, _tappedItemY),
                _addText(),
                _addButton(),
              ],
            ),
        ),
          );
    return 
          Container(
            color: Colors.black,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/table.png"), 
                    fit: BoxFit.fill,),
                  ),
              child:Text(
                "Tap on a grid to view more details!",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.yellow,
                ),),),);
  }

  Widget _addTitle(){
    double height = MediaQuery.of(context).size.height;

    return Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/title.png"), 
                  fit: BoxFit.fill,),
                ),
            margin: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.all(5),
              child: Text(gridState[_tappedItemX][_tappedItemY].getName(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                fontSize: height/22, 
              ),
            ),
            )
            
        );
  }

  Widget _addText(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  
      Container(
        margin: EdgeInsets.only(left: width/20, right: width/20),
        child: Text(gridState[_tappedItemX][_tappedItemY].getDescription(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: height/30,
                color: Colors.blueGrey[100]
              ),
      )
    );
  }


  Widget _addButton(){
    if(_is_shop)
    //if(_unlockedZones < Wallet.available_coins())
      return Container( 
        alignment: Alignment.bottomRight,
        child: FlatButton.icon(
        //color: Colors.red,
        label: Text(
          'Buy item',
          style: TextStyle(
            color: Colors.yellow,

          )
        ), 
        icon: Icon(
          Icons.lock_open,
          color: Colors.yellow,
        ),
        onPressed: () { _buy();
        },
        ),
      );

    return Container( 
        alignment: Alignment.bottomRight,
        child: FlatButton.icon(
        //color: Colors.red,R
        label: Text(
          'Use item',
          style: TextStyle(
            color: Colors.yellow,
          )
        ), 
        icon: Icon(
          Icons.lock_open,
          color: Colors.yellow,
        ),
        onPressed: () { _use();
        },
        ),
      );
  }
}