import 'package:first/AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  int pageNumber = 0;
  final int NBPAGES = 7;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Guide",
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
            appBar: AdTreesAppTopBar('How to play', context, isGuide: true)
                .getBar(),
            body: _buildGuide(),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    setState(() {
      pageNumber = (pageNumber + 1) % NBPAGES;
    });
  }

  void _previousPage() {
    setState(() {
      if (pageNumber == 0) {
        pageNumber = NBPAGES - 1;
      } else {
        pageNumber = (pageNumber - 1);
      }
    });
  }

  _buildGuide() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/table.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _addTitle(),
              flex: 2,
            ),
            //SizedBox(height: height/20),

            //_addDetails(_tappedItemX, _tappedItemY),
            Expanded(
              child: _addText(),
              flex: 8,
            ),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(bottom: height / 80, right: width / 100),
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: height / 80, left: width / 100),
                      alignment: Alignment.bottomLeft,
                      child: _addLeftButton(height, width),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: height / 80, right: width / 100),
                      alignment: Alignment.bottomRight,
                      child: _addRightButton(height, width),
                    ),
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  _addTitle() {
    double height = MediaQuery.of(context).size.height;

    return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/title.png"),
            fit: BoxFit.fill,
          ),
        ),
        margin: EdgeInsets.all(height / 25),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Text(
            _getTitle(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height / 22,
            ),
          ),
        ));
  }

  _addText() {
    return Container(margin: new EdgeInsets.all(20.0), child: _getText());
  }

  Text formatText(String text) {
    double height = MediaQuery.of(context).size.height;

    return Text(text,
        style: TextStyle(
          color: Colors.grey[100],
          fontSize: height / 35,
        ));
  }

  _getText() {
    switch (pageNumber) {
      case 0:
        return Column(
          children: <Widget>[
            Expanded(
                child: formatText(
                    "The world map is divided into zones.\n A zone has different characteristics depending on its type.\n This zones can be unlocked with coins and trees can be plated in them.\n To perform any action on a zone just tap on it and options will apear")),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/treemap.jpeg"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        );

      //   "A zone has different characteristics depending on its type. \n"+
      //   " There are five types of zones: desert, forest, snowy mountains, path, river. \n"+
      //  "  Zones can be locked or unlocked. Unlocked zones can be planted by using a tree.";
      case 1:
        return Column(
          children: <Widget>[
            Expanded(
                child: formatText(
                    "A tree can be accesed from the world map or from the tree list.\n Here you can see the health of your plant, you can also water it nurish it or play a game to clean it.\n Each option is displayed with a tapable button.\n ")),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/treeScreen.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        );
      case 2:
          return Column(
          children: <Widget>[
            Expanded(
                child: formatText(
                    "The shop can be accesed from the main menu the world map or from the any tree.\n In the shop you will be able to exchange Coins for usable items like trees!.\n Coins can be earned in many ways:\n ·Shaking a tree you planted \n ·Playing a game to clean a planted tree \n Watching a short ad by taping on the play button")),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/shopScreen.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        );
      case 3:
        return Column(
          children: <Widget>[
            Expanded(
                child: formatText(
                    "In the invetory you will be able to see the quantity you have of each item"),),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/inventoryScreen.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        );
      case 4:
        return Column(
          children: <Widget>[
            Expanded(
                child: formatText(
                    "From the cleanser item in the tree screen (shield icon) you can acess the game.\n A poluted zone will apear, and it is your task to clean and sort the trash in the area!\n Trash needs to be sorted between compost, on the left, and recycling ,on the right.\n The trash can be dragged into the corresponding bin.\n You will be rewarded for each trash you throw correctly, but only if you clean them all!"),),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/gameScreen.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        );
      case 5:
        return Column(
          children: <Widget>[
            Expanded(
                child: formatText(
                    "From the tree list you can sort and see the time left to shake the trees or their health more rapidely.\n You can select the element you sort the trees by from the list at the of the screen.\n To access a tree simply tap on its box!")),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/treeListScreen.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        );
      case 6:
        return Column(
          children: <Widget>[
            Expanded(
                child: formatText(
                    "This aplication was developed by Tasnim Safadi, Aurélien Bernard, and Kenan Ozdemir.\n\n The aim of this app is to sensitize the public about the environment in a playfull manner.\n Most of the generated revenue by this app will be transmited to organization dedicated to improve the environment.\n\n Thankyou for your contribution and support.")),
           
          ],
        );
    }
  }

  Widget _addRightButton(double height, double width) {
    return GestureDetector(
      onTap: () {
        _nextPage();
      },
      child: Container(
        margin: new EdgeInsets.all(20.0),
        width: height / 10,
        height: height / 10,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/right.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _addLeftButton(double height, double width) {
    return GestureDetector(
      onTap: () {
        _previousPage();
      },
      child: Container(
        margin: new EdgeInsets.all(20.0),
        width: height / 10,
        height: height / 10,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/left.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _getTitle() {
    switch (pageNumber) {
      case 0:
        return "Map";
      case 1:
        return "Tree screen";
      case 2:
        return "Shop & coins";
      case 3:
        return "Inventory";
      case 4:
        return "Polution game";
      case 5:
        return "Tree List";
      case 6:
        return "About";
    }
  }
}
