import 'package:encrypt/encrypt.dart';
import 'package:first/Characteristic.dart';
import 'package:first/Item.dart';
import 'TreeBackEnd.dart';
import 'Characteristic.dart';
import 'Characteristics/allCharacteristics.dart';
import 'package:path_provider/path_provider.dart';
import 'Zone.dart';
import 'Item.dart';
import 'TreeList.dart';
import "dart:core";
import 'Wallet.dart';
import 'Health.dart';
import 'dart:io';
import 'Timer.dart';
import 'PlanetBackEnd.dart';

/* Save  class
 * 
 * Singleton class which handles saving and loading the necessary data of the game
 * 
 * Attributes :
 *  _wallet: an integer determinating the amount of the wallet of a save
 *  _nbZoneUnlocked: an integer indicating the number of zone unlocked of a save
 *  _timeCreated: the date of the save
 *  _inventory: a list of integers representing the quantities of all items of a save
 *  _worldMap: a list of list of Zone representing the state of the map of a save
 */
class Save {
  int _wallet;
  int _nbZoneUnlocked;
  DateTime _timeCreated;
  List<int> _inventory;
  List<List<Zone>> _worldMap;

  static final Save _singleton = Save._internal();

  /*Save
  * input: /
  *
  * output: the instantiatesd class
  */
  factory Save() {
    return _singleton;
  }

  //private constructor, initialising Save for the first time
  Save._internal() {
    TreeList();
    _inventory = new List();
    _nbZoneUnlocked = 0;
    _worldMap = new List.generate(10, (_) => new List(10));
  }

  /* reset
  * input: /
  *
  * effect: resets the attributes of the save
  */
  void reset() {
    TreeList().reset();
    _inventory = new List();
    _nbZoneUnlocked = 0;
    _worldMap = new List.generate(10, (_) => new List(10));
  }

  /* _getZoneType
  * input: 
  *   type: a string corresponding to the first letter of the name of a zone type
  *
  * output: the instance of the Zone corresponding to the given character
  */
  CharacteristicBackEnd _getZoneType(String type) {
    switch (type) {
      case 'D':
        return Desert();
        break;
      case 'F':
        return Forest();
        break;
      case 'P':
        return Path();
        break;
      case 'R':
        return River();
        break;
      case 'S':
        return Snowy();
        break;
      default:
        print("Error format");
        return null;
    }
  }

  /* _getTreeType
  * input: 
  *   type: a string corresponding to the first letter of the name of a tree type
  *
  * output: the instance of the Tree corresponding to the given character
  */
  Item _getTreeType(String type) {
    switch (type) {
      case 'F':
        return ForestTree.getInstance();
        break;
      case 'C':
        return Cactus.getInstance();
        break;
      case 'P':
        return PineTree.getInstance();
        break;
      case 'M':
        return MiniPlant.getInstance();
        break;
      default:
        print("Error format tree");
        return null;
    }
  }

  /* emergencyRecovery
  * input: /
  *
  * output: a string corresponding to the format of the initial save
  */
  String emergencyRecovery() {
    return dateToString(DateTime.now()) +
        ",100,0,0,0,0,0,0,0,0,0,F1+F1+F1+F1+F1+F1+F1+F1+P1+P1+F1+F1+F1+F1+F1+F1+F1+F1+P1+D1+R1+R1+R1+F1+F1+F1+F1+P1+D1+D1+F1+F1+R1+F1+F1+P1+P1+D1+D1+D1+F1+F1+R1+F1+P1+D1+D1+D1+D1+D1+F1+F1+R1+F1+P1+D1+D1+D1+D1+D1+F1+F1+R1+P1+P1+P1+P1+P1+P1+P1+R1+R1+R1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+S1+";
  }

  /* dateToString
  * input: 
  *     date: a date
  *
  * output: a string containing the date in a specific format
  */
  String dateToString(DateTime date) {
    String dateString;
    dateString = date.year.toString() + '|';
    dateString += date.month.toString() + '|';
    dateString += date.day.toString() + '|';
    dateString += date.hour.toString() + '|';
    dateString += date.minute.toString() + '|';
    dateString += date.second.toString() + '|';
    dateString += date.millisecond.toString() + '|';
    dateString += date.microsecond.toString();

    return dateString;
  }

