import 'Zone.dart';
import 'Save.dart';
import 'dart:math';
import 'Item.dart';

class PlanetBackEnd {
  static PlanetBackEnd _instance;
  List<List<Zone>> gridState;
  List<List<Item>> gridTree;
  int _nbZoneUnlocked;

  PlanetBackEnd._internal() {
gridState = Save().getWorldMap();
gridTree = [
  [Cactus.getInstance(), PineTree.getInstance()], 
  [ForestTree.getInstance(), MiniPlant.getInstance(),],
  ];
  _nbZoneUnlocked = Save().getNbZoneUnlocked();
  }
  static PlanetBackEnd getInstance() {
    if (_instance == null) {
      _instance = PlanetBackEnd._internal();
    }
    return _instance;
  }

  int getPrice(){
    return pow(2, (_nbZoneUnlocked/3).round());
  }

  List<List<Zone>> getGrid() {
    return gridState;
  }

  List<List<Item>> getTreeGrid() {
    return gridTree;
  }

  Zone getZone(int x, int y) {
    return gridState[x][y];
  }

  void unlockZone(int x, int y){
    _nbZoneUnlocked++;
    gridState[x][y].unlock();
    Save().saveGame();
  }

  void plant(int mapX, int mapY, int x, int y) {
    gridState[mapX][mapY].plantTree(gridTree[x][y]);
  }
}
