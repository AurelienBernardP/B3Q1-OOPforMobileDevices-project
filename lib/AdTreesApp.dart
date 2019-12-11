import 'package:first/ItemList.dart';
import 'package:first/TreeList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Planet.dart';
import 'ItemList.dart';
import 'TreeList.dart';
import 'Timer.dart';


/* AdTreesApp
 *
 * This widget builds the main menu screen and 
 * starts the tree timers to update health
 */
class AdTreesApp extends StatelessWidget {
  Widget build(BuildContext context) {
    TimersForTrees().timers();//start the timers to updat the health of trees with time
    return MaterialApp(title: "AdTrees", home: _AdTreesAppBody());
  }
}

class _AdTreesAppBody extends StatefulWidget {
  __AdTreesAppBodyState createState() => __AdTreesAppBodyState();
}

class __AdTreesAppBodyState extends State<_AdTreesAppBody> {

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        // apbar background design
        new Container(
          height: MediaQuery.of(context).size.height / 9.2,
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
          appBar: AdTreesAppTopBar("AdTrees!", context).getBar(),
          body: Stack(

            // screen background image
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/treemap.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(
                    left: width / 24, right: width / 22, bottom: height / 5),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/menu.png"),
                    fit: BoxFit.fill,
                  ),
                ),

                // Menu container withe the tiles
                child: Container(
                  margin: new EdgeInsets.only(
                      top: height / 4, left: width / 17, right: width / 15),
                  child: ListView(
                    children: <Widget>[

                      // Wordlmap tapable tile
                      Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/window.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: ListTile(
                          title: AutoSizeText(
                            'Worldmap',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width / 15,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Planet()),
                            );
                          },
                        ),
                      ),

                      // Shop tapable tile
                      Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/window.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: ListTile(
                          title: AutoSizeText(
                            'Shop',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width / 15,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                          onTap: () {
                            ItemList.makeShop();//make screen show the price instead of the quantity owned
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemList()),
                            );
                          },
                        ),
                      ),

                      // Inventory tapable tile
                      Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/window.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: ListTile(
                          title: AutoSizeText(
                            'Inventory',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width / 15,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                          onTap: () {
                            ItemList.makeInventory();//make screen show the quantity owned instead of the price
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemList()),
                            );
                          },
                        ),
                      ),
                      // Tree list tapable tile
                      Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/window.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: ListTile(
                          title: AutoSizeText(
                            'Tree list',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width / 15,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TreeListScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