  /* readGame
  * input: 
  *   userData: a string corresponding to a save represented in a specific format
  *
  * output: 
  *   true: the loading from the given save is succesful
  *   false: the given save is not corrects
  */
  bool readGame(String userData) {
    //if file does not exist
    if (userData == null) return false;

    List<String> gameState = userData.split(",");
    if (gameState.length != 12) return false;

    //Init wallet
    _wallet = int.parse(gameState[1]);
    if (_wallet == null) return false;

    //Init inventory
    int i;
    for (i = 2; i < 11; i++) {
      int quantity = int.parse(gameState[i]);
      if (quantity == null) return false;
      _inventory.add(quantity);
    }

    //Init worldmap worldmap & treelist
    List<String> contentGame = gameState[11].split('+');
    if (contentGame.length != 101) return false;
    int m = 0;
    for (int k = 0; k < 10; k++) {
      for (int l = 0; l < 10; l++) {
        if (contentGame[m][1] != '1' && contentGame[m][1] != '0') return false;
        bool zoneIsLocked = (contentGame[m][1] == '1');
        if (_getZoneType(contentGame[m][0]) == null) return false;
        Zone zone = new Zone(Characteristic(_getZoneType(contentGame[m][0])),
                                            isLocked: zoneIsLocked);
        if (!zoneIsLocked) {
          _nbZoneUnlocked++;
          if (int.parse(contentGame[m][2]) == 1) {
            Item treeType = _getTreeType(contentGame[m][3]);
            if (treeType == null) return false;

            List<String> contentTree = contentGame[m].split('-');
            if (contentTree.length != 6) return false;

            //Content Tree: X - name - [healthInfo]
            String name = contentTree[1];

            if (double.parse(contentTree[2]) == null) return false;
            if (double.parse(contentTree[3]) == null) return false;
            if (contentTree[4] != "true" && contentTree[4] != "false") return false;
            if (double.parse(contentTree[5]) == null) return false;

            Health health = Health(hydration: double.parse(contentTree[2]),
                                   nutrition: double.parse(contentTree[3]),
                                   isPolluted: (contentTree[4] == "true"),
                                   nbPollutions: int.parse(contentTree[5]));

            TreeBackEnd tree = TreeBackEnd(zone: zone, tree: treeType,
                                           name: name, health: health);

            zone.plantTree(treeType, treeInfo: tree);
          }
        }
        m++;
        _worldMap[k][l] = zone;
      }
    }

    //Elapsed minute between this save and now
    int elapsedTimeMinute = DateTime.now().difference(_timeCreated).inMinutes;
    for (int i = 0; i < elapsedTimeMinute; i++)
      TimersForTrees().updateStateTrees();

    return true;
  }

  /* saveGame
  * input: /
  *
  * effect: save the game in an encrypted string based
  *         on a specific format containg the date of the game
  */
  void saveGame() async {
    //Add wallet amount
    String dataToSave = dateToString(DateTime.now()) + ',';
    dataToSave += Wallet().getCoins().toString() + ',';

    //Add inventory
    dataToSave += Cactus.getInstance().getQuantity().toString() + ',';
    dataToSave += ForestTree.getInstance().getQuantity().toString() + ',';
    dataToSave += PineTree.getInstance().getQuantity().toString() + ',';
    dataToSave += MiniPlant.getInstance().getQuantity().toString() + ',';
    dataToSave += WaterItem.getInstance().getQuantity().toString() + ',';
    dataToSave += RainItem.getInstance().getQuantity().toString() + ',';
    dataToSave += NurishementItem1.getInstance().getQuantity().toString() + ',';
    dataToSave += NurishementItem2.getInstance().getQuantity().toString() + ',';
    dataToSave += RepairItem.getInstance().getQuantity().toString() + ',';

    //Add worldmap & treelist
    List<List<Zone>> worldMap = PlanetBackEnd.getInstance().getGrid();
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        Zone currentZone = worldMap[i][j];
        dataToSave += currentZone.getZoneType()[0]; //D: Desert, S: Snowy,...
        if (currentZone.isLocked())
          dataToSave += '1';
        else {
          dataToSave += '0';
          if (!currentZone.isPlanted())
            dataToSave += '0';
          else {
            dataToSave += '1';
            dataToSave += currentZone.getTreeType()[0] +'-'; //C: Cactus, F: ForestTree,...
            
            TreeBackEnd currentTree = currentZone.getTreeScreen();
            dataToSave += currentTree.getName() + '-';

            Health currentHealth = currentTree.getHealth();
            dataToSave += currentHealth.getHydration().toString() + '-';
            dataToSave += currentHealth.getNutrition().toString() + '-';
            dataToSave += currentHealth.isPolluted().toString() + '-';
            dataToSave += currentHealth.getNbPollutions().toString();
          }
        }
        dataToSave += '+';
      }
    }

    //Ecrypting data with a key
    String key = '201640382014185520176639.Caramel';
    final keyEncrypter = Key.fromUtf8(key);
    final iv = IV.fromLength(16);
    Encrypter encrypter = Encrypter(AES(keyEncrypter));

    Encrypted encrypted = encrypter.encrypt(dataToSave, iv: iv);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/user.txt');

    await file.writeAsString(encrypted.base64);
  }

  /*Getter
   * input: /
   * output: the wallet of the save
   */
  int getWallet() {
    return _wallet;
  }

  /*Getter
   * input: /
   * output: the number of zone unlocked of the map from the save
   */
  int getNbZoneUnlocked() {
    return _nbZoneUnlocked;
  }

  /*Getter
   * input: 
   *    itemName: the name of an item
   * 
   * output: the quantity of the item corresponding to the given name 
   */
  int getInventory(String itemName) {
    switch (itemName) {
      case 'Cactus':
        return _inventory[0];
        break;
      case 'Forest tree':
        return _inventory[1];
        break;
      case 'Pine tree':
        return _inventory[2];
        break;
      case 'Mini Plant':
        return _inventory[3];
        break;
      case 'Water':
        return _inventory[4];
        break;
      case 'Rain':
        return _inventory[5];
        break;
      case 'Nurishment 1':
        return _inventory[6];
        break;
      case 'Nurishment 2':
        return _inventory[7];
        break;
      case 'Cleanser':
        return _inventory[8];
        break;
      default:
        print("Error format " + itemName);
        return 0;
    }
  }

  /*Getter
   * input: 
   * 
   * output: the state of map from the save
   */
  List<List<Zone>> getWorldMap() {
    return _worldMap;
  }
}
