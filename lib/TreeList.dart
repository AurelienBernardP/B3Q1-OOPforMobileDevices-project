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
    return Scaffold(
      appBar: AdTreesAppTopBar("Tree list", context).getBar(),
      body: Column(
        children: [
          Container(
            height: 50,
            child: Row(children: [
              Text("sort by"),
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
                style: new TextStyle(fontSize: 16.0),
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
                'Overall Health',
                style: new TextStyle(
                  fontSize: 16.0,
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
                'Dehidration',
                style: new TextStyle(fontSize: 16.0),
              ),
            ]),
          ),
          TreeList().getNbTrees() == 0
              ? Container(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text("not trees!"),
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
