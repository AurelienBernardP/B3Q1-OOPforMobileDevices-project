import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'TreeScreen.dart';
import 'Planet.dart';

class TreeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdTreesAppTopBar("Tree list", context).getBar(),
      body: Column(
        children: [
          Container(
            child: Text("sort by"),
          ),
          TreeList().getNbTrees() == 0
              ? Container(
                  child: Text("not trees!"),
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
                                child: Text(
                                    TreeList().getTreeList()[index].getName()),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text((TreeList()
                                                  .getTreeList()[index]
                                                  .getMilisecondsLeft() /
                                              1000)
                                          .toString() +
                                      "secs")),
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
