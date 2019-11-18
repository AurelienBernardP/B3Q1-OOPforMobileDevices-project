import 'package:flutter/material.dart';
import 'Wallet.dart';
import 'Zone.dart';
import 'Health.dart';

abstract class Item {
  int _price;
  int _quantity;
  String _description;
  String _name;
  String _icon;

  void useItem(Object object);


  String getIcon() {
    return _icon;
  }

  String getName() {
    return _name;
  }

  String getDescription() {
    return _description;
  }

  String getPrice() {
    return _price.toString();
  }

  int getQuantity() {
    return _quantity;
  }

  bool buyItem() {
    if (Wallet().isSufficient(_price)) {
      _quantity += 1;
      Wallet().retrieveCoins(_price);
      return true;
    }
    return false;
  }

  bool removeItem(){
    if (_quantity > 0) {
      _quantity -= 1;
      //Wallet().addCoins(_price);
      return true;
    }
    return false;
  }
}

class WaterItem extends Item {
  static WaterItem _instance = WaterItem._internal();

  WaterItem._internal() {
    _price = 5;
    _quantity = 0;
    _description = "You can't possibly expect your plants to live without water...";
    _name = "Water";
    _icon = "assets/images/watericon.png";
  }

  static WaterItem getInstance() {
    if (_instance == null) {
      _instance = WaterItem._internal();
    }
    return _instance;
  }

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

class PineTree extends Item {
  static PineTree _instance;

  PineTree._internal() {
    _price = 50;
    _quantity = 0;
    _description = "Between every Pine tree there is a door leading to a new way of life.";
    _name = "Pine tree";
    _icon = "assets/images/pinetree.png";
  }

  static PineTree getInstance() {
    if (_instance == null) {
      _instance = PineTree._internal();
    }
    return _instance;
  }

  void useItem(covariant Zone zone){
    if (_quantity > 0) {
      zone.plantTree(_instance);
      _quantity -= 1;
    }
  }
}

class Cactus extends Item {
  static Cactus _instance;

  Cactus._internal() {
    _price = 20;
    _quantity = 0;
    _description = "Rough on the outside but soft on the inside... don't you love me?";
    _name = "Cactus";
    _icon = "assets/images/cactus.png";
  }

  static Cactus getInstance() {
    if (_instance == null) {
      _instance = Cactus._internal();
    }
    return _instance;
  }

  void useItem(covariant Zone zone) {
    if (_quantity > 0) {
      zone.plantTree(_instance);
      _quantity -= 1;
    }
  }
}

class ForestTree extends Item {
  static ForestTree _instance;

  ForestTree._internal() {
    _price = 40;
    _quantity = 0;
    _description = "I might look normal spoiled but I'll give you all I have";
    _name = "Tree";
    _icon = "assets/images/tree.png";
  }

  static ForestTree getInstance() {
    if (_instance == null) {
      _instance = ForestTree._internal();
    }
    return _instance;
  }

  void useItem(covariant Zone zone) {
    if (_quantity > 0) {
      zone.plantTree(_instance);
      _quantity -= 1;
    }
  }
}

class MiniPlant extends Item {
  static MiniPlant _instance;

  MiniPlant._internal() {
    _price = 10;
    _quantity = 0;
    _name = "Mini Plant";
    _description = "Don't you need some green on your way?";
    _icon = "assets/images/18.png";
  }

  static MiniPlant getInstance() {
    if (_instance == null) {
      _instance = MiniPlant._internal();
    }
    return _instance;
  }

  void useItem(covariant Zone zone) {
    if (_quantity > 0) {
      zone.plantTree(_instance);
      _quantity -= 1;
    }
  }
}

class NurishementItem1 extends Item {
  static NurishementItem1 _instance;

  NurishementItem1._internal() {
    _price = 10;
    _quantity = 0;
    _description = "Don't let my appearence fool you... I can make all the tables turn.";
    _name = "Nurishement";
    _icon = "assets/images/food1icon.png";
  }

  static NurishementItem1 getInstance() {
    if (_instance == null) {
      _instance = NurishementItem1._internal();
    }
    return _instance;
  }

  bool useItem(covariant Health healthbar){
    if (_quantity > 0) {
      if(healthbar.nurishTree(1)){
        _quantity -= 1;
        return true;
      }
    }
      return false;
  }
}

class NurishementItem2 extends Item {
  static NurishementItem2 _instance;

  NurishementItem2._internal() {
    _price = 10;
    _quantity = 0;
    _description = "Don't let my appearence fool you... I can make all the tables turn.";
    _name = "Nurishement";
    _icon = "assets/images/food2icon.png";
  }

  static NurishementItem2 getInstance() {
    if (_instance == null) {
      _instance = NurishementItem2._internal();
    }
    return _instance;
  }

  bool useItem(covariant Health healthbar){
    if (_quantity > 0) {
      if(healthbar.nurishTree(1)){
        _quantity -= 1;
        return true;
      }
    }
      return false;
  }
}

class RepairItem extends Item {
  static RepairItem _instance;

  RepairItem._internal() {
    _price = 50;
    _quantity = 0;
    _description = "I won't bite you I promise!";
    _name = "Trap";
    _icon = "assets/images/repair.png";
  }

  static RepairItem getInstance() {
    if (_instance == null) {
      _instance = RepairItem._internal();
    }
    return _instance;
  }

  bool useItem(covariant Health healthbar){
    if (_quantity > 0) {
      if(healthbar.cleanTree()){
        _quantity -= 1;
        return true;
      }
    }
      return false;
  }
}
