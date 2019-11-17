import 'dart:async';
import 'package:first/TreeList.dart';

import 'TreeScreen.dart';
import 'Item.dart';
import 'Health.dart';
import 'TreeList.dart';
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
      const fiveSec = const Duration(seconds:5);
      const tenSec = const Duration(seconds:10);

      new Timer.periodic(fiveSec, (Timer t) => dehydrateTrees(t));
      new Timer.periodic(tenSec, (Timer t) => denurishTrees(t));

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

  void dehydrateTrees(Timer t){
    for (int i = 0; i < TreeList().getNbTrees(); i++) {
      TreeList().getTreeList()[i].getHealth().dehydrateTree(1);
    }
  }

  void denurishTrees(Timer t){
    for (int i = 0; i < TreeList().getNbTrees(); i++) {
      TreeList().getTreeList()[i].getHealth().denurishTree(40);
    }
  }
}