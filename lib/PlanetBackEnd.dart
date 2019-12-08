import 'Zone.dart';
import 'Save.dart';
import 'dart:math';
import 'Item.dart';

/*
 * PlanetBackEnd class
 * Attributes:
 *    instance: the unique instance of PlanetBackEnd
 *    gridState: a list of list of Zone representing all the zones within the grid of the world map
 *    gridTree: a list of list of Item representing all the trees that a user can plant
 *    nbZoneUnlocked: an integer that represents the number of currently unlocked zones
 */

class PlanetBackEnd {
  static PlanetBackEnd _instance;
  List<List<Zone>> gridState;
  List<List<Item>> gridTree;
  int _nbZoneUnlocked;

  //private constructor, initialising PlanetBackEnd for the first time
  PlanetBackEnd._internal() {
  gridState = Save().getWorldMap();
  gridTree = [
    [Cactus.getInstance(), PineTree.getInstance()], 
    [ForestTree.getInstance(), MiniPlant.getInstance(),],
  ];
  _nbZoneUnlocked = Save().getNbZoneUnlocked();
  }

  /*
   * input: /
   * output: the instance of PlanetBackEnd
   */
  static PlanetBackEnd getInstance() {
    if (_instance == null) {
      _instance = PlanetBackEnd._internal();
    }
    return _instance;
  }

  /*
   * input: /
   * output: an integer that is the price of a zone
   */
  int getPrice(){
    return pow(2, (_nbZoneUnlocked/3).round());
  }

  /*
   * input: /
   * output: gridState, the list of list of Zone representing all the zones within the grid of the world map
   */
  List<List<Zone>> getGrid() {
    return gridState;
  }

  /*
   * input: /
   * output: gridState, the list of list of Item representing all the trees that a user can plant
   */
  List<List<Item>> getTreeGrid() {
    return gridTree;
  }

  /*
   * input: x, an integer 
   *        y, an integer
   * output: the zone at the position [x][y] in gridState 
   */
  Zone getZone(int x, int y) {
    return gridState[x][y];
  }

  /*
   * input: x, an integer 
   *        y, an integer
   * effect: unlock the zone at the position [x][y] in gridState 
   */
  void unlockZone(int x, int y){
    _nbZoneUnlocked++;
    gridState[x][y].unlock();
    Save().saveGame();
  }

  /*
   * input: mapX, an integer 
   *        mapY, an integer
   *        x, an integer 
   *        y, an integer
   * effect: plants the tree at the position [x][y] in gridTree in the zone at the position [mapX][mapY] in gridState 
   */
  void plant(int mapX, int mapY, int x, int y) {
    gridState[mapX][mapY].plantTree(gridTree[x][y]);
  }
}
