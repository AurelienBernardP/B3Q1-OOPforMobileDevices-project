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
      appBar: AppBar(
        centerTitle: true,
        title: makeTitle(),
      ),
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

  Widget makeTitle(){
    if(_is_shop)
      return Text('Shop');
    return Text('Inventory');
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
      /*child: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
            image: new AssetImage("assets/images/window.png"), 
            fit: BoxFit.cover,),
          ),
        Card(
        //color: Colors.white,
        
        child: Padding(
          padding:
            EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: 
                    _buildImage(x, y)
                  
                ),
                /*Padding(
                  padding: EdgeInsets.all(10.0),
                  child: _buildDescription(x, y),
                ),*/
              ],
            ),
          ),
        ),
      ),
      ),*/
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
    return Image.asset(
                  gridState[x][y].get_icon(),
                  //width: 150,
                  //height: 150,
                  fit: BoxFit.fill,
                );
  }
  
  Widget _addDetails(int x, int y){
    if(_is_shop)
     return Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Price:" + gridState[x][y].get_price(),
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.strikethrough_s, color: Colors.yellow, size: 20.0),
                  ]
                );
    return Text(
                      "Quantity:" +gridState[x][y].get_quantity(),
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    );
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
                _addDetails(_tappedItemX, _tappedItemY),
                _addText(),
                _addButton(),
              ],
            ),
        ),
          );
    return Text("Tap on a grid to view more details!");
  }

  Widget _addTitle(){
    return Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/title.png"), 
                  fit: BoxFit.fill,),
                ),
            child: Text(gridState[_tappedItemX][_tappedItemY].get_name(),
                      style: TextStyle(
                fontSize: 40.0, 
              ),
            ),
        );
  }

  Widget _addText(){
    return  Text(gridState[_tappedItemX][_tappedItemY].get_description(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0, 
              ),
        );
  }


  Widget _addButton(){
    if(_is_shop)
    //if(_unlockedZones < Wallet.available_coins())
      return Container( 
        alignment: Alignment.bottomRight,
        child: FlatButton.icon(
        //color: Colors.red,
        label: Text('Buy item'), 
        icon: Icon(Icons.lock_open),
        onPressed: () { _buy();
        },
        ),
      );
    return Container( 
        alignment: Alignment.bottomRight,
        child: FlatButton.icon(
        //color: Colors.red,R
        label: Text('Use item'), 
        icon: Icon(Icons.lock_open),
        onPressed: () { _use();
        },
        ),
      );
  }
}