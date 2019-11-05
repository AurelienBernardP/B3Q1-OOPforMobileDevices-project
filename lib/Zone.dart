import 'Characteristic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Zone{

  Characteristic type;
  int plantedTree = 0;
  bool locked = true;

  Zone(Characteristic type){
    this.type = type;
  }

  bool is_locked(){
    return locked;
  }

  void unlock(){
    locked = false;
  }

  bool is_planted(){
    if (plantedTree != 0)
      return true;
    return false;
  }

  /*void plant_tree(Tree tree){
    if(!is_locked)
      plantedTree = tree;
  }*/

  /*void remove_tree(){
    plantedTree = null;
  }*/

  Widget buildZone(BuildContext context){
    return this.type.buildCharacteristic(context);
  }

  Characteristic get_zone_type(){
    return type;
  }
  
}