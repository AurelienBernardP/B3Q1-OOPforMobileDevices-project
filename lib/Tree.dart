import 'package:first/Item.dart';
import 'package:first/PollutedZones.dart';
import 'Pollution.dart';
import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'ItemList.dart';
import 'Zone.dart';
import 'dart:async';
import 'TreeBackEnd.dart';

/*
 * Tree class
 *    In charge of the display of a tree and its attributes as well as
 *    the interactions with the tree
 * Attributes:
 *    treeInfo : reference to the class containing data
 *               to be dispalyed
 */
class Tree extends StatefulWidget {
  TreeBackEnd treeInfo;

  Tree({Zone zone, Item treeType, String name, TreeBackEnd tree}) {
    if (tree == null)
      treeInfo = TreeBackEnd(
          zone: zone, tree: treeType, name: name != null ? name : null);
    else
      treeInfo = tree;
  }

  TreeBackEnd getTreeInfo() {
    return treeInfo;
  }

  @override
  TreeScreenBodyState createState() => TreeScreenBodyState(treeInfo);
}

class TreeScreenBodyState extends State<Tree> {
  TreeBackEnd treeInfo;

  TreeScreenBodyState(TreeBackEnd info) {
    treeInfo = info;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    AppBar bar = AdTreesAppTopBar(treeInfo.getName(), context).getBar();

    return Stack(
      children: <Widget>[
        //appbar background
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
          appBar: bar,
          body: Container(
            decoration: treeInfo.getBackground(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 18,
                  child: _buildMiddleSection(),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/table.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: _buildActionButtons(),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => treeInfo.getHealth(),
                                barrierDismissible: true,
                              );
                            },
                            child: Container(
                              child: treeInfo
                                  .getHealth()
                                  .buildGeneralHealth(context),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 8,
              left: MediaQuery.of(context).size.width / 50),
          width: MediaQuery.of(context).size.height / 10,
          height: MediaQuery.of(context).size.height / 10,
          child: GestureDetector(
            onTap: () {
              ItemList.makeShop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemList()),
              );
            },
            child: Image.asset(
              "assets/images/shop.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  /*
   * input:
   *           conetext: buildcontext object in which the popup is built in
   * 
   * effect: opens a popup
   */
  void _cannotUsePopup(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Sorry, you cannot use this item"),
      actions: <Widget>[
        FlatButton(
          child: Text('Got it!'),
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
      },
    );
  }

  /*
   * input : /
   * 
   * return : Widget containing the tree icon
   */
  Widget _buildMiddleSection() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                child: treeInfo.getImage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
   * input : /
   * 
   * return : Widget containing all the action buttons
   *          to use items on the displayed tree
   */
  Widget _buildActionButtons() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          //use small water button
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {

                if (!WaterItem.getInstance().useItem(treeInfo.getHealth()))
                  _cannotUsePopup(context);

                setState(() {});
              },

              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    WaterItem.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      WaterItem.getInstance().getQuantity().toString(),
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
            ),
          ),

          //use large water button
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {

                if (!RainItem.getInstance().useItem(treeInfo.getHealth()))
                  _cannotUsePopup(context);

                setState(() {});
              },

              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    RainItem.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      RainItem.getInstance().getQuantity().toString(),
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
            ),
          ),
          //use small nurishment button
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {

                if (!NurishementItem1.getInstance()
                    .useItem(treeInfo.getHealth())) _cannotUsePopup(context);

                setState(() {});
              },

              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    NurishementItem1.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      NurishementItem1.getInstance().getQuantity().toString(),
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
            ),
          ),
          //use slarge nurishment button
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {

                if (!NurishementItem2.getInstance()
                    .useItem(treeInfo.getHealth())) _cannotUsePopup(context);

                setState(() {});
              },

              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    NurishementItem2.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      NurishementItem2.getInstance().getQuantity().toString(),
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
            ),
          ),
          //use repair item button
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {

                if (!RepairItem.getInstance().useItem(treeInfo.getHealth()))
                  _cannotUsePopup(context);

                else {
                  setState(() {
                    Pollution.getInstance()
                        .updatePollution(treeInfo.getHealth());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PollutedZones()),
                    );
                  });
                }
              },

              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    RepairItem.getInstance().getIcon(),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      RepairItem.getInstance().getQuantity().toString(),
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
            ),
          ),
        ],
      ),
    );
  }
}
