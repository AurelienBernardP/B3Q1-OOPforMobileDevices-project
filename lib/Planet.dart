import 'package:first/AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Save.dart';
import 'Wallet.dart';
import 'Item.dart';
import 'ItemList.dart';
import 'PlanetBackEnd.dart';

class Planet extends StatefulWidget {
  @override
  _PlanetState createState() => _PlanetState();
}

class _PlanetState extends State<Planet> {
  int _tappedZoneX = -1;
  int _tappedZoneY = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "World map",
      home: Stack(
        children: <Widget>[
          new Container(
            height: MediaQuery.of(context).size.height / 8.5,
            width: double.infinity,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/table.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AdTreesAppTopBar('World map', context).getBar(),
            body: _buildGameBody(),
          ),
        ],
      ),
    );
  }

  /*
   * input: x, an int
   *        y, an int
   * effect: sets the value of tappedZoneX to x and tappedZoneY to y
   */
  void _tapOnGrid(int x, int y) {
    setState(() {
      _tappedZoneX = x;
      _tappedZoneY = y;
    });
  }

  /*
   * input: /
   * effect: unlocks the zone at the position (tappedZoneX, tappedZoneY)
   */
  void _unlockZone() {
    setState(() {
      PlanetBackEnd.getInstance().unlockZone(_tappedZoneX, _tappedZoneY);
    });
  }

  /*
   * input: /
   * effect: creates a popup to either confirm the zone purchase of the user
   *          or to inform the user that s/he does not have enough coins to buy the zone
   */
  void _createZonePopup() {
    if (Wallet().isSufficient(PlanetBackEnd.getInstance().getPrice()))
      _unlockZonePopup(context);
    else
      _zonePricePopup(context);
  }

  /*
   * input: context, BuildContext
   * effect: creates a popup to confirm the zone purchase of the user
   */
  void _unlockZonePopup(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Unlock Zone?"),
      content: Row(children: <Widget>[
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
      ]),
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
            setState(() {
              Wallet().retrieveCoins(PlanetBackEnd.getInstance().getPrice());
              _unlockZone();
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  /*
   * input: context, BuildContext
   * effect: creates a popup to inform the user that s/he does not have enough coins to buy the zone
   */
  void _zonePricePopup(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Not enough coins!"),
      content: Row(children: <Widget>[
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
      ]),
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
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  /*
   * input: tree, an Item that is the tree the user is trying to plant on the zone
   * effect: creates a popup to either enter the tree name
   *          or to inform the user that s/he does not have that tree type left
   */
  void _createPlantPopup(Item tree) {
    if (tree.getQuantity() > 0)
      _plantTreePopup(context, tree);
    else
      _shopPopup(context, tree);
  }

  /*
   * input: tree, an Item that is the tree the user is trying to plant on the zone
   * effect: creates a popup for the user to enter the tree name
   */
  void _plantTreePopup(BuildContext context, Item tree) {
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
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  /*
   * input: tree, an Item that is the tree the user is trying to plant on the zone
   * effect: creates a popup to inform the user that s/he does not have that tree type left
   */
  void _shopPopup(BuildContext context, Item tree) {
    var alertDialog = AlertDialog(
      title: Text("You've ran out of " + tree.getName()),
      content: Row(children: <Widget>[
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
      ]),
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
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  /*
   * input: tree, an Item that is the tree to be planted on the zone
   *        name, a string that is the name of the tree to be planted
   * effect: plants 'tree' with the name 'name' on the zone (tappedZoneX, tappedZoneY)
   */
  void _plantTree(Item tree, String name) {
    setState(() {
      PlanetBackEnd.getInstance()
          .getZone(_tappedZoneX, _tappedZoneY)
          .plantTree(tree, name: name);
      tree.useItem(
          PlanetBackEnd.getInstance().getZone(_tappedZoneX, _tappedZoneY));
      Save().saveGame();
    });
  }

  /*
   * input: context, BuildContext
   *        index, an integer
   * output: the widget that will be displayed at the position index in the gridView
   */
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
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Center(
            child: _buildGridItem(x, y),
          ),
        ),
      ),
    );
  }

  /*
   * input: x, an integer
   *        y, an integer
   * output: an empty widget if the zone at the position (x, y) is unlocked but empty
   *         a lock icon if the zone at the position (x, y) is locked
   *         a floral icon if the zone at the position (x, y) has a tree planted
   */
  Widget _buildGridItem(int x, int y) {
    if (PlanetBackEnd.getInstance().getZone(x, y).isLocked())
      return Icon(Icons.lock_outline, size: 20.0);
    if (PlanetBackEnd.getInstance().getZone(x, y).isPlanted())
      return Icon(Icons.local_florist, size: 20.0);
    return Text(' ');
  }

  /*
   * input: /
   * output: the widget that contains everything on the screen that isn't related to the app bar
   */
  Widget _buildGameBody() {
    int gridStateLength = PlanetBackEnd.getInstance().getGrid().length;
    return Column(children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/treemap.jpeg"),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.black, width: 2.0)),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridStateLength,
            ),
            itemBuilder: _buildGridItems,
            itemCount: gridStateLength * gridStateLength,
          ),
        ),
      ),
      Expanded(child: _addDescription()),
    ]);
  }

  /*
   * input: /
   * output: a widget that is the description of a zone if the user selected a zone
   *                       suggests to the user to select a zone
   */
  Widget _addDescription() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (_tappedZoneX >= 0 && _tappedZoneY >= 0) {
      if (PlanetBackEnd.getInstance()
          .getZone(_tappedZoneX, _tappedZoneY)
          .isPlanted())
        return _buildTreeDescription();
      else {
        return _buildZoneDescriptionNotPlanted();
      }
    }
    return Container(
      color: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/table.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.center,
                width: width / 2.2,
                height: height / 5,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/table.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(
                  "Select a zone \nfor more \ninfo!",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
   * input: /
   * output: a widget that displays the characteristics of the selected zone
   *            and contains the icon of the trees the user can plant if the zone is unlocked
   *         a widget that displays the characteristics of the selected zone
   *            and an unlock button if the zone is locked
   */
  Widget _buildZoneDescriptionNotPlanted() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (PlanetBackEnd.getInstance()
        .getZone(_tappedZoneX, _tappedZoneY)
        .isLocked())
      return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/locked/" +
                PlanetBackEnd.getInstance()
                    .getZone(_tappedZoneX, _tappedZoneY)
                    .getZoneType() +
                "Locked.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(width/30),
              child: Container(
                width: width / 2.2,
                height: height / 5,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/table.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: PlanetBackEnd.getInstance()
                    .getZone(_tappedZoneX, _tappedZoneY)
                    .buildZone(context),
              ),
            ),
            Container(
              margin: EdgeInsets.all(width/30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      _createZonePopup();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Unlock for ' +
                            PlanetBackEnd.getInstance().getPrice().toString() +
                            " "),
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
      return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/unlocked/" +
                PlanetBackEnd.getInstance()
                    .getZone(_tappedZoneX, _tappedZoneY)
                    .getZoneType() +
                "Unlocked.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(width/30),
              child: Container(
                width: width / 2.2,
                height: height / 5,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/table.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: PlanetBackEnd.getInstance()
                    .getZone(_tappedZoneX, _tappedZoneY)
                    .buildZone(context),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Plant a tree:",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                _buildTreeGrid(),
              ],
            ),
            SizedBox(width: width/30)
          ],
        ),
      );
  }

  /*
   * input: /
   * output: a widget that is a grid containing all the trees that can be planted
   */
  Widget _buildTreeGrid() {
    int gridStateLength = PlanetBackEnd.getInstance().getTreeGrid().length;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: width / 3,
            height: width / 3,
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int gridStateLength =
                      PlanetBackEnd.getInstance().getTreeGrid().length;
                  int x, y = 0;
                  x = (index / gridStateLength).floor();
                  y = (index % gridStateLength);
                  return GestureDetector(
                    onTap: () {
                      _createPlantPopup(
                          PlanetBackEnd.getInstance().getTreeGrid()[x][y]);
                    },
                    child: _buildImage(x, y),
                  );
                },
                itemCount: gridStateLength * gridStateLength,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /*
   * input: x, an integer
   *        y, an integer
   * output: a widget that displays the icon of the tree in the position [x][y] in gridTree and its available quantity
   */
  Widget _buildImage(int x, int y) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 2.0)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            PlanetBackEnd.getInstance().getTreeGrid()[x][y].getIcon(),
            fit: BoxFit.fill,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              PlanetBackEnd.getInstance()
                  .getTreeGrid()[x][y]
                  .getQuantity()
                  .toString(),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
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
   * output: a widget that displays the characteristics of the selected zone
   *            and contains the icon of the tree planted in that zone
   */
  Widget _buildTreeDescription() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/unlocked/" +
                PlanetBackEnd.getInstance()
                    .getZone(_tappedZoneX, _tappedZoneY)
                    .getZoneType() +
                "Unlocked.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(width/30),
                child: Container(
                  width: width / 2.2,
                  height: height / 5,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/table.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: PlanetBackEnd.getInstance()
                      .getZone(_tappedZoneX, _tappedZoneY)
                      .buildZone(context),
                ),
              ),
              FittedBox(
              child: Container(
                  margin: EdgeInsets.only(top: width/18, left: width/20, right: width/20, bottom: width/18),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlanetBackEnd.getInstance()
                                        .getZone(_tappedZoneX, _tappedZoneY)
                                        .getTreeScreenWidget()),
                          );
                        },
                        child: Container(
                          height: height / 6,
                          width: width / 3,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(PlanetBackEnd.getInstance()
                                  .getZone(_tappedZoneX, _tappedZoneY)
                                  .getPlantedTree()
                                  .getIcon()),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      _createTreeHealth(height, width),
                    ],
                  )
                ))
            ]
            )
            );
  }

  /*
   * input: /
   * output: a widget that displays the current health of the tree planted on the selected zone
   */
  Widget _createTreeHealth(double height, double width) {
    double treeHealth = PlanetBackEnd.getInstance()
        .getZone(_tappedZoneX, _tappedZoneY)
        .getTreeScreen()
        .getHealth()
        .getOverall();
    String image;
    if (treeHealth < 20.0)
      image = "low.png";
    else if (treeHealth > 80.0)
      image = "high.png";
    else
      image = "medium.png";
    return Container(
      height: height / 28,
      width: width / 3,
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/" + image),
          fit: BoxFit.fill,
        ),
      ),
      child: Text(
        treeHealth.toStringAsPrecision(3) + "%",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

}
