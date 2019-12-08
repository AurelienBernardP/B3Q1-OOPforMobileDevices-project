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

/* arguments
 * 
 * 
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
                Container(
                  margin: EdgeInsets.all(20.0),
                  height: 50,
                  child: Row(children: [
                    //Text("Sort by"),
                    new Radio(
                        value: 0,
                        groupValue: _sort,
                        onChanged: (value) {
                          _sort = value;
                          setState(() {
                            _setDisplayedText = 0;
                            TreeList().sortByNbPolution();
                          });
                        }),
                    new Text(
                      'Polution number',
                      style: new TextStyle(
                          fontSize: 20.0, color: Colors.blueGrey[100]),
                    ),
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
                    new Text(
                      'Health',
                      style: new TextStyle(
                          fontSize: 20.0, color: Colors.blueGrey[100]),
                    ),
                    new Radio(
                      value: 2,
                      groupValue: _sort,
                      onChanged: (value) {
                        _sort = value;
                        setState(() {
                          _setDisplayedText = 1;
                          TreeList().sortByHydration();
                        });
                      },
                    ),
                    new Text(
                      'Dehydration',
                      style: new TextStyle(
                          fontSize: 20.0, color: Colors.blueGrey[100]),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/title.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            )),
                        Text(_setDisplayedText == 0 ? "Polutions" : "Health",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            )),
                      ],
                    ),
                  ),
                ),
                TreeList().getNbTrees() == 0
                    ? Container(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "You don't have any trees yet! go plant some!",
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
                              return GestureDetector(behavior: HitTestBehavior.opaque,
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
                                        margin: EdgeInsets.only(left: 20),
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
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
                                        child: Text(_setDisplayedText == 0? TreeList().getTreeList()[index].getHealth().toString() :
                                          TreeList()
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

class TreeList {
  static int nbPlantedTrees;
  List<TreeBackEnd> plantedTrees;
  static final TreeList _singleton = TreeList._internal();

  factory TreeList() {
    return _singleton;
  }

  TreeList._internal() {
    plantedTrees = new List();
    nbPlantedTrees = 0;
  }

  List<TreeBackEnd> getTreeList() => nbPlantedTrees != 0 ? plantedTrees : null;

  void reset(){
    plantedTrees = new List();
    nbPlantedTrees = 0;
  }

  int getNbTrees() => nbPlantedTrees;

  void addTreeToList(TreeBackEnd tree) {
    if (nbPlantedTrees > (100)) return;

    plantedTrees.add(tree);
    nbPlantedTrees++;
  }

  void sortByGeneralHealth() {
    plantedTrees
        .sort((a, b) => (a.getHealth().getOverall() - b.getHealth().getOverall()).round());
  }

  void sortByNbPolution() {
    plantedTrees
        .sort((a, b) => (a.getHealth().getNbPollutions() - b.getHealth().getNbPollutions()));
  }

  void sortByHydration() {
    plantedTrees.sort((a, b) => (a.getHealth().gethydration() - b.getHealth().gethydration()).round());
  }

  void sortByPolution() {
    plantedTrees.sort((a, b) => (a.getHealth().getNbPollutions() - b.getHealth().getNbPollutions()).round());
  }

  void sortByNurishment() {
    plantedTrees.sort((a, b) => (a.getHealth().getNutrition() - b.getHealth().getNutrition()).round());
  }
  
}
