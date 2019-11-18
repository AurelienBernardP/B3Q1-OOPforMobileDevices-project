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
    _description = "You can't possibly expect your plants to live without me...";
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

class RainItem extends Item {
  static RainItem _instance = RainItem._internal();

  RainItem._internal() {
    _price = 15;
    _quantity = 0;
    _description = "With me around, you won't miss anyone else, trust me.";
    _name = "Water";
    _icon = "assets/images/rain.png";
  }

  static RainItem getInstance() {
    if (_instance == null) {
      _instance = RainItem._internal();
    }
    return _instance;
  }

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

class PineTree extends Item {
  static PineTree _instance;

  PineTree._internal() {
    _price = 50;
    _quantity = 0;
    _description = "Everyone wants me during the holidays but very few take care of me.";
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
    _description = "There is a reason why so many of us are out there!";
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
    _description = "Make sure you get some greens on your way before you go!";
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
    _description = "Don't let my appearence fool you... I can actually make it better.";
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
    _price = 30;
    _quantity = 0;
    _description = "I ain't no apple but I still keep the doctors away!";
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
      if(healthbar.nurishTree(5)){
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
    _description = "Water water water food repeat... Don't you want to spice things up a bit?";
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
