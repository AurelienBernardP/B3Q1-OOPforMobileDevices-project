import 'package:first/AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Item.dart';
import 'Save.dart';

bool _isShop = true;

class ItemList extends StatefulWidget{

  static void makeShop(){
    _isShop = true;
  }

  static void makeInventory(){
    _isShop = false;
  }

@override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList>{
  
  var gridState = [
    [Cactus.getInstance(), ForestTree.getInstance(), PineTree.getInstance(),],
    [MiniPlant.getInstance(), WaterItem.getInstance(), RainItem.getInstance(),], 
    [NurishementItem1.getInstance(), NurishementItem2.getInstance(), RepairItem.getInstance(),], 
  ];
    
  int _tappedItemX = -1;
  int _tappedItemY = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "World map", 
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
          appBar:  AdTreesAppTopBar(_makeTitle(), context).getBar(),
          body: _displayItems(), 
        ),
      ],
    ),
    ) ;
  }

  /*
   * input: /
   * output: the title of the current screen
   */
  String _makeTitle(){
    if(_isShop)
      return 'Shop';
    return 'Inventory';
  }

  /*
   * input: x, an integer the horizontal position of the square that was tapped on
   *        y, an integer the vertical position of the square that was tapped on
   * effect: refreshes the screen and updates the value of the x and y 
   * coordinates of the tapped item
   */
  void _tapOnGrid(int x, int y){
    setState(() {
      _tappedItemX = x;
      _tappedItemY = y;
    });
  }

  /*
   * input: /
   * effect: purchases the selected item if possible
   */
  void _buy(){
    setState(() {
      if(gridState[_tappedItemX][_tappedItemY].buyItem()){
        _boughtPopup(context);
        Save().saveGame();
        return;
      }
      else
        _cannotBuyPopup(context);
    });
  }

  /*
   * input: context, BuildContext
   * effect: displays a popup in order to inform the user that the item was
   * bought successfully
   */
  void _boughtPopup(BuildContext context){
    var alertDialog = AlertDialog(
      title: Text('You have more ' + gridState[_tappedItemX][_tappedItemY].getName() + '!'),
      actions: <Widget>[
          FlatButton(
            child: Text('Go use your items!'),
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

  /*
   * input: context, BuildContext
   * effect: displays a popup in order to inform the user
   * that he cannot buy that item
   */
  void _cannotBuyPopup(BuildContext context){
    var alertDialog = AlertDialog(
      title: Text("You're out of money! Keep calm, don't cry"),
      actions: <Widget>[
          FlatButton(
            child: Text('Oups! You\'re too broke to do this...'),
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

  /*
   * input: context, BuildContext
   *        index, an int
   * output: a widget that represents the "square" of the item
   * at the index index
   */
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

  /*
   * input: x, an int
   *        y, an int
   * output: a widget that will be displayed on the grid at the position (x,y)
   */
  Widget _buildImage(int x, int y){
    if(_isShop)
      return 
        Container(
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
                      ),
                    ),
                    Icon(
                      Icons.strikethrough_s,
                      color: Colors.yellow,
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
                  ),
                ),
              ),  
            ],
          ),
        );
  }

  /*
  * input: /
  * output: a widget that contains everything on the screen that isn't related to the app bar
  */
  Widget _displayItems(){
    int gridStateLength = gridState.length;
    return Column(
      children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
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
      ]
    );
  }


  /*
   * input: /
   * output: a widget that will be displayed under the grid;
   * it will contain the currently selected item's description
   * if an item has already been selected
   */
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
                  fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                _addTitle(),
                Expanded(child:_addText()),
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
              fit: BoxFit.fill,
            ),
          ),
          child:Text(
            "Tap on a grid to view more details!",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.yellow,
            ),
          ),
        ),
      );
  }


  /*
   * input: /
   * output: a widget that will display the name of the selected item
   */
  Widget _addTitle(){
    double height = MediaQuery.of(context).size.height;

    return 
      Container(      
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/title.png"), 
            fit: BoxFit.fill,
          ),
        ),
        margin: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Text(
            gridState[_tappedItemX][_tappedItemY].getName(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height/22, 
            ),
          ),
        )    
      );
  }

  /*
   * input: /
   * output: a widget that will display the description of the selected item
   */
  Widget _addText(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  
      Container(
        margin: EdgeInsets.only(left: width/20, right: width/20),
        child: AutoSizeText(
          gridState[_tappedItemX][_tappedItemY].getDescription(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: height/30,
            color: Colors.blueGrey[100]
          ),
        )
      );
  }

  /*
   * input: /
   * output: a widget that will be either the "buy" button of an empty text
   */
  Widget _addButton(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if(_isShop)
      return Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(top: height/60, right: width/20, bottom: height/35),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/title.png"), 
              fit: BoxFit.fill,
            ),
          ),
          width: width/4,
          height: height/20,
          child: GestureDetector(
            onTap: (){
              _buy();
            },
            child: Text(
              'Buy',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )
            ), 
          ),
        ),  
      );

    return Text(' ');

  }
  
}