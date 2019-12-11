import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'TreeBackEnd.dart';

/*
 * TreeListScreen class
 * Displays a list of trees sorted by the users input criteria
 */
class TreeListScreen extends StatefulWidget {
  @override
  _TreeListScreenState createState() => _TreeListScreenState();
}

/*
 * _TreeListScreenState class
 * Displays a list of trees sorted by the users input criteria
 * 
 * Attributes:
 *        sort: number defining the attribute with which the list is sorted 
 *              0: number of polutions
 *              1: general health
 *              2: hydration
 *        _setDisplayedText: number defining if the nuber of polution is displayed(0) or a healthbar(1)
 */
class _TreeListScreenState extends State<TreeListScreen> {
  int _sort = 0;
  int _setDisplayedText = 0;

/* arguments:
 *          overall: number between 0.0 and 100.0 decribing numerically the overall health of a tree
 * 
 * return: String describing qualitatively the health of the tree
 */
  String getImageHealth(double overall) {
    if (overall < 20.0)
      return "low.png";
    else if (overall > 80.0)
      return "high.png";
    else
      return "medium.png";
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //appbar background
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
          appBar: AdTreesAppTopBar("Tree list", context).getBar(),
          body: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/table.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                //raidio buttons to select sorting characteristic
                Container(
                  margin: EdgeInsets.all(20.0),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //number of polutions button
                      new Radio(
                        value: 0,
                        groupValue: _sort,
                        onChanged: (value) {
                          _sort = value;
                          setState(() {
                            _setDisplayedText = 0;
                            TreeList().sortByNbPolution();
                          });
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Number of litter',
                            style: TextStyle(color: Colors.blueGrey[100]),
                          ),
                        ),
                      ),
                      //Health button
                      new Radio(
                        value: 1,
                        groupValue: _sort,
                        onChanged: (value) {
                          _sort = value;
                          setState(() {
                            _setDisplayedText = 1;
                            TreeList().sortByGeneralHealth();
                          });
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Health',
                            style: TextStyle(color: Colors.blueGrey[100]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //background decoration
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/title.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  //elements of the page title
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          _setDisplayedText == 0 ? "Polutions" : "Health",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //if the number of planted trees is 0 display a message otherwise display the trees
                TreeList().getNbTrees() == 0
                    ? Container(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "You don't have any trees yet! Go plant some!",
                            style: TextStyle(
                                fontSize: 25, color: Colors.blueGrey[100]),
                          ),
                        ),
                      )
                    : Flexible(
                        child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 80.0),
                            itemCount: TreeList().getNbTrees(),
                            itemBuilder: (BuildContext context, int index) {
                              // each element of the list of trees
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TreeList()
                                            .getTreeList()[index]
                                            .getZone()
                                            .getTreeScreenWidget()),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        margin: EdgeInsets.only(left: 20),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            TreeList()
                                                .getTreeList()[index]
                                                .getName(),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Colors.blueGrey[100],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        margin: EdgeInsets.only(right: 20),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        decoration: BoxDecoration(
                                          image: new DecorationImage(
                                            image: new AssetImage(
                                                "assets/images/" +
                                                    getImageHealth(TreeList()
                                                        .getTreeList()[index]
                                                        .getHealth()
                                                        .getOverall())),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Text(
                                          _setDisplayedText == 0
                                              ? TreeList()
                                                  .getTreeList()[index]
                                                  .getHealth()
                                                  .getNbPollutions()
                                                  .toString()
                                              : TreeList()
                                                      .getTreeList()[index]
                                                      .getHealth()
                                                      .getOverall()
                                                      .toStringAsPrecision(3) +
                                                  "%",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*TreeList  class
 * 
 * Singleton class that keeps a list of all the planted trees
 * This class also have functions to manipulate this list
 * 
 * variables : 
 *            _nbPlantedTrees : number of elements in the list
 *            _plantedTrees : treeBackEnd list
 *            _singleton : instance of this class
 */
class TreeList {

  static int _nbPlantedTrees;
  List<TreeBackEnd> _plantedTrees;
  static final TreeList _singleton = TreeList._internal();

  /* TreeList
  * arguments: /
  *
  * return: the instantiatesd class
  */
  factory TreeList() {
    return _singleton;
  }

   /*
  * arguments: /
  *
  * return: list of TreeBackEnd holding all planted trees
  */
  TreeList._internal() {
    _plantedTrees = new List();
    _nbPlantedTrees = 0;
  }

  /*getTreeList
  * arguments: /
  *
  * return: list of TreeBackEnd holding all planted trees
  */
  List<TreeBackEnd> getTreeList() => _nbPlantedTrees != 0 ? _plantedTrees : null;

  /*reset
  * arguments: /
  *
  * return: resets the singleton to 0 trees
  */
  void reset() {
    _plantedTrees = new List();
    _nbPlantedTrees = 0;
  }

  /*getNbTrees
  * arguments: /
  *
  * return: integer, the number of ele,ments in the list of trees
  */
  int getNbTrees() => _nbPlantedTrees;

  /*addTreeToList
  * arguments: tree: treeBackEnd class
  *
  * effect: adds tree to the list of this class
  */
  void addTreeToList(TreeBackEnd tree) {
    if (_nbPlantedTrees > (100)) return;

    _plantedTrees.add(tree);
    _nbPlantedTrees++;
  }

  /*SortByGeneralHealth
  * arguments: /
  *
  * effect: sort the list by the tree's general health
  */
  void sortByGeneralHealth() {
    _plantedTrees.sort((a, b) =>
        (a.getHealth().getOverall() - b.getHealth().getOverall()).round());
  }

  /*SortByNbPolution
  * arguments: /
  *
  * effect: sort the list by the tree's number of polutions
  */
  void sortByNbPolution() {
    _plantedTrees.sort((a, b) =>
        (a.getHealth().getNbPollutions() - b.getHealth().getNbPollutions()));
  }

  /*SortByNbPolution
  * arguments: /
  *
  * effect: sort the list by the tree's hydration
  */
  void sortByHydration() {
    _plantedTrees.sort((a, b) =>
        (a.getHealth().getHydration() - b.getHealth().getHydration()).round());
  }

  /*SortByNbPolution
  * arguments: /
  *
  * effect: sort the list by the tree's nurishment
  */
  void sortByNurishment() {
    _plantedTrees.sort((a, b) =>
        (a.getHealth().getNutrition() - b.getHealth().getNutrition()).round());
  }

}
