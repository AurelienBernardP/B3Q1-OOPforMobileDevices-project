import 'Wallet.dart';
import 'Save.dart';
import 'Zone.dart';
import 'Health.dart';

/*
 * Item class
 * Attributes:
 *    price: an integer representing the price of the item
 *    quantity: an integer representing the amount of that item the user has
 *    description: a small description of the item
 *    name: the name of the item
 *    icon: the image associated with the item
 */

abstract class Item {
  int _price;
  int _quantity;
  String _description;
  String _name;
  String _icon;

  /*
   * input: object
   * effect: uses the item
   */
  void useItem(Object object);

  /*
   * input: /
   * output: icon, the path to the image associated with the Item
   */
  String getIcon() {
    return _icon;
  }

  /*
   * input: /
   * output: name, the name of the Item
   */
  String getName() {
    return _name;
  }

  /*
   * input: /
   * output: description, a small description of the Item
   */
  String getDescription() {
    return _description;
  }

  /*
   * input: /
   * output: price, the price of the Item as a string
   */
  String getPrice() {
    return _price.toString();
  }

  /*
   * input: /
   * output: quantity, the quantity of the Item
   */
  int getQuantity() {
    return _quantity;
  }

  /*
   * input: /
   * output: returns true if the item was bought successfully, returns false otherwise
   */
  bool buyItem() {
    if (Wallet().isSufficient(_price)) {
      _quantity += 1;
      Wallet().retrieveCoins(_price);
      return true;
    }
    return false;
  }

}

/*
 * WaterItem class
 * Attributes:
 *    has the same attributes as Item class
 */
class WaterItem extends Item {
  static WaterItem _instance = WaterItem._internal();

  //private constructor, initialising WaterItem for the first time
  WaterItem._internal() {
    _price = 5;
    _description = "You can't possibly expect your plants to live without me...";
    _name = "Water";
    _icon = "assets/images/watericon.png";
    _quantity = Save().getInventory(_name);
  }

  /*
   * input: /
   * output: the instance of WaterItem
   */
  static WaterItem getInstance() {
    if (_instance == null) {
      _instance = WaterItem._internal();
    }
    return _instance;
  }

  /*
   * input: healthbar, the health that should be affected by the usage of water
   * output: true if the item was successfully used
   */
  bool useItem(covariant Health healthbar){
        if (_quantity > 0) {
      if(healthbar.hydrateTree(1)){
        _quantity -= 1;
        return true;
      }
    }
      return false;
  }
}


/*
 * RainItem class
 * Attributes:
 *    has the same attributes as Item class
 */
class RainItem extends Item {
  static RainItem _instance = RainItem._internal();

  //private constructor, initialising RainItem for the first time
  RainItem._internal() {
    _price = 15;
    _description = "With me around, you won't miss anyone else, trust me.";
    _name = "Rain";
    _icon = "assets/images/rain.png";
    _quantity = Save().getInventory(_name);
  }

  /*
   * input: /
   * output: the instance of RainItem
   */
  static RainItem getInstance() {
    if (_instance == null) {
      _instance = RainItem._internal();
    }
    return _instance;
  }
  /*
   * input: healthbar, the health that should be affected by the usage of the rain
   * output: true if the item was successfully used
   */
  bool useItem(covariant Health healthbar){
    if (_quantity > 0) {
      if(healthbar.hydrateTree(5)){
        _quantity -= 1;
        return true;
      }
    }
      return false;
  }
}

/*
 * PineTree class
 * Attributes:
 *    has the same attributes as Item class
 */
class PineTree extends Item {
  static PineTree _instance;

  //private constructor, initialising PineTree for the first time
  PineTree._internal() {
    _price = 50;
    _description = "Everyone wants me during the holidays but few take care of me.";
    _name = "Pine tree";
    _icon = "assets/images/pinetree.png";
    _quantity = Save().getInventory(_name);

  }

  /*
   * input: /
   * output: the instance of PineTree
   */
  static PineTree getInstance() {
    if (_instance == null) {
      _instance = PineTree._internal();
    }
    return _instance;
  }

  /*
   * input: zone, the zone the tree is being planted on
   * effect: reduces the quantity of the item by one 
   */
  void useItem(covariant Zone zone){
    if (_quantity > 0) 
      _quantity -= 1;
  }

}

/*
 * Cactus class
 * Attributes:
 *    has the same attributes as Item class
 */
class Cactus extends Item {
  static Cactus _instance;

  //private constructor, initialising Cactus for the first time
  Cactus._internal() {
    _price = 20;
    _description = "Rough on the outside but soft on the inside... don't you love me?";
    _name = "Cactus";
    _icon = "assets/images/cactus.png";
    _quantity = Save().getInventory(_name);
  }

  /*
   * input: /
   * output: the instance of Cactus
   */
  static Cactus getInstance() {
    if (_instance == null) {
      _instance = Cactus._internal();
    }
    return _instance;
  }

