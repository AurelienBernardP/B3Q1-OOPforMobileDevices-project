import 'dart:async';
import 'package:first/TreeList.dart';

import 'TreeScreen.dart';
import 'Item.dart';
import 'Health.dart';
import 'TreeList.dart';
import 'dart:math';
import 'Characteristic.dart';
import 'Planet.dart';


class TimersForTrees {
  static final TimersForTrees _singleton = TimersForTrees._internal();
  Timer timerTreeScreen;

  factory TimersForTrees(){
    return _singleton;
  }

  TimersForTrees._internal(){
  }

  
  void timers(){
      const oneMin = const Duration(minutes:1);

      new Timer.periodic(oneMin, (Timer t) => updateStateTrees(t));

  }

  // void setTimerForTreeScreen(TreeScreenBodyState state){
  //     print("set timer");

  //   timerTreeScreen = Timer.periodic(Duration(seconds: 5), (Timer t) {
  //     print("pased");
  //     state.onValueChanged();
  //   });
  // }

  // void cancelTimerTreenScreen(){
  //   print("canceled timer")
  //   if(timerTreeScreen != null){
  //     timerTreeScreen.cancel();
  //     timerTreeScreen = null;
  //   }
  // }

// Nurishement: 
// C: -1% par h
// P: -5% par h
// T: -2% par h
// Damage:
// C: (0,5)
// T: (0, 10)
// P: (0, 20)

  double scaleDown(double percentageInOneHour, double max){
    return ((percentageInOneHour/100)* max / 60);
  }

  double dehydratationRatio(String typeTree){
    double hydratationMax = 10;
    switch (typeTree) {
      case "Cactus":
        //100 in 12h
        //8.33% in 1h
        return scaleDown(8.33,hydratationMax);
        break;
      case "Pine Tree":
        //100 in 30h
        //3.33% in 1h
        return scaleDown(3.34,hydratationMax);
        break;
      case "Tree":
        //100% in 24h
        //4.167% in 1h
        return scaleDown(4.167,hydratationMax);
      case "Mini Plant":
        //100% in 5 h
        //20% in 1h
        return scaleDown(100,hydratationMax);
      default:
        return 0.0;
    }
  }

  double denurishRatio(String typeTree){
    double nutritionMax = 1000;
    switch (typeTree) {
      case "Cactus":
        return scaleDown(1,nutritionMax);
        break;
      case "Pine Tree":
        return scaleDown(5,nutritionMax);
        break;
      case "Tree":
        return scaleDown(2,nutritionMax);
      case "Mini Plant":
        return scaleDown(10,nutritionMax);
      default:
        return 0.0;
    }
  }

  void updateStateTrees(Timer t){
    TreeBackEnd currentTree;
    String currentTreeName;
    for (int i = 0; i < TreeList().getNbTrees(); i++) {
      currentTree = TreeList().getTreeList()[i];
      currentTreeName = currentTree.plantedTree.getName();
      double nbDrop = dehydratationRatio(currentTreeName);
      double nutrition = denurishRatio(currentTreeName);

      currentTree.getHealth().dehydrateTree(nbDrop);
      currentTree.getHealth().denurishTree(nutrition);
      if (new Random().nextInt(20) == 0)
        currentTree.getHealth().polluteTree();
    }
  }
}