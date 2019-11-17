import 'dart:async';
import 'TreeScreen.dart';
import 'Item.dart';
import 'Health.dart';
import 'Characteristic.dart';
import 'Planet.dart';


class TimersForTrees {
  static final length = PlanetBackEnd.getInstance().getGrid().length;
  static int nbPlantedTrees;
  List<TreeBackEnd> plantedTrees;
  static final TimersForTrees _singleton = TimersForTrees._internal();

  factory TimersForTrees(){
    return _singleton;
  }

  TimersForTrees._internal(){
    plantedTrees = new List(length*length);
    nbPlantedTrees = 0;
  }
  
  void timers(){
      const fiveSec = const Duration(seconds:5);
      const tenSec = const Duration(seconds:10);

      new Timer.periodic(fiveSec, (Timer t) => dehydrateTrees(t));
      new Timer.periodic(tenSec, (Timer t) => denurishTrees(t));

  }
  void addTreeToTimer(TreeBackEnd tree){
    if(nbPlantedTrees > (length*length))
      return;

    plantedTrees[nbPlantedTrees] = tree;
    nbPlantedTrees ++;
  }

  void dehydrateTrees(Timer t){
    for (int i = 0; i < nbPlantedTrees; i++) {
      plantedTrees[i].getHealth().dehydrateTree(1);
    }
  }

  void denurishTrees(Timer t){
    for (int i = 0; i < nbPlantedTrees; i++) {
      plantedTrees[i].getHealth().denurishTree(10);
    }
  }
}
// Shake: 
// 1 buisson every 5 minutes
// 5 cactus every 1h
// 20 tree every 12h
// 50 pine tree every 24h
// Shop:
// 1 water 10% costs 5
// 1 nurishement 10% 10
// 1 nurishement 50% 40
// 1 repair 5% 15
// 1 repair 15% 35
// 1 cactus 20
// 1 tree 40
// 1 pine tree 50
// 1 mini tree 10
