import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'TreeScreen.dart';
import 'Planet.dart';

class TreeListScreen extends StatefulWidget {
  @override
  _TreeListScreenState createState() => _TreeListScreenState();
}

class _TreeListScreenState extends State<TreeListScreen> {
  @override
  int _sort = 0;
  Widget build(BuildContext context) {
    return 
    Stack(
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
      appBar: AdTreesAppTopBar("Tree list", context).getBar(),
      body: Container(
        decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/table.png"),
              fit: BoxFit.fill,
            ),),
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
                    print("0");
                    _sort = value;
                    setState(() {
                      TreeList().sortByTimer();
                    });
                  }),
              new Text(
                'Timer',
                style: new TextStyle(
                  fontSize: 20.0, color: Colors.blueGrey[100]
                  ),
              ),
              new Radio(
                value: 1,
                groupValue: _sort,
                onChanged: (value) {
                  print("1");
                  _sort = value;
                  setState(() {
                    TreeList().sortByTimer();
                  });
                },
              ),
              new Text(
                'Health',
                style: new TextStyle(
                  fontSize: 20.0, color: Colors.blueGrey[100]
                ),
              ),
              new Radio(
                value: 2,
                groupValue: _sort,
                onChanged: (value) {
                  print("0");
                  _sort = value;
                  setState(() {
                    TreeList().sortByTimer();
                  });
                },
              ),
              new Text(
                'Dehydration',
                style: new TextStyle(
                  fontSize: 20.0, color: Colors.blueGrey[100]
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/title.png"), 
                  fit: BoxFit.fill,),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: <Widget>[
              Text("Name", style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          )
          ),
              Text("Health", 
              textAlign: TextAlign.right,
              style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          )
          ),
            ],), ),
          ),
          TreeList().getNbTrees() == 0
              ? Container(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text("OMG! You don't have any trees yet, go plant some!", 
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blueGrey[100]
                      ),
                    ),
                  ),
                )
              : Flexible(
                  child: ListView.builder(
                      itemCount: TreeList().getNbTrees(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    child: TreeList()
                                        .getTreeList()[index]
                                        .getImage()),
                                flex: 1,
                              ),
                              Expanded(
                                flex: 4,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(TreeList()
                                      .getTreeList()[index]
                                      .getName()),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text((TreeList()
                                                  .getTreeList()[index]
                                                  .getMilisecondsLeft() /
                                              1000)
                                          .toString() +
                                      "secs"),
                                ),
                              ),
                            ],
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
  static final length = PlanetBackEnd.getInstance().getGrid().length;
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

  int getNbTrees() => nbPlantedTrees;

  void addTreeToList(TreeBackEnd tree) {
    if (nbPlantedTrees > (length * length)) return;

    plantedTrees.add(tree);
    nbPlantedTrees++;
  }

  void sortByTimer() {
    plantedTrees
        .sort((a, b) => a.getMilisecondsLeft() - b.getMilisecondsLeft());
  }

  void sortByGeneralHealth() {
    plantedTrees
        .sort((a, b) => a.getMilisecondsLeft() - b.getMilisecondsLeft());
  }

  void sortByHydration() {
    plantedTrees.sort();
  }

  void sortByDamage() {
    plantedTrees.sort();
  }

  void sortByNurishment() {
    plantedTrees.sort();
  }
}
