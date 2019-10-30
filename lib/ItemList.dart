import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Item.dart';

class ItemList extends StatefulWidget{

@override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList>{
  
  var gridState = [
    [WaterItem.getInstance(), TrapItem.getInstance(), NurishementItem.getInstance(),], 
    [PlantItem.getInstance(), PlantItem.getInstance(), PlantItem.getInstance(),], 
    [PlantItem.getInstance(), PlantItem.getInstance(), PlantItem.getInstance(),], 
  ];
    
    bool is_shop = true;
    int _tappedItemX = -1;
    int _tappedItemY = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "World map", home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shop'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[_displayItems(),]),
    ),
    );
  }
    void _tapOnGrid(int x, int y){
    setState(() {
      _tappedItemX = x;
      _tappedItemY = y;
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
      child: Card(
        color: Colors.white,
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
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: _buildDescription(x, y),
                ),
              ],
            ),
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
  
  Widget _buildDescription(int x, int y){
    if(is_shop)
     return Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      gridState[x][y].get_price(),
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.strikethrough_s, color: Colors.yellow, size: 20.0),
                  ]
                );
    return Text(
                      gridState[x][y].get_quantity(),
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
      _addDescription(),
    ]
    );
  }
  Widget _addDescription(){
    if(_tappedItemX >= 0 && _tappedItemY >= 0)
      return Text(gridState[_tappedItemX][_tappedItemY].get_name());  
    return Text("Tap on a grid to view more details!");
  }
}