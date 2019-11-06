import 'package:flutter/material.dart';
import 'Wallet.dart';
import 'Zone.dart';


abstract class Item {
  int _price;
  int _quantity;
  String _name;
  String _icon;

  //void useItem(Object object);


  String get_icon() {
    return _icon;
  }

  String get_name() {
    return _name;
  }

  String get_price() {
    return _price.toString();
  }

  String get_quantity() {
    return _quantity.toString();
  }

  void buyItem() {
    if (Wallet().isSufficient(_price)) {
      _quantity += 1;
      Wallet().retrieveCoins(_price);
    }
  }

  void sellItem() {
    if (_quantity > 0) {
      _quantity -= 1;
      Wallet().addCoins(_price);
    }
  }
}

class WaterItem extends Item {
  static WaterItem _instance = WaterItem._internal();

  WaterItem._internal() {
    _price = 5;
    _quantity = 0;
    _name = "Water";
    _icon = "assets/images/water.png";
  }

  static WaterItem getInstance() {
    if (_instance == null) {
      _instance = WaterItem._internal();
    }
    return _instance;
  }

  /*void useItem(Tree tree) {
    if (_quantity > 0) {
      //tree.hydrate();
      _quantity -= 1;
    }
  }*/
}

class PlantItem extends Item {
  static PlantItem _instance;

  PlantItem._internal() {
    _price = 10;
    _quantity = 0;
    _name = "Plant";
    _icon = "assets/images/plant.png";
  }

  static PlantItem getInstance() {
    if (_instance == null) {
      _instance = PlantItem._internal();
    }
    return _instance;
  }

  /*void useItem(covariant Zone zone) {
    if (_quantity > 0) {
      //zone.plant_tree(new Tree(PlantItem));
      _quantity -= 1;
    }
  }*/
}

class NurishementItem extends Item {
  static NurishementItem _instance;

  NurishementItem._internal() {
    _price = 15;
    _quantity = 0;
    _name = "Nurishement";
    _icon = "assets/images/food.png";
  }

  static NurishementItem getInstance() {
    if (_instance == null) {
      _instance = NurishementItem._internal();
    }
    return _instance;
  }

  /*void useItem(Tree tree) {
    if (_quantity > 0) {
      //tree.nurish();
      _quantity -= 1;
    }
  }*/
}

class TrapItem extends Item {
  static TrapItem _instance;

  TrapItem._internal() {
    _price = 35;
    _quantity = 0;
    _name = "Trap";
    _icon = "assets/images/trap.png";
  }

  static TrapItem getInstance() {
    if (_instance == null) {
      _instance = TrapItem._internal();
    }
    return _instance;
  }

  /*void useItem(Tree tree) {
    if (_quantity > 0) {
      //tree.trap();
      _quantity -= 1;
    }
  }*/
}