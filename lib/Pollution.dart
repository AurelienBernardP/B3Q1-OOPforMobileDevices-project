import 'dart:math';
import 'package:first/PollutionItem.dart';
import 'Health.dart';

/*
 * Pollution class
 * Attributes:
 *    pollutionList: a list containing all the pollution items of the screen
 *    pollutionMap: a map of pollution items and integers
 *    nbPol: the number of garbage initially present
 *    curNbPol: the current number of garbage
 *    healthState: the Health associated with the actual polluted zone
 */
class Pollution{
  static Pollution _instance;
  List<PollutionItem> _pollutionList = [];
  Map<int, PollutionItem> _pollutionMap;
  int _nbPol;
  int _curNbPol;
  Health _healthState;

  //private constructor
  Pollution._internal() {
    for(int i = 0; i < 72; i++)
      _pollutionList.add(PollutionItem());
    _pollutionMap = _pollutionList.asMap();
  }
  
  /*
   * input: /
   * output: the instance of Pollution
   */
  static Pollution getInstance() {
    if (_instance == null) {
      _instance = Pollution._internal();
    }
    return _instance;
  }

  /*
   * input: /
   * effect: updates the assiociated Health to the Pollution
   */
  void updatePollution(Health healthBar){
    for(int i = 0; i < 72; i++)
      _pollutionMap[i].makeInvisible();
    _healthState = healthBar;
    _nbPol = healthBar.getNbPollutions();
    if(_nbPol > 5)
      _nbPol = 5;
    _curNbPol = _nbPol;
    for(int i = _nbPol; i > 0; i--)
      _pollutionMap[Random().nextInt(72)].makeVisible(Random().nextInt(4));
  }

  /*
   * input: /
   * output: a PollutionItem object associated with index in pollutionMap
   */
  PollutionItem getPollutionItem(int index){
    return _pollutionMap[index];
  }

  /*
   * input: /
   * effect: reduces the number of garbage left on the screen by one
   */
  void removePollution(){
    _curNbPol--;
  }

  /*
   * input: /
   * output: curNbPol, the number of garbage left on the screen
   */
  int getCurPollutionNb(){
    return _curNbPol;
  }

  /*
   * input: /
   * output: nbPol, the number of garbage initially present on the screen
   */
  int getPollutionNb(){
    return _nbPol;
  }

  /*
   * input: /
   * output: healthState, the Health object currently associated with Pollution
   */
  Health getHealthState(){
    return _healthState;
  }

}