  /*
   * input: zone, the zone the tree is being planted on
   * effect: reduces the quantity of the item by one 
   */
  void useItem(covariant Zone zone) {
    if (_quantity > 0) 
      _quantity -= 1;
  }

}

/*
 * ForestTree class
 * Attributes:
 *    has the same attributes as Item class
 */
class ForestTree extends Item {
  static ForestTree _instance;

  //private constructor, initialising ForestTree for the first time
  ForestTree._internal() {
    _price = 40;
    _description = "There is a reason why so many of us are out there!";
    _name = "Forest tree";
    _icon = "assets/images/tree.png";
    _quantity = Save().getInventory(_name);

  }

  /*
   * input: /
   * output: the instance of ForestTree
   */
  static ForestTree getInstance() {
    if (_instance == null) {
      _instance = ForestTree._internal();
    }
    return _instance;
  }

  /*
   * input: zone, the zone the tree is being planted on
   * effect: reduces the quantity of the item by one 
   */
  void useItem(covariant Zone zone) {
    if (_quantity > 0) {
      _quantity -= 1;
    }
  }
}

/*
 * MiniPlant class
 * Attributes:
 *    has the same attributes as Item class
 */
class MiniPlant extends Item {
  static MiniPlant _instance;

  //private constructor, initialising MiniPlant for the first time
  MiniPlant._internal() {
    _price = 10;
    _name = "Mini Plant";
    _description = "Make sure you get some greens on your way before you go!";
    _icon = "assets/images/18.png";
    _quantity = Save().getInventory(_name);
  }

  /*
   * input: /
   * output: the instance of MiniPlant
   */
  static MiniPlant getInstance() {
    if (_instance == null) {
      _instance = MiniPlant._internal();
    }
    return _instance;
  }

  /*
   * input: zone, the zone the tree is being planted on
   * effect: reduces the quantity of the item by one 
   */
  void useItem(covariant Zone zone) {
    if (_quantity > 0)
      _quantity -= 1;
  }

}

/*
 * NurishementItem1 class
 * Attributes:
 *    has the same attributes as Item class
 */
class NurishementItem1 extends Item {
  static NurishementItem1 _instance;

  //private constructor, initialising Nurishement1 for the first time
  NurishementItem1._internal() {
    _price = 10;
    _quantity = 0;
    _name = 'Nurishment 1';
    _description = "Don't let my appearence fool you... I can actually make it better.";
    _icon = "assets/images/food1icon.png";
    _quantity = Save().getInventory(_name);
  }

  /*
   * input: /
   * output: the instance of NurishementItem1
   */
  static NurishementItem1 getInstance() {
    if (_instance == null) {
      _instance = NurishementItem1._internal();
    }
    return _instance;
  }

  /*
   * input: healthbar, the health that should be affected by the usage of nurishement1
   * output: true if the item was successfully used
   */
  bool useItem(covariant Health healthbar){
    if (_quantity > 0) {
      if(healthbar.nurishTree(150)){
        _quantity -= 1;
        return true;
      }
    }
      return false;
  }
}

/*
 * NurishementItem2 class
 * Attributes:
 *    has the same attributes as Item class
 */
class NurishementItem2 extends Item {
  static NurishementItem2 _instance;

  //private constructor, initialising Nurishement2 for the first time
  NurishementItem2._internal() {
    _price = 30;
    _description = "I ain't no apple but I still keep the doctors away!";
    _name = "Nurishment 2";
    _icon = "assets/images/food2icon.png";
    _quantity = Save().getInventory(_name);
  }

  /*
   * input: /
   * output: the instance of NurishementItem2
   */
  static NurishementItem2 getInstance() {
    if (_instance == null) {
      _instance = NurishementItem2._internal();
    }
    return _instance;
  }

  /*
   * input: healthbar, the health that should be affected by the usage of nurishement2
   * output: true if the item was successfully used
   */
  bool useItem(covariant Health healthbar){
    if (_quantity > 0) {
      if(healthbar.nurishTree(500)){
        _quantity -= 1;
        return true;
      }
    }
      return false;
  }
}

/*
 * RepairItem class
 * Attributes:
 *    has the same attributes as Item class
 */
class RepairItem extends Item {
  static RepairItem _instance;

  //private constructor, initialising RepairItem for the first time
  RepairItem._internal() {
    _price = 15;
    _description = "Water, food, water, repeat... don't you want to spice things up a bit?";
    _name = "Cleanser";
    _icon = "assets/images/repair.png";
    _quantity = Save().getInventory(_name);
  }

  /*
   * input: /
   * output: the instance of RepairItem
   */
  static RepairItem getInstance() {
    if (_instance == null) {
      _instance = RepairItem._internal();
    }
    return _instance;
  }

  /*
   * input: healthbar, the health that should be affected by the cleaning
   * output: true if the item was successfully used
   */
  bool useItem(covariant Health healthbar){
    if (_quantity > 0) {
      if(healthbar.isPolluted()){
        _quantity -= 1;
        return true;
      }
    }
      return false;
  }
  
}
