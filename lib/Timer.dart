import 'dart:async';
import 'package:first/TreeList.dart';

import 'TreeBackEnd.dart';
import 'TreeList.dart';
import 'dart:math';
import 'Save.dart';

/*TimersForTrees  class
 * 
 * Singleton class containing timers which update the state of the game periodically
 * 
 * Attributes : /
 */
class TimersForTrees {
  static final TimersForTrees _singleton = TimersForTrees._internal();

  /*TimersForTrees
  * arguments: /
  *
  * return: the instantiatesd class
  */
  factory TimersForTrees() {
    return _singleton;
  }

  //private constructor, initialising TimersForTrees for the first time
  TimersForTrees._internal();

  /* Starts the timer to update the trees
  * arguments: /
  *
  * return: /
  */
  void timers() {
    const oneMin = const Duration(minutes: 1);
    new Timer.periodic(oneMin, (Timer t) => updateStateTrees());
  }

  /* scaleDown
  * arguments:
  *   percentageInOneHour: a percentage of need that will be added to a need per hour
  *   max: the maximum a need
  *
  * return: an amount that will be added to a need which after one hour a percentage
  *          corresponding to percentageInOneHour will be added to the need
  */
  double scaleDown(double percentageInOneHour, double max) {
    return ((percentageInOneHour / 100) * max / 60);
  }

  /* dehydrationRatio
  * arguments:
  *   typeTree: a name corresponding to the type of a tree
  *
  * return: 
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
  * arguments:
  *   typeTree: a name corresponding to the type of a tree
  *
  * return: 
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

  /* updateStateTrees: update the state of all planted tree
  * arguments: /
  *
  * return: /
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
