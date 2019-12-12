import 'dart:async';
import 'package:first/TreeList.dart';

import 'TreeBackEnd.dart';
import 'TreeList.dart';
import 'dart:math';
import 'Save.dart';

/*TimersForTrees  class
 * 
 * Singleton class containing a timer which updates the state of the game periodically
 * 
 * Attributes : /
 */
class TimersForTrees {
  static final TimersForTrees _singleton = TimersForTrees._internal();

  /*TimersForTrees
  * input: /
  *
  * output: the instantiatesd class
  */
  factory TimersForTrees() {
    return _singleton;
  }

  //private constructor, initialising TimersForTrees for the first time
  TimersForTrees._internal();

  /* timers
  * input: /
  *
  * effect: starts the timer to update all the planted trees
  */
  void timers() {
    const oneMin = const Duration(minutes: 1);
    new Timer.periodic(oneMin, (Timer t) => updateStateTrees());
  }

  /* scaleDown
  * input:
  *   percentageInOneHour: a percentage increasing a need every hour
  *   max: the maximum the need to increase
  *
  * output: a percentage increasing the need
  */
  double scaleDown(double percentageInOneHour, double max) {
    return ((percentageInOneHour / 100) * max / 60);
  }

  /* dehydrationRatio
  * input:
  *   typeTree: a name corresponding to the type of a tree
  *
  * output: 
  *   an amount to add to the need "hydration" of the tree
  */
  double dehydrationRatio(String typeTree) {
    double hydrationMax = 10;
    switch (typeTree) {
      case "Cactus":
        return scaleDown(4.16, hydrationMax);
        break;
      case "Pine Tree":
        return scaleDown(1.16, hydrationMax);
        break;
      case "Tree":
        return scaleDown(2.05, hydrationMax);
      case "Mini Plant":
        return scaleDown(10, hydrationMax);
      default:
        return 0.0;
    }
  }

  /* denurishRatio
  * input:
  *   typeTree: a name corresponding to the type of a tree
  *
  * output: 
  *   an amount to add to the need "nutrition" of the tree
  */
  double denurishRatio(String typeTree) {
    double nutritionMax = 1000;
    switch (typeTree) {
      case "Cactus":
        return scaleDown(1, nutritionMax);
        break;
      case "Pine Tree":
        return scaleDown(5, nutritionMax);
        break;
      case "Tree":
        return scaleDown(2, nutritionMax);
      case "Mini Plant":
        return scaleDown(10, nutritionMax);
      default:
        return 0.0;
    }
  }

  /* updateStateTrees
  * input: /
  *
  * effect: update the state of all planted trees
  */
  void updateStateTrees() {
    TreeBackEnd currentTree;
    String currentTreeName;
    for (int i = 0; i < TreeList().getNbTrees(); i++) {
      currentTree = TreeList().getTreeList()[i];
      currentTreeName = currentTree.plantedTree.getName();
      double nbDrop = dehydrationRatio(currentTreeName);
      double nutrition = denurishRatio(currentTreeName);

      currentTree.getHealth().dehydrateTree(nbDrop);
      currentTree.getHealth().denurishTree(nutrition);
      if (new Random().nextInt(10) == 1) currentTree.getHealth().polluteTree();
    }
    Save().saveGame();
  }
}